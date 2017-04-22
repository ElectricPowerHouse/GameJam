
//random 0-2 pi angle
class Pickup{
  
  float angle, dist, wd, ht;
  boolean active;
  int type;
  
  
   Pickup (float distance, float widt, float hght) {
     
     getRandomType();
  
     active = true;
    dist = distance;
    wd = widt;
    ht = hght;
    
    
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
    
    angle = random(0,2)*PI;
    getRandomType();
    active = true;
  }
  
  boolean isActive(){
   return active; 
  }
  
  
  void getRandomType(){
    
    type = int(random(0,3));
    
  }
    
    
  }
  
  
  
  
  
  
  
  
  