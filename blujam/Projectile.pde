class Projectile{
  float dist, baseDist, xVel, yVel, angle, finalangle;
  float xPos = 0;
  int bounces = 2;
  int type = 1;
  boolean dead = false;
  float initXVel, initYVel;
  boolean isBouncy;
  PImage pro;
  color col;
  float wd = 18;
  float ht = 18;
  
  Projectile(float distance, float bounds, float xVelocity, float a, float yVelocity, int type, PImage proj, color initCol) {
    dist = distance;
    baseDist = bounds;
    xVel = xVelocity;
    yVel = yVelocity;
    initXVel = xVel;
    initYVel = yVel;
    angle = a;
    pro = proj;
    col = initCol;
    this.type = type;
    if (type == 3) {
      wd = 40;
      ht = 40;
    }
    
  }
  
  void display() {
    if (!dead) {
      if (type == 0 || type == 3) {
        this.update();
      } else if (type == 1) {
        this.bounceUpdate();
      }
      pushMatrix();
      rotate(angle);
      pushStyle();
      tint(col);
      image(pro, xPos, dist-10, wd, ht);
      popStyle();
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
      finalangle = angle-(((abs(xVel))/xVel)*2*(asin(((sqrt(sq(xPos)+sq(baseDist-dist)))/2.0)/baseDist)));
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
        finalangle = angle-(((abs(xVel))/xVel)*2*(asin(((sqrt(sq(xPos)+sq(baseDist-dist)))/2.0)/baseDist)));
        angle = finalangle;
        xPos = 0;
        xVel = initXVel;
        yVel = initYVel;
        dist = baseDist-2;
        bounces--;
      } else {
        finalangle = angle-(((abs(xVel))/xVel)*2*(asin(((sqrt(sq(xPos)+sq(baseDist-dist)))/2.0)/baseDist)));
        dead = true;
      }
    }
  }
  
}