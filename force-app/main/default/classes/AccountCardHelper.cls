public class AccountCardHelper{
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList(Id recordId){
        List<Account> accountList=[select Id,Name,Phone,Website,AnnualRevenue from Account where Id=:recordId];
        return accountList;
    }
}