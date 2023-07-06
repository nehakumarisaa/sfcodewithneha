@isTest
public with sharing class LRC_TileStateControllerTest {
	@testSetup
    public static void createUser(){
        String sRoleName = '';
        String sProfileName= 'Standard User';
        User testUser = new User();
        testUser.Alias = 'testName';
        testUser.Email = 'testName@testsalesforce.org';
        testUser.EmailEncodingKey = 'UTF-8';
        testUser.LastName = 'User';
        testUser.FirstName = 'testName';
        testUser.LanguageLocaleKey = 'en_US';
        testUser.LocaleSidKey = 'en_US';
        testUser.ProfileId = [Select Id from Profile Where Name =: sProfileName  Limit 1].Id;
        testUser.TimeZoneSidKey = 'America/Los_Angeles';
        testUser.Username = 'testName@testsalesforce.org';
        if(String.isNotBlank(sRoleName)){
            testUser.UserRoleID = [Select Id from UserRole Where Name =: sRoleName Limit 1].Id;
        }
        if(testUser != null)
        	insert testUser;
        
    }
    
    @isTest 
    public static void createTestData(){
        User u = [SELECT Id FROM User WHERE Email = 'testName@testsalesforce.org'];
        System.runAs(u){
            Test.startTest();
            LRC_TileStateController.getCurrentUserView('TestApp');
            LRC_TileStateController.saveCurrentUserView('TestApp','This is a test state');
            System.assertNotEquals(null, u.Id); 
            Test.stopTest();
        }
    }
    

}