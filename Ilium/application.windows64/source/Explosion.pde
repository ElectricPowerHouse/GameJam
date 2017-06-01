class Explosion {
  
  float a, distance, inc;
  color basecol, lerpcol;
  float colinc = 0;
  float colincagain = 0.0;
  boolean expired;
  ArrayList<Particle> parts = new ArrayList<Particle>();
  PImage partImg;
  
  Explosion(float angle, float dist, color col, PImage particle) {
    partImg = particle;
    a = angle;
    distance = dist;
    basecol = col;
    lerpcol = color(255, 220, 20);
    int num = int(random(3, 9));
    for (int i = 0; i < num; i++) {
      parts.add(new Particle(partImg));
    }
  }
  
  void display() {
    this.updateCol();
    pushMatrix();
    pushStyle();
    noStroke();
    tint(basecol);
    rotate(a);
    translate(0,distance);
    for (Particle part : parts) {
      pushMatrix();
      rotate(part.angle);
      part.display();
      popMatrix();
    }
    popStyle();
    popMatrix();
  }
  
  void updateCol() {
    basecol = lerpColor(basecol, lerpcol, colinc);
    colinc += colincagain;
    colincagain += 0.008;
    if (colinc > 1) {
      expired = true;
      for (int i = parts.size()-1; i >=0; i--) {
        parts.remove(i);
      }
    }
  }
}