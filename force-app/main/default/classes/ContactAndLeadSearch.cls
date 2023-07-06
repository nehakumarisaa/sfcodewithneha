public class ContactAndLeadSearch{
  public static List<List<SObject>> searchContactsAndLeads(string str){
    //Contact con = new Contact(FirstName = 'William',LastName = 'Smith');
    //insert con;
    //Lead ld = new Lead(FirstName = 'John',LastName= 'Smith');
    //insert ld;
    List<List<SObject>> ls = [FIND :str IN NAME FIELDS RETURNING Contact,Lead];
    return ls;
  }
}