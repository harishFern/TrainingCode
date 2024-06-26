public class emailTask {
    public static void eMail(){
        Messaging.SingleEmailMessage sem=new Messaging.SingleEmailMessage();
        String[] s=new String[]{'haris34326@gmail.com'};
        sem.setToAddresses(s);
        sem.setSubject('first mail');
        sem.setPlainTextBody('heyyyyyyy');
        Messaging.sendEmailResult[] r=Messaging.sendEmail(new Messaging.SingleEmailMessage[]{sem});
        result(r); 
    }
    public static boolean result(Messaging.sendEmailResult[] r){
        boolean b=true;
        for(Messaging.sendEmailResult r1:r){
            if(r1.isSuccess()){
                System.debug('success');
            }
            else{
                b=false;
                System.debug('failed'+r1.getErrors());
            }
        }
        return b;
    }
}