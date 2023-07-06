trigger ExampleTrigger on Contact (after insert,after delete) {
    if(Trigger.isInsert){
        Integer recordCount = Trigger.New.size();
        EmailManager.sendMail('nkumari@deloitte.com','subject', recordCount+'records insered');
        
    }
    else if(Trigger.isDelete){
        Integer recordCount1 = Trigger.Old.size();
        EmailManager.sendMail('nkumari@deloitte.com','Trigger delete', recordCount1+'records deleted');
    }
}