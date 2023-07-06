@istest
public class Search_text
{
  static testMethod void testCreateContact()
  {
    Account a = new Account();
    a.name='Unit';
    insert a;
    Contact c= new Contact();
    c.lastname=a.name;
    c.accountId =a.id;
    insert c;
    
  }
}