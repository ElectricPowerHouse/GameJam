class Projectile{
  float dist, baseDist, xVel, yVel, angle, finalangle, initXVel, initYVel;
  float xPos = 0;
  boolean dead = false;
  int bounces;
  
  
  Projectile(float distance, float bounds, float xVelocity, float a, float yVelocity) {
    dist = distance;
    baseDist = bounds;
    xVel = xVelocity;
    yVel = yVelocity;
    initXVel = xVelocity;
    initYVel = yVelocity;
    angle = a;
    bounces = 5;
  }
  
  void display() {
    if (!dead) {
      bounceUpdate();
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