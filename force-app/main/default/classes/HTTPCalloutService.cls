public class HTTPCalloutService {

    public void sendData(String jsonString) {
        Http http = new Http();
        HttpRequest request = new HttpRequest(); 
        request.setEndpoint('callout:newNamed/services/apexrest/createAccountContact');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(jsonString);

        try {
            HttpResponse response = http.send(request);
            if (response.getStatusCode() != 201) {
                System.debug('Error: ' + response.getBody()); 
            } else {
                System.debug('Success: ' + response.getBody());
            }
        } catch (Exception e) {
            System.debug('Exception: ' + e.getMessage());
        }
    }
}