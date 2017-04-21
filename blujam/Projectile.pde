class Projectile{
  float dist, baseDist, xVel, yVel, angle;
  float xPos = 0;
  boolean dead = false;
  
  Projectile(float distance, float bounds, float xVelocity, float a, float yVelocity) {
    dist = distance;
    baseDist = bounds;
    xVel = xVelocity;
    yVel = yVelocity;
    angle = a;
  }
  
  void display() {
    this.update();
    if (!dead) {
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
      dead = true;
    }
  }
}