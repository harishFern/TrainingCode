public class Email {
    public static void email1(){
      
        Messaging.SingleEmailMessage semail=new Messaging.SingleEmailMessage(); 
     
        semail.setSubject('Export Account List');
        semail.setPlainTextBody('Please find the attached account document');
        String[] sendto=new String[] {'harish.nedunchelian@fernsoftware.com','vinoth.vadamalai@fernsoftware.com'}; 
        semail.setToAddresses(sendto);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{semail});
    }
}