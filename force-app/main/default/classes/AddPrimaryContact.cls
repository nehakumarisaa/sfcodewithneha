public class AddPrimaryContact implements queueable {
    private Contact c;
    private string stateAbbr; 
    
    public AddPrimaryContact(Contact con ,string abbr) {
        this.c = con;
        this.stateAbbr = abbr;
    }
    public void execute(QueueableContext context) {
        List<Account> accounts = [select Id,Name,(select Id, firstName, lastName from Contacts) from Account where BillingState =: stateAbbr LIMIT 200];
        List<Contact> contacts = new List<Contact>();
        for(Account acc : accounts){
            Contact cont = c.clone(false,false,false,false);
            cont.AccountId = acc.Id; 
            contacts.add(cont);
        }
        if(contacts.size() > 0){
            insert contacts;
        }
    } 
}