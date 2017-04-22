GameManager gameManager;

void setup(){
  
  fullScreen();
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