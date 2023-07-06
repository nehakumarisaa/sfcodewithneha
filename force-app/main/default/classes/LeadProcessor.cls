global class LeadProcessor implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'select ID, LeadSource from Lead'
        );
    }
    global void execute(Database.BatchableContext bc, List<Lead> leadRecords) {
        //List<Lead> leads = new List<Lead>();
        for(Lead l : leadRecords) {
            l.LeadSource = 'Dreamforce';
        }
        update leadRecords;
    }
    global void finish(Database.BatchableContext bc) {
        
    }
}