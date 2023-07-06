@isTest
private class TestVerifyDate {
    @isTest static void CheckPastDate(){
        Date TestDate = VerifyDate.CheckDates(Date.newInstance(1993,1,17),Date.newInstance(1990,2,17));
        system.assertEquals(Date.newInstance(1993,1,31),TestDate);
    }
    @isTest static void CheckDateWithin30(){
        Date TestDate = VerifyDate.CheckDates(Date.newInstance(2015,1,14),Date.newInstance(2015,1,18));
        system.assertEquals(Date.newInstance(2015,1,18),TestDate);
    }
    @isTest static void CheckDateAfter30(){
        Date TestDate = VerifyDate.CheckDates(Date.newInstance(2015,1,14),Date.newInstance(2015,3,14));
        system.assertEquals(Date.newInstance(2015,1,31),TestDate);
    }
}