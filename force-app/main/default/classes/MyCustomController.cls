public class MyCustomController{
    public MyCustomController(){}
    
    @RemoteAction
    public static String createContact(String firstname, String lastname){
        Contact c = new Contact(FirstName = firstname, LastName = lastname);
        insert c;
        return c.id;
    }
}