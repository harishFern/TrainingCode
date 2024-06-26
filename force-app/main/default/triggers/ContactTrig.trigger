trigger ContactTrig on Contact (after insert,after delete) {
    if(trigger.isinsert){
         List<String> lc=new List<String>();
        for(Contact c:trigger.new){
            if(trigger.isafter){
                lc.add(c.AccountId);
            }
        }
        ContactCount.updateRecord(lc);
    }
    if(trigger.isdelete){
        List<String> ls=new List<String>();
        for(Contact c1:trigger.old){
            if(trigger.isafter){
                ls.add(c1.AccountId);
            }
        }
        ContactCount.updateRecord(ls);
    }
}