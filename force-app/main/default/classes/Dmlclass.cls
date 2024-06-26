public class Dmlclass {
    public static void updatedml(){
        List<Account> acc=[select id,Name from Account order by Name limit 1];
        for(Account ac:acc){
            ac.Name='aaliya khani';
        }
        update acc;
    }
    public static void deletedml(){
        List<Account> acc=[select id,Name from Account order by Name limit 1];
        
        delete acc;
    } 
}