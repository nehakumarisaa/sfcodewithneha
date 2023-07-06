public class ContactSearch{
  public static List<Contact> searchForContacts(String s1, String s2){
    List<Contact> lst= [select id,name from contact where LastName =:s1 AND MailingPostalCode =:s2];
    return lst;
  }
}