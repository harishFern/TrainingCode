@RestResource(urlMapping='/AccountInt/*')
global with sharing class RestAccountService {
    @HttpPost
    global static String receiveAccounts() {
        try {
            // Parse the JSON from the request body
            String jsonAccounts = RestContext.request.requestBody.toString();
            List<Account> accounts = (List<Account>) JSON.deserialize(jsonAccounts, List<Account>.class);
            
            // Insert the accounts and their related contacts
            List<Contact> contactsToInsert = new List<Contact>();
            for (Account acc : accounts) {
                insert acc; // Insert the account
                
                // Process the related contacts
                if (acc.Contacts != null) {
                    for (Contact con : acc.Contacts) {
                        con.AccountId = acc.Id; // Link contact to account
                        contactsToInsert.add(con);
                    }
                }
            }
            insert contactsToInsert; // Insert all contacts

            return 'Records processed successfully';
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
            RestContext.response.statusCode = 500;
            RestContext.response.responseBody = Blob.valueOf('Error processing records: ' + e.getMessage());
            return null;
        }
    }
}