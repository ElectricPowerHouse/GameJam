class Projectile{
  float dist, baseDist, xVel, angle;
  
  Projectile(float distance, float xVelocity, float a) {
    dist = distance;
    baseDist = distance;
    xVel = xVelocity;
    angle = a;
  }
  
  void display() {
    pushMatrix();
    this.update();
    rotate(angle);
    noStroke();
    fill(255);
    ellipse(0, dist-50, 10, 10);
    popMatrix();
  }
  
  void update() {
    angle += xVel;
  }
}