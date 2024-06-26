public class Flowapex {
    @invocablemethod
    public static List<Account> flowMethod(List<id> ids){
       return [select Name, Active__c, Email__c,Phone,Contact_Count__c from Account where id =: ids];        
    }
}