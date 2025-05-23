trigger LeadQualifiedTrigger on Lead (after update) {
    List<Lead> qualifiedLeads = new List<Lead>();

    for (Lead l : Trigger.new) {
        Lead old = Trigger.oldMap.get(l.Id);
        if (l.Status == 'Qualified' && old.Status != 'Qualified' && String.isBlank(l.Surefire_ID__c)) {
            qualifiedLeads.add(l);
        }
    }

    if (!qualifiedLeads.isEmpty()) {
        System.enqueueJob(new SendLeadsToSurefireJob(qualifiedLeads));
    }
}
