import java.io.FileWriter;
import java.io.IOException;


public class MainSimulator
{   
   private boolean isSimulationRunning;
   
   // private Particle[] particles= {
//          //A bunch of cool protons
//          new Particle(new Vector3(0,0,0), 1, 1836.15),
//          new Particle(new Vector3(1,0,0), 1, 1836.15),
//          new Particle(new Vector3(0,0,1), 1, 1836.15),
//          new Particle(new Vector3(0,2,0), 1, 1836.15),
//          new Particle(new Vector3(3,1.5,4), 1, 1836.15),
//          //A bunch of cool electrons
//          new Particle(new Vector3(-0.67,1,0), -1, 1),//youre welcome pranav
//          new Particle(new Vector3(0,-1,0), -1, 1),
//          new Particle(new Vector3(1,3,0), -1, 1),
//          new Particle(new Vector3(-2,0,1), -1, 1),
//       };
   private Particle[] particles= {
         //A bunch of cool protons
         new Particle(new Vector3(0,0,0), 1, 1836.15),
         //A bunch of cool electrons
         new Particle(new Vector3(0,5,0), -1, 1836.15)
      };
   
   private String output;
   
   private int frame;
   private int totalFrames;
   
   private double time_step = 0.5;
   
   
   public MainSimulator(){
      //Save initial frame
      isSimulationRunning = true;
      frame = 0;
      totalFrames = 1000;
      output = "Simulation_ID-0_NAME-TEST\n";
      output += "Particle Count: " + particles.length + "\n";
      //particles = new Particle[0];
      saveFrame();
   }
   
   public void simulate(String args[])
   {  
      //Running simulation
      while (isSimulationRunning){
         //Apply coulombs force to every particle
         for (Particle aPart : particles){
            for (Particle bPart : particles){
               if (aPart.equals(bPart)) 
                  continue;
               applyCoulombsForce(aPart, bPart);
            }
         }
         
         //Move every particle given the velocity
         for (Particle p : particles){
            p.setPosition( Vector3.add(p.getVelocity(), p.getPosition()) );
         }
         
         //Tick to next frame
         frame++;
         saveFrame();
         //End simulation if desired frame count reached
         if (frame == totalFrames){
            isSimulationRunning = false;
            System.out.println("Simulation Complete. Saving...");
            try {
               FileWriter myWriter = new FileWriter("filename.txt");
               myWriter.write(output);
               myWriter.close();  // must close manually
               System.out.println("Simulation Result Saved");
            } catch (IOException e) {
               System.out.println("An error occurred.");
               e.printStackTrace();
            }
         }
         else if (frame % 10 == 0){
            System.out.println(frame / (float)(totalFrames) + "% Complete");
         }
      }
   }
      
   public void applyCoulombsForce(Particle aPart, Particle bPart)
   {  
      int q1 = aPart.getCharge();
      int q2 = bPart.getCharge();
      Vector3 aToBVec = Vector3.subtract(aPart.getPosition(), bPart.getPosition());
      double r2 = aToBVec.lengthSquared();
      //Coulombs equation of C*(q1*q2)/r^2
      //C = 1 due to unit shenanigans
      //q1 and q2 are in terms of pranavs
      //r is in terms of ATU
      double force = q1 * q2 / r2;
      Vector3 forceApplied = aToBVec.normalized().scale(force);
      //due to units, the force is the unit of Dalton * (Bhors Radii / ATU^2)
      //Thus, you must multiply force by ATU and divide by Dalton to get the deltaV
      Vector3 deltaV = forceApplied.divide(aPart.getMass()).scale(time_step);
      aPart.setVelocity( Vector3.add(aPart.getVelocity(), deltaV) );
   }
   
   public void saveFrame()
   {
      for (Particle p : particles)
      {
         output += p;
         output += ",";
      }
      output += "\n";
   }

}