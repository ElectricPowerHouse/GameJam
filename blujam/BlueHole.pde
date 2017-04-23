class BlueHole{
  
  float sz;
  float ang;
  PImage voi, debris;
  
  BlueHole(float size){
    
    sz = size;
    voi = loadImage("center.png");
    debris = loadImage("debris.png");
  }
  
  
  
  void drawHole(){
    pushStyle();
    pushMatrix();
    imageMode(CENTER);
    ang += PI/2000;
    noStroke();
    fill(20,132,244);
    pushMatrix();
    rotate(ang);
    image(voi, 0,0,sz,sz);
    popMatrix();
    pushMatrix();
    rotate(-ang);
    image(debris, 0,0,sz,sz);
    popMatrix();
    popMatrix();
    popStyle();
  }
  
  
}