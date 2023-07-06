public class CountryCodeHelper {
  public static String getCountryCode(String country) {
    Country_Code__mdt mc = Country_Code__mdt.getInstance('Canada');
  
    return mc.Country_Code__c;
  }
}