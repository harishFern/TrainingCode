@isTest
private class AccountManagerTest {
    //Helper method to create dummy record
    static Id createTestRecord(){
        //Create test record
        Account TestAcc = new Account(Name='Test Account', Phone='8786757657');
        insert TestAcc;
        List<Contact> conList = new List<Contact>();
        Contact TestCon = new Contact();
        for(Integer i=1;i<=3;i++){
            TestCon.LastName = 'Test Contact'+i;
            TestCon.AccountId = TestAcc.Id;
            //conList.add(TestCon);
            insert conList;//Its not best practice but I have use it for testing purposes
        }
        //insert conList;
        //insert TestAcc;
        system.debug(TestAcc.Id);
        return TestAcc.Id;
    } 
    
    //Method to test getAccount()
    @isTest static void getAccountTest(){
        Id recordId = createTestRecord();
        //setup a test request
        RestRequest request = new RestRequest();
        //set request properties
        request.requestURI = 'https://yourInstance.salesforce.com/services/apexrest/Accounts/' + recordId +'/contacts';
        request.httpMethod = 'GET';
        // Finally, assign the request to RestContext if used
        RestContext.request = request;
        //End test setup
        
        //Call the method
        Account thisAcc = AccountManager.getAccount();
        //Verify the result
        system.assert(thisAcc != null);
        system.assertEquals('Test Account', thisAcc.Name);
        //system.assertEquals(3, thisAcc.Contact__c.size()); how to get this
    }
}