
//random 0-2 pi angle
class Pickup{
  
  float angle, dist, wd, ht, jumpDif;
  boolean active;
  
   Pickup (float distance, float widt, float hght) {
  
     active = true;
    dist = distance;
    wd = widt;
    ht = hght;
    jumpDif = 0;
    
    angle = random(0,2)*PI;
    
   }
   
   
    void drawPickup() {
      
      if(!active){
       return; 
      }
      
    pushMatrix();
    
    rotate(angle);
    noStroke();
    fill(255);
    ellipse(0,dist-(ht/2.0),wd,ht);
    popMatrix();
  }
  
  
  float getAngle(){
    
   return angle; 
  }
  
  void deActivate(){
    
    active = false;
    
    
  }
  
  void activate(){
    
    active = true;
  }
  
  boolean isActive(){
   return active; 
  }
    
    
  }
  
  
  
  
  
  
  
  
  