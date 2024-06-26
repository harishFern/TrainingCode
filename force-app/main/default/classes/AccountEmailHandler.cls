public class AccountEmailHandler {
     public static void updateRecord(){ 
         List<Account> l=new List<Account>();
         Account a=new Account();
         a.Id='001dM000004As85QAC';
         a.CustomerPriority__c='High';
         l.add(a);
         Account a1=new Account();
         a1.Id='001dM000004581CQAQ';
         a1.CustomerPriority__c='High'; 
         l.add(a1);
         update l;
     }
    public void emails(List<String> ll){
        List<Contact> c=[select Email from Contact where AccountId in :ll];
        for(Contact cc:c){
        Messaging.SingleEmailMessage semail=new Messaging.SingleEmailMessage(); 
        semail.setSubject('customer priority');
        semail.setPlainTextBody('customer priority set to high');  
        semail.setToAddresses(new List<String>{cc.Email});
        system.debug(cc.Email);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{semail});
    }
 }
}