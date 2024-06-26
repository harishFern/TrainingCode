public class StringListTest {
    public static List<String> generateStringList(integer n){
        List<String> l=new List<String>();
        for(integer i=0;i<n;i++){
            l.add('Test '+ String.valueOf(i));
        }
      
        return l;
    }
}