public class Driver
{
   public static void main(String args[])
   {
      
      for (String a : args){
         System.out.println(a);
      }
      
      MainSimulator s = new MainSimulator();
      s.simulate(args);
   }
}