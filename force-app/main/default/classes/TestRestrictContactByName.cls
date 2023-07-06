@isTest
private class TestRestrictContactByName {
    @isTest static void InvalidLastName(){
        Contact c = new Contact(LastName = 'INVALIDNAME');
        //Insert c;
        Database.SaveResult result = Database.insert(c,false);
        system.assert(!result.isSuccess());
    }
}