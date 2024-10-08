@isTest(seeAllData=false)
private class TemperatureConverterTest {
    @isTest static void testWarmTemp(){
        Decimal celsius = TemperatureConverter.FahrenheitToCelsius(70);
        System.assertEquals(21.11,celsius);
    }
    @isTest static void testNegativeTemp(){
        Decimal celsius = TemperatureConverter.FahrenheitToCelsius(-10);
        System.assertEquals(-23.33,celsius);
    }
}