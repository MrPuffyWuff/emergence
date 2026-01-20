
public class Vector3
{
   private double x;
   private double y;
   private double z;
   
   
   public Vector3(double ix, double iy, double iz)
   {
      x = ix;
      y = iy;
      z = iz;
   }
   
   public static Vector3 add(Vector3 a, Vector3 b){
      return new Vector3(a.x + b.x, a.y + b.y, a.z + b.z);
   }
   
   public static Vector3 subtract(Vector3 a, Vector3 b){
      return new Vector3(a.x - b.x, a.y - b.y, a.z - b.z);
   }
   
   public static double dot(Vector3 a, Vector3 b){
      return a.x * b.x + a.y * b.y + a.z * b.z;
   }
   
   public Vector3 scale(double k){
      return new Vector3(k * x, k * y, k * z);
   }
   
   public Vector3 divide(double k){
      return new Vector3(x / k, y / k, z / k);
   }
   
   public Vector3 normalized(){
      double l = length();
      return new Vector3(x / l, y / l, z / l);
   }
   
   public double length(){
      return Math.sqrt(x * x + y * y + z * z);
   }
   
   public double lengthSquared(){
      return x * x + y * y + z * z;
   }
   
   public String toString()
   {
      return x + "," + y + "," + z;
   }
   
}