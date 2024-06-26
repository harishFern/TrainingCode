trigger AccountTrigger on Account (before update, after update) {
    AccountEmailHandler ax=new AccountEmailHandler();
    if(trigger.isupdate){
            List<String> s1=new List<String>(); 
        for(Account a1:trigger.new){
            if(trigger.isafter){
                 if(a1.CustomerPriority__c=='High' && a1.Active__c==true){
                      s1.add(a1.Id);
                }
                              
            }
        }       
        ax.emails(s1);
    }    
}