@isTest
private class LeadProcessorTest {
	@testSetup
    static void setup() {
        List<Lead> leads = new List<Lead>();
        for(integer i=0;i<200;i++) {
            leads.add(new Lead(Lastname='test'+i, Company='test company', Status='Working - Contacted'));
        }
        insert leads;
    }
    
    static testMethod void test() {
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id BatchId = Database.executeBatch(lp);
        Test.stopTest();
        system.assertEquals(200, [select count() from Lead where LeadSource = 'Dreamforce']);
    }
}