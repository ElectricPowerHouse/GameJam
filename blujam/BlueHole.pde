PImage voi;

class BlueHole{
  
  float sz;
  float ang;
  
  BlueHole(float size){
    
    sz = size;
    voi = loadImage("void.png");
  }
  
  
  
  void drawHole(){
    pushStyle();
    pushMatrix();
    imageMode(CENTER);
    ang += PI/2000;
    //rotate(ang);
    noStroke();
    fill(20,132,244);
    image(voi, 0,0,sz,sz);
    popMatrix();
    popStyle();
  }
  
  
}