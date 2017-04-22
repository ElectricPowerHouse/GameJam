class Particle {
  
  float inc = random(2,7);
  float ydiff = 0;
  float wd, ht, angle;
  
  Particle() {
    wd = random(3,8);
    ht = random(4,10);
    angle = random(-3*PI/7.0, 3*PI/7.0);
  }
  
  void display(){
    rect(0, -ydiff, wd, ht);
    ydiff += inc;
  }
}