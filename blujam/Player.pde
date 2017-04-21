class Player{
  float angle, dist, wd, ht;
  color col;
  
  Player (float a, float distance, float widt, float hght, color baseCol) {
    angle = a;
    dist = distance;
    wd = widt;
    ht = hght;
    col = baseCol;
  }
  
  void display() {
    pushMatrix();
    rotate(angle);
    noStroke();
    fill(col);
    rect(0,dist-(ht/2.0),wd,ht);
    popMatrix();
  }
  
  void update(float angleDif) {
    angle+=angleDif;
  }
}