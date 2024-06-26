trigger ContactTrigger on Contact(after insert, after delete){
    
    if(trigger.isinsert)
    {
        List<String> l=new List<String>(); 
        for(Contact c:trigger.new)
        {
            if(trigger.isafter)
            {
                l.add(c.AccountId);
            }        
        }
        
        NewContact.commonupdate(l);    
    }
    if(trigger.isdelete){
        List<String> s=new List<String>(); 
        for(Contact c1:trigger.old){
            if(trigger.isafter){
                s.add(c1.AccountId);
            }        }
        NewContact.commonupdate(s);    }
    }