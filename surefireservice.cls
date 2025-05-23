public class SendLeadsToSurefireJob implements Queueable, Database.AllowsCallouts {
    private List<Lead> leads;

    public SendLeadsToSurefireJob(List<Lead> leads) {
        this.leads = leads;
    }

    public void execute(QueueableContext context) {
        for (Lead lead : leads) {
            HttpResponse res = SurefireAPIHelper.sendLeadToSurefire(lead);

            if (res != null && res.getStatusCode() == 200) {
                System.debug('Lead sent successfully');
            } else {
                System.debug('Failed to send lead: ' + res?.getBody());
            }
        }
    }
}
