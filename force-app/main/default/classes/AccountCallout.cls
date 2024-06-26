public class AccountCallout { 
    public static void sendAccounts(List<Account> accountJSON) { 
    String requestBody = JSON.serialize(accountJSON);
    String targetEndpoint= 'callout:salesNamed/services/apexrest/AccountInt'; 
    HttpRequest req= new HttpRequest();
    req.setEndpoint(targetEndpoint);
    req.setMethod('POST');
    req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId()); 
    req.setHeader('Content-Type', 'application/json');
    system.debug('accountsJson====>'+requestBody);
    req.setBody(requestBody);
    Http http = new Http();
    HttpResponse res= http.send(req);
        if (res.getstatusCode() != 200) {
    System.debug('Error sending accounts: '+res.getBody());
        } else {
    System.debug('Accounts sent successfully.' +res.getBody());
        }
        }
        }