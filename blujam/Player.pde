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
      println("test");
      touchingGround = false;
      jumpDif = jumpVel;
    }
  }
}