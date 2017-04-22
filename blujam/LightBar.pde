class LightBar{
  
  float x1, x2, x3, x4, y1, y2, y3, y4;
  PShape seg;
  color col;
  float dur;
  boolean expired;
  
  LightBar(float prevx1, float prevx2, float prevy1, float prevy2, float newx1, float newx2, float newy1, float newy2, color basecol, float duration) {
    x1 = prevx1;
    x2 = prevx2;
    y1 = prevy1;
    y2 = prevy2;
    x3 = newx1;
    x4 = newx2;
    y3 = newy1;
    y4 = newy2;
    
    col = basecol;
    dur = duration;
    
    seg = createShape();
    seg.beginShape();
    seg.vertex(x1,y1);
    seg.vertex(x2,y2);
    seg.vertex(x3,y3);
    seg.vertex(x4,y4);
    seg.endShape();
  }
  
  void display() {
    this.update();
    shape(seg);
  }
  
  void update(){
    col = color(red(col), green(col), blue(col), alpha(col) - dur);
    seg.setFill(col);
    if (alpha(col) <= 0) {
      expired = true;
    }
  }
}