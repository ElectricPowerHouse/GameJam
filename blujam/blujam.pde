GameManager gameManager;

void setup(){
  
  fullScreen(P2D);
  smooth(8);
  //size(600,600);
  rectMode(CENTER);
gameManager = new GameManager();



}

void draw(){
  
  gameManager.drawManager();
}


void keyPressed(){
  
 
 gameManager.keyPressedManager();
  
}
void keyReleased(){
  
  
gameManager.keyReleasedManager();
  
  
}