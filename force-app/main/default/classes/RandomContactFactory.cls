public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer a,String b){
        List<Contact> con = new List<Contact>();
        for(Integer i=0;i<a;i++){
            Contact c = new Contact(LastName=b);
            c.FirstName = 'Test'+i;
            con.add(c);
        }
        return con;
    }
}