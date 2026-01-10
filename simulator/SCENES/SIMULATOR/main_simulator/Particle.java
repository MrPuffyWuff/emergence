public class Particle
{

   public static float test = 1;
   
   private Vector3 velocity;//Bhor's Radii's per ATU
   private Vector3 position;//Bhor's Radii
   private int charge;//Pranav's
   private double mass;//EM's
   
   public Particle(Vector3 poz, int chargeI, double massI)
   {
      position = poz;
      charge = chargeI;
      mass = massI;
      velocity = new Vector3(0, 0, 0);
   }
   
   public Particle(Vector3 poz, Vector3 vel, int chargeI, double massI)
   {
      position = poz;
      charge = chargeI;
      mass = massI;
      velocity = vel;
   }
   
   public int getCharge(){
      return charge;
   }
   
   public double getMass(){
      return mass;
   }
   
   public Vector3 getVelocity(){
      return velocity;
   }
   
   public Vector3 getPosition(){
      return position;
   }
   
   public void setVelocity(Vector3 iVel){
      velocity = iVel;
   }
   
   public void setPosition(Vector3 iPoz){
      position = iPoz;
   }
   
   public String toString()
   {
      return position + "_" + velocity + "_" + mass + "_" + charge;
   }

}