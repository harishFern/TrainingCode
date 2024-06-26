trigger Accountt on Account(before insert, after insert, before delete, after delete){
    if(trigger.isdelete){
        for(Account az:trigger.old){
            if(trigger.isbefore){
              System.debug('del: '+az);
            }
            if(trigger.isafter){
                System.debug('del: '+az);
            } 
        }
    }
}