class LightBar{
  
  float prevx, prevy, curx, cury;
  
  float sz;
  color col;
  float dur;
  boolean expired;
  
  LightBar(float hght, color basecol, float duration, float x1, float x2, float y1, float y2) {
    
    sz = hght;
    prevx = x1;
    prevy = y1;
    curx = x2;
    cury = y2;
    
    col = basecol;
    dur = duration;
  }
  
  void display() {
    this.update();
    pushMatrix();
    stroke(col);
    strokeWeight(sz);
    strokeCap(SQUARE);
    line(prevx, prevy, curx, cury);
    popMatrix();
    
  }
  
  void update(){
    col = color(red(col), green(col), blue(col), alpha(col) - dur);
    if (alpha(col) <= 0) {
      expired = true;
    }
  }
}