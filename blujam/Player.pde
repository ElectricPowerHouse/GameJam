class Player{
  float angle, dist, wd, ht, jumpDif, baseDist;
  boolean touchingGround;
  color col;
  
  Player (float a, float distance, float widt, float hght, color baseCol) {
    angle = a;
    dist = distance;
    baseDist = distance;
    wd = widt;
    ht = hght;
    col = baseCol;
    jumpDif = 0;
  }
  
  void display() {
    pushMatrix();
    this.updateJump();
    if (dist > baseDist) {
      touchingGround = true;
      dist = baseDist;
      jumpDif = 0;
    }
    rotate(angle);
    noStroke();
    fill(col);
    rect(0,dist-(ht/2.0),wd,ht);
    popMatrix();
  }
  
  void update(float angleDif) {
    angle += angleDif;
  }
  
  void updateJump() {
    if (!touchingGround) {
      dist -= jumpDif;
      jumpDif -= 0.5;
    }
  }
  
  void jump(float jumpVel) {
    if (touchingGround) {
      touchingGround = false;
      jumpDif = jumpVel;
    }
  }
  
  void checkCollisions(ArrayList<Projectile> enemyProjs) {
    for(Projectile checkProj : enemyProjs) {
      if (checkProj.dead) {
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
  
  float getAngle(){
   
    return angle;
  }
}