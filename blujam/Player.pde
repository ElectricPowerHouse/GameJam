class Player{
  float angle, dist, wd, ht, jumpDif, baseDist;
  boolean touchingGround, dead, poweredUp;
  int powerType = 0;
  color col;
  int flipVal = 1;
  PImage img;
  LightTrail[] trail = new LightTrail[3];
  float powerStart, powerDuration, powerCount;
  
  Player (float a, float distance, float widt, float hght, color baseCol, PImage image) {
    angle = a;
    dist = distance;
    baseDist = distance;
    wd = widt;
    ht = hght;
    col = baseCol;
    jumpDif = 0;
    img = image;
    powerDuration = 5000;
    for (int i = 0; i < 3; i++) {   
      if (i == 1) {
        trail[i] = new LightTrail(col, 10, 7);
      } else {
        trail[i] = new LightTrail(col, 10, 4);
      }
    }
    poweredUp=false;
  }
  
  void display() {
    if (!dead) {
      pushMatrix();
      this.updateJump();
      for (int i = 0; i < 3; i++) {  
        trail[i].updateLight(angle,dist-18-(i*4.5),col);         trail[i].drawLight();
      }
      
      if (dist > baseDist) {
        touchingGround = true;
        dist = baseDist;
        jumpDif = 0;
      }
      rotate(angle);
      noStroke();
      fill(col);
      scale(flipVal,1);
      image(img, -wd/2.0, dist-ht, wd, ht);
      popMatrix();
    }
  }
  
  void update(float angleDif) {
    if (poweredUp) {
      powerCount = millis();
      if (powerCount - powerStart >= powerDuration) {
        poweredUp = false;
        powerType = 0;
      }
    }
    if (!dead) {
      angle += angleDif;
    }
    
  }
  
  void updateJump() {
    if (!touchingGround) {
      dist -= jumpDif;
      jumpDif -= 0.5;
      if (dist < baseDist/3.0) {
        dead = true;
      }
    }
  }
  
  void jump(float jumpVel) {
    if (touchingGround) {
      touchingGround = false;
      jumpDif = jumpVel;
    }
  }
  
  void checkCollisions(ArrayList<Projectile> enemyProjs) {
    if (!dead) {
      for(Projectile checkProj : enemyProjs) {
        if (checkProj.dead || checkProj.type == 1) {
          float targAngle = checkProj.finalangle;
          float curAngle = angle;
          if (abs(targAngle/(2*PI)) > 1) {
            targAngle -= (int(targAngle/(2*PI))*2*PI);
          }
          if (abs(curAngle/(2*PI)) > 1) {
            curAngle -= (int(curAngle/(2*PI))*2*PI);
          }
          if (curAngle < 0) {
            curAngle += 2*PI;
          }
          if (targAngle < 0) {
            targAngle += 2*PI;
          }
          if (curAngle >= targAngle - PI/20.0 && curAngle <= targAngle + PI/20.0) {
            this.jump(15);
          }
        }
      }
    }
  }
  
  float getAngle(){
   
    return angle;
  }
}