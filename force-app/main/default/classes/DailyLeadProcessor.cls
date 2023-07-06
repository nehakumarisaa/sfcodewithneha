global class DailyLeadProcessor implements Schedulable{
    public void execute(SchedulableContext ctx){
        List<Lead> leads = [Select Id,LeadSource from Lead where LeadSource = null];
        if(!leads.isEmpty()) {
            for(Lead l: leads) {
                l.LeadSource = 'Dreamforce';
            }
            update leads;
        }
    }
}