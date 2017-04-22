

class BlueHole{
  
  float sz;
  
  BlueHole(float size){
    
    sz = size;
  }
  
  
  
  void drawHole(){
    noStroke();
    fill(20,132,244);
    ellipse(0,0,sz,sz);
  }
  
  
}