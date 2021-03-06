class LightTrail{
  
  float x1, y1, x2, y2;
  color col;
  float dur, sz;
  ArrayList<LightBar> trail = new ArrayList<LightBar>();
  
  LightTrail(color lightCol, float duration, float hght, float dist) {
    col = lightCol;
    dur = duration;
    sz = hght;
    y1 = dist;
    y2 = dist;
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
  
  void updateLight(float angle, float dist, color newCol) {
    col = newCol;
    x1 = x2;
    y1 = y2;
    x2 = -(dist)*sin(angle);
    y2 = (dist)*cos(angle);
    trail.add(new LightBar(sz,col,dur,x1, x2, y1, y2));
  }
}