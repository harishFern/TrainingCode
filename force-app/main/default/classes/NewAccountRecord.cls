public class NewAccountRecord {
    //S@invocablemethod  
    public static void deleteRecord(){
        Account azz=new Account();
        azz.Id='001dM0000045BJyQAM';
        azz.Name='vickyyyy';
        delete azz;
    }
    public static void updateRecord(){
        Account acc=new Account();
        acc.Id='001dM0000045BJyQAM';
        acc.Name='vickyyyy';
        acc.Phone='8760646072';
        acc.Email__c='vicky12@gmail.com';
        update acc;
    }
}