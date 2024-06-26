public class AccountHandler {
    public static Account insertNewAccount(String accountName) {
        if(String.isBlank(accountName)){
            return null;
        }
        Account a=new Account(Name=accountName);
            try{
                insert a;
            }
            catch(DmlException e){
                return null;
            }
        return a;
    }
}