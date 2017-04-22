class LightBar{
  
  float sz, a, dist;
  color col;
  float dur;
  boolean expired;
  
  LightBar(float angle, float hght, float baseDist, color basecol, float duration) {
    
    a = angle;
    sz = hght;
    dist = baseDist;
    
    col = basecol;
    dur = duration;
  }
  
  void display() {
    this.update();
    pushMatrix();
    rotate(a);
    stroke(col);
    strokeWeight(10);
    strokeCap(SQUARE);
    line(0, dist-(sz/2.0), sz/2.0, dist-(sz/2.0));
    popMatrix();
    
  }
  
  void update(){
    col = color(red(col), green(col), blue(col), alpha(col) - dur);
    if (alpha(col) <= 0) {
      expired = true;
    }
  }
}