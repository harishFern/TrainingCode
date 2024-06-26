@restresource(urlmapping='/harish/Accountresourc/')
Global class AccountTesting {
    @HttpGet
    global static List<Account> a(){
        List<Account> al=new List<Account>();
        Map<String,String> ms=RestContext.request.params;
        String s=ms.get('Id');
        al=[select Name,Email__c,Active__c from Account where Id=:s];
        return al;
    }
    @httpdelete
    global static String dlete(){
        List<Account> al=new List<Account>();
        Map<String,String> ma=RestContext.request.params;
        String s=ma.get('Id');
        al=[select Name from Account where id=:s];
        delete al;
        return 'pochu';
    }
    @httpPost
    global static void insertt(String name){
        Account a=new Account();
        a.Name=name;
        insert a;
    }
    @httpPut
    global static void Updatee(String name){
        Map<String,String> m=RestContext.request.params;
        String s=m.get('Id');
        Account a=new Account();
        a.Name=name;
        a.Id=s;
        update a;
    }
}