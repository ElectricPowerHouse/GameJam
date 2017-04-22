
//random 0-2 pi angle
class Pickup{
  
  float angle, dist, wd, ht, jumpDif;
  
   Pickup (float distance, float widt, float hght) {
  
    dist = distance;
    wd = widt;
    ht = hght;
    jumpDif = 0;
    
    angle = random(0,2)*PI;
    
   }
   
   
    void drawPickup() {
    pushMatrix();
    
    rotate(angle);
    noStroke();
    fill(255);
    ellipse(0,dist-(ht/2.0),wd,ht);
    popMatrix();
  }
    
    
  }
  
  
  
  
  
  
  
  
  