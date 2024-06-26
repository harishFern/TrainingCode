public class ContactCount {
    public static void insertRecord(){
        List<Contact> l=new List<Contact>();
        Contact c=new Contact();
        c.AccountId='001Bi00000EcLhhIAF';
        c.Salutation='mr';
        c.FirstName='monica';
        c.LastName='Gostamvide';
        l.add(c);
        insert l;
    }
    public static void deleteRecord(){
        List<Contact> lc1=new List<Contact>();
        Contact c2=[select id from Contact where id='001Bi00000EcLhhIAF'];
        lc1.add(c2);
        delete lc1;
    }
    public static void updateRecord(List<String> ls){
        if(ls.size()>0){
        List<Account> c1=[select Contact_Count__c,(select id from Contacts) from Account where id in :ls];
            for(Account cc:c1){
                cc.Contact_Count__c=cc.Contacts.size();
            }
             update c1;
        }
       
    }
}