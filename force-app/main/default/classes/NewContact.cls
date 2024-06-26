public class NewContact{
    public static void insertRecord(){
        List<Contact> l=new List<Contact>();
        Contact c=new Contact();
        c.AccountId='001dM000004581CQAQ';
        c.Salutation='mr';
        c.FirstName='har';
        c.LastName='ish';
        c.Email='hari@gmail.com';
        c.Phone='6383438574';
        l.add(c);
        Contact c1=new Contact();
        c1.AccountId='001dM000002o8KdQAI';                
        c1.Salutation='mr';
        c1.FirstName='vic';
        c1.LastName='ky';
        c1.Email='vicky@gmail.com';
        c1.Phone='1234567890';
        l.add(c1);
        insert l;
    }
    public static void deleteRecord(){
        List<Contact> ll=new List<Contact>();
        Contact c=[select id from Contact where Id='003dM000000gVpDQAU'];
        ll.add(c);
        Contact c1=[select id from Contact where Id='003dM000000gVpEQAU'];
        ll.add(c1);
        delete ll;
    }
    public static void commonupdate(List<String> l){
        if(l.size()>0){
            List<Account> l1=[select Contact_Count__c,(select id from Contacts) from Account where id in :l];
            for(Account a:l1){
                a.Contact_Count__c=a.Contacts.size();
            }
            if(l1.size()>0){
                update l1;
            } }  }
}