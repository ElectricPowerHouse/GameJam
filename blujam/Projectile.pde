class Projectile{
  float dist, baseDist, xVel, yVel, angle, finalangle;
  float xPos = 0;
  int bounces = 5;
  boolean dead = false;
  float initXVel, initYVel;
  
  Projectile(float distance, float bounds, float xVelocity, float a, float yVelocity) {
    dist = distance;
    baseDist = bounds;
    xVel = xVelocity;
    yVel = yVelocity;
    initXVel = xVel;
    initYVel = yVel;
    angle = a;
  }
  
  void display() {
    if (!dead) {
      this.update();
      pushMatrix();
      rotate(angle);
      noStroke();
      fill(255);
      ellipse(xPos, dist-10, 10, 10);
      popMatrix();
    }
  }
  
  void update() {
    if(xVel != 0) {
      xPos += xVel;
      xVel += ((abs(xVel))/xVel)*0.05;
    }
    dist -= yVel;
    yVel -= 0.25;
    if (sqrt(sq(xPos)+sq(dist)) >= baseDist) {
      if (xVel != 0) {
        finalangle = angle-(((abs(xVel))/xVel)*2*(asin(((sqrt(sq(xPos)+sq(baseDist-dist)))/2.0)/baseDist)));
      } else {
        finalangle = angle;
      }
      dead = true;
    }
  }
  
  void bounceUpdate(){
    if(xVel != 0) {
      xPos += xVel;
      xVel += ((abs(xVel))/xVel)*0.05;
    }
    dist -= yVel;
    yVel -= 0.25;
    if (sqrt(sq(xPos)+sq(dist)) >= baseDist) {
      if(bounces>0){
        
        xVel = initXVel;
        yVel = initYVel;
        dist = baseDist;
        angle = angle-(((abs(xVel))/xVel)*2*(asin(((sqrt(sq(xPos)+sq(baseDist-dist)))/2.0)/baseDist)));
        
      }
    }
  }
  
}