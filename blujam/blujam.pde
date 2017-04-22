GameManager gameManager;

void setup(){
  
  fullScreen();
  //size(600,600);
  rectMode(CENTER);
gameManager = new GameManager();

SoundManager test = new SoundManager("C:/Illium/GameJam/blujam/sounds/TitleScreen.wav");
test.play();



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