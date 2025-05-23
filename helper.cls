public class SurefireAPIHelper {
    public static HttpResponse sendLeadToSurefire(Lead lead) {
        HttpRequest req = new HttpRequest();
        Http http = new Http();

        req.setEndpoint('callout:Surefire_API/v1/leads'); // Use Named Credential alias
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');

        // Pass API Key manually if Surefire requires it (adjust header name as needed)
        req.setHeader('Authorization', 'Bearer ' + getApiKey());

        Map<String, Object> payload = new Map<String, Object>{
            'firstName' => lead.FirstName,
            'lastName'  => lead.LastName,
            'email'     => lead.Email,
            'phone'     => lead.Phone,
            'externalId' => lead.Id
        };

        req.setBody(JSON.serialize(payload));

        try {
            HttpResponse res = http.send(req);
            return res;
        } catch (Exception e) {
            System.debug('Callout error: ' + e.getMessage());
            return null;
        }
    }

    private static String getApiKey() {
        // Replace with secure storage later
        return 'your-api-key';
    }
}
