public class AccountRestSource {
	public static void sendData() {
        String jsonString = '{"Name": "muppudathi broo", "AccountNumber": "A0012", "AccountSource": "Web", "AnnualRevenue": 1000000, "BillingAddress": { "city": "San Francisco", "country": "USA", "postalCode": "94105", "state": "CA", "street": "123 Main St" }, "Description": "This is a sample account", "Fax": "+1 415-555-1234", "Industry": "Technology", "NumberOfEmployees": 100, "Ownership": "Private", "Phone": "+1 415-555-5678", "ShippingAddress": { "city": "San Francisco", "country": "USA", "postalCode": "94105", "state": "CA", "street": "123 Main St" }, "Sic": "1234", "Site": "Headquarters", "TickerSymbol": "SMP", "Type": "Customer", "Website": "http://www.sampleaccount.com", "Contacts": [ { "FirstName": "John", "LastName": "Doe", "AccountId": "001D000000IqhSLIAZ", "AssistantName": "Jane Doe", "AssistantPhone": "+1 415-555-6789", "Birthdate": "1985-05-20", "Department": "Sales", "Description": "John Doe is a key contact", "Email": "john.doe@example.com", "Fax": "+1 415-555-7890", "HomePhone": "+1 415-555-8901", "LeadSource": "Web", "MailingAddress": { "city": "San Francisco", "country": "USA", "postalCode": "94105", "state": "CA", "street": "456 Another St" }, "MobilePhone": "+1 415-555-9012", "OtherAddress": { "city": "San Francisco", "country": "USA", "postalCode": "94105", "state": "CA", "street": "789 Other St" }, "OtherPhone": "+1 415-555-0123", "Phone": "+1 415-555-1234", "Title": "Sales Manager" }, { "FirstName": "Jane", "LastName": "Smith", "AccountId": "001D000000IqhSLIAZ", "AssistantName": "John Smith", "AssistantPhone": "+1 415-555-3456", "Birthdate": "1990-08-15", "Department": "Marketing", "Description": "Jane Smith is a key contact", "Email": "jane.smith@example.com", "Fax": "+1 415-555-4567", "HomePhone": "+1 415-555-5678", "LeadSource": "Referral", "MailingAddress": { "city": "San Francisco", "country": "USA", "postalCode": "94105", "state": "CA", "street": "123 Main St" }, "MobilePhone": "+1 415-555-6789", "OtherAddress": { "city": "San Francisco", "country": "USA", "postalCode": "94105", "state": "CA", "street": "456 Another St" }, "OtherPhone": "+1 415-555-7890", "Phone": "+1 415-555-8901", "Title": "Marketing Director" }]}';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:credential/services/apexrest/Account/Insert/doPost');  
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