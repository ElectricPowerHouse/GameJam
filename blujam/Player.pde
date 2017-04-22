class Player{
  float angle, dist, wd, ht, jumpDif, baseDist;
  boolean touchingGround, dead;
  color col;
  PImage img;
  LightTrail trail;
  
  Player (float a, float distance, float widt, float hght, color baseCol, PImage image) {
    angle = a;
    dist = distance;
    baseDist = distance;
    wd = widt;
    ht = hght;
    col = baseCol;
    jumpDif = 0;
    img = image;
    trail = new LightTrail(col, 5, 30);
  }
  
  void display() {
    if (!dead) {
      pushMatrix();
      this.updateJump();
      if (touchingGround) {
        trail.updateLight(angle,dist);
      }
      trail.drawLight();
      if (dist > baseDist) {
        touchingGround = true;
        dist = baseDist;
        jumpDif = 0;
      }
      rotate(angle);
      noStroke();
      fill(col);
      //rect(0,dist-(ht/2.0),wd,ht);
      image(img, -wd/2.0, dist-ht, wd, ht);
      popMatrix();
    }
  }
  
  void update(float angleDif) {
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