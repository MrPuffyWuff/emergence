import java.io.FileWriter;
import java.io.IOException;


public class MainSimulator
{   
   private boolean isSimulationRunning;
   
   private String output;
   
   private int frame;
   private int totalFrames;
   
   private double time_step;
   
   
   /*
   -4.628479065018875,3.850784975503889,-3.002066964447845
   2.959501958800951,-2.36544618482435,4.281158133123059
   3.952869622835547,-2.3956209043177976,-4.972019229326341
   4.075350237500928,4.833801528609148,-2.187800737523783
   4.342427159232962,4.9799714873239544,4.4302788597549405
   2.7775878142603094,3.0304330438035225,-3.410322063669639
   -2.119657671184083,2.556060776787863,-2.8071947663585766
   4.1850114122750925,4.735447382481818,-2.70058368078442
   3.68060212647632,-3.954278925614492,2.5315026978249686
   3.199857034035543,-2.8076525393431813,-4.536474711805448
   */
   // private Particle[] particles= {
//          //A cool protons
//          new Particle(new Vector3(3,3,3), 3, 3*1836.15 + 4*1838.68),//Lithium
//          new Particle(new Vector3(-3,3,3), 3, 3*1836.15 + 4*1838.68),//Lithium 
//          new Particle(new Vector3(3,-3,3), 3, 3*1836.15 + 4*1838.68),//Lithium 
//          new Particle(new Vector3(3,3,-3), 3, 3*1836.15 + 4*1838.68),//Lithium 
//          new Particle(new Vector3(-3,-3,3), 3, 3*1836.15 + 4*1838.68),//Lithium
//          new Particle(new Vector3(3,-3,-3), 3, 3*1836.15 + 4*1838.68),//Lithium 
//          new Particle(new Vector3(-3,3,-3), 3, 3*1836.15 + 4*1838.68),//Lithium
//          new Particle(new Vector3(-3,-3,-3), 3, 3*1836.15 + 4*1838.68),//Lithium 
//          //A bunch of cool electrons
//          new Particle(new Vector3(0,0,0), -1, 1),
//          new Particle(new Vector3(8,0,0), -1, 1),
//          new Particle(new Vector3(0,8,0), -1, 1),
//          new Particle(new Vector3(0,0,8), -1, 1),
//          new Particle(new Vector3(-8,0,0), -1, 1),
//          new Particle(new Vector3(0,-8,0), -1, 1),
//          new Particle(new Vector3(0,0,-8), -1, 1),
//          new Particle(new Vector3(8,8,8), -1, 1),
//          new Particle(new Vector3(-8,8,8), -1, 1),
//          new Particle(new Vector3(8,-8,8), -1, 1),
//          new Particle(new Vector3(8,8,-8), -1, 1),
//          new Particle(new Vector3(-8,-8,8), -1, 1),
//          new Particle(new Vector3(8,-8,-8), -1, 1),
//          new Particle(new Vector3(-8,8,-8), -1, 1),
//          new Particle(new Vector3(-8,-8,-8), -1, 1),
//          new Particle(new Vector3(0,8,8), -1, 1),
//          new Particle(new Vector3(8,0,8), -1, 1),
//          new Particle(new Vector3(8,8,0), -1, 1),
//          new Particle(new Vector3(0,-8,-8), -1, 1),
//          new Particle(new Vector3(-8,0,-8), -1, 1),
//          new Particle(new Vector3(-8,-8,0), -1, 1),
//          new Particle(new Vector3(-8,0,8), -1, 1),
//          // new Particle(new Vector3(0,3,0), -1, 1),
// //          new Particle(new Vector3(0,-3,0), -1, 1),
// //          new Particle(new Vector3(0,0,3), -1, 1),
//       };
   // private Particle[] particles= {
//          //A bunch of cool protons
//          new Particle(new Vector3(0,0,0), 1, 1836.15),
//          new Particle(new Vector3(1,0,0), 1, 1836.15),
//          new Particle(new Vector3(0,0,1), 1, 1836.15),
//          new Particle(new Vector3(0,2,0), 1, 1836.15),
//          new Particle(new Vector3(3,1.5,4), 1, 1836.15),
//          //A bunch of cool electrons
//          new Particle(new Vector3(-0.67,1,0), -1, 1836.15),//youre welcome pranav
//          new Particle(new Vector3(0,-1,0), -1, 1836.15),
//          new Particle(new Vector3(1,3,0), -1, 1836.15),
//          new Particle(new Vector3(-2,0,1), -1, 1836.15),
//       };
    // private Particle[] particles= {
//          //A bunch of cool protons
//          new Particle(new Vector3(0,0,0), 1, 1836.15),
//          new Particle(new Vector3(3,0,0), 1, 1836.15),
//          new Particle(new Vector3(0,0,3), 1, 1836.15),
//          new Particle(new Vector3(0,3,0), 1, 1836.15),
//          new Particle(new Vector3(9,4.5,12), 1, 1836.15),
//          //A bunch of cool electrons
//          new Particle(new Vector3(-2,3,0), -1, 1),//youre welcome pranav
//          new Particle(new Vector3(0,-3,0), -1, 1),
//          new Particle(new Vector3(3,9,0), -1, 1),
//          new Particle(new Vector3(-6,0,3), -1, 1),
//       };
   private Particle[] particles= {
         //new Particle(new Vector3(-1,0,0), 1, 1836.15),
         //A bunch of cool electrons
         new Particle(new Vector3(2,0,0), new Vector3(0, 0.137/10, 0), -1, 1),
         new Particle(new Vector3(-2,0,0), new Vector3(0, -0.137/10, 0), -1, 1),
         //A bunch of cool protons
         new Particle(new Vector3(0,0,0), 2*1, 2*1836.15 + 2*1838.68),
      };
   
   
   public MainSimulator(){
      //Save initial frame
      isSimulationRunning = true;
      frame = 0;
      time_step = 0.01/1000;
      totalFrames = 8000*2;
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
               boolean isQuantum = quantumCheck(aPart, bPart);
               aPart.setIsQuantum(isQuantum);
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
            System.out.println(frame / (float)(totalFrames) + " Complete");
         }
      }
   }
      
   public void applyCoulombsForce(Particle aPart, Particle bPart)
   {  
      int q1 = aPart.getCharge();
      int q2 = bPart.getCharge();
      Vector3 bToAVec = Vector3.subtract(aPart.getPosition(), bPart.getPosition());
      double r2 = bToAVec.lengthSquared();
      //Coulombs equation of C*(q1*q2)/r^2
      //C = 1 due to unit shenanigans
      //q1 and q2 are in terms of elementary charge
      //r is in terms of ATU
      double force = q1 * q2 / r2;
      Vector3 forceApplied = bToAVec.normalized().scale(force);
      //due to units, the force is the unit of Dalton * (Bhors Radii / ATU^2)
      //Thus, you must multiply force by ATU and divide by Dalton to get the deltaV
      Vector3 deltaV = forceApplied.divide(aPart.getMass()).scale(time_step);
      aPart.setVelocity( Vector3.add(aPart.getVelocity(), deltaV) );
   }
   
   public boolean quantumCheck(Particle aPart, Particle bPart)
   {
      /*
      0.5*a.m*(a.v)^2 + (k * a.q * b.q)/r < 0
      if statement is true, it is quantum 
      */
      int q1 = aPart.getCharge();
      int q2 = bPart.getCharge();
      double m = aPart.getMass();
      //Seeing as the first term is always positive, the expression can only be negative if a.q * b.q is negative
      if (q1 * q2 > 0) return false;
      //Now we just have to do the math...
      Vector3 bToAVec = Vector3.subtract(aPart.getPosition(), bPart.getPosition());
      double r = bToAVec.length();
      //A Particle velocity must be relative to B; Assume B is a stationary point in space
      Vector3 relAVel = Vector3.subtract(aPart.getVelocity(), bPart.getVelocity());
      //The potential energy equation only considers the projected velocity
      //Luckily, we only need the magnitude. So a scalar projection will suffice
      //https://www.geeksforgeeks.org/maths/scalar-and-vector-projection-formula/
      double velProjAMag = Vector3.dot(relAVel, bToAVec)/r;
      
      double term1 = 0.5 * m * (velProjAMag * velProjAMag);
      double term2 = (q1 * q2) / r;
      
      return term1 + term2 <= 0;
   }
   
   public void saveFrame()
   {
      for (Particle p : particles)
      {
         output += p;
         output += ";";
      }
      output += "\n";
   }

}