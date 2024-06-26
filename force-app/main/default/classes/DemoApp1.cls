@RestResource(urlMapping='/Account/*')
global with sharing class DemoApp1 {
    
    @HttpDelete
    global static void doDelete() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1); 
        Account account = [SELECT Id FROM Account WHERE Id = :accountId];
        delete account;
    }
    @HttpGet
    global static Account doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account result = [SELECT Id, Name, Phone, Website FROM Account WHERE Id = :accountId];
        return result;
    }
    @HttpPost
    global static String doPost(String name,Integer count,String mail) {
        Account acc = new Account(Name = name,Contact_Count__c= count,Email__c = mail);
        insert acc;
        return acc.Id;
    }
}