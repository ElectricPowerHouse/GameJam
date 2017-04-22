class LightTrail{
  
  float x1, x2, x3, x4, y1, y2, y3, y4;
  color col;
  float dur;
  ArrayList<LightBar> trail = new ArrayList<LightBar>();
  
  LightTrail(color lightCol, float duration) {
    col = lightCol;
    dur = duration;
  }
  
  void drawLight() {
    for (LightBar segment : trail) {
      segment.display();
    }
    for (int i = trail.size() - 1; i >= 0; i--) {
      LightBar tempBar = trail.get(i);
      if (tempBar.expired) {
        trail.remove(i);
      }
    }
  }
  
  void updateLight(float curx1, float curx2, float cury1, float cury2) {
    x1 = x3;
    x2 = x4;
    y1 = y3;
    y2 = y4;
    x3 = curx1;
    x4 = curx2;
    y3 = cury1;
    y4 = cury2;
    trail.add(new LightBar(x1,x2,y1,y2,x3,x4,y3,y4,col,dur));
  }
}