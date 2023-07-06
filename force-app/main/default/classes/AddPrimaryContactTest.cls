@isTest
private class AddPrimaryContactTest {
	@testSetup
    static void setup() {
        List<Account> accounts = new List<Account>();
        for(integer i=0;i<50;i++){
            Account acc1 = new Account(Name='Account'+i, SLA__c = 'Gold', BillingState ='NY');
            accounts.add(acc1);
        }
        for(integer i=50;i<100;i++){
            accounts.add(new Account(Name='Account'+i, SLA__c = 'Gold', BillingState ='CA'));
        }
        insert accounts;
    }
    static testMethod void test(){
        string str = 'CA';
        Contact con = new Contact(LastName='testcon');
        AddPrimaryContact updater = new AddPrimaryContact(con,str);
        Test.startTest();
        system.enqueueJob(updater);
        Test.stopTest();
        System.assertEquals(50, [select count() from Contact where accountID IN (SELECT id FROM Account WHERE BillingState = :str)]); 
    }
}