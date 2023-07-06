@isTest
public class AccountProcessorTest{
    @isTest
    public static void test_method(){
        Account acc = new Account();
        acc.name = 'Test Account';
        acc.SLA__c = 'Gold';
        insert acc;
        
        List<Contact> con = new List<Contact>();
        Contact con1 = new Contact();
        con1.Account = acc;
        con1.Lastname = 'Con1';
        Contact con2 = new Contact();
        con2.Account = acc;
        con2.Lastname = 'Con2';
        con.add(con1);
        con.add(con2);
        insert con; 
        
        Test.startTest();
        AccountProcessor.countContacts(acc.Id);
        Test.stopTest();
    }
}