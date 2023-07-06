public class StringArrayTest {
  public static List<string> generateStringArray(Integer n)
  {
      List<string> l = new List<string>();
     for(integer i=0;i<n;i++)
     {
         l.add('Test '+i);
         System.debug(l[i]);
     }
      return l;
  }
}