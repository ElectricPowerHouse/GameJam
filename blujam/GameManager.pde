class GameManager{
  

  Game game = new Game();


void drawManager(){

  //fill(255);
 //rect(0,0,width,height); 
 
 if(game!= null){
 game.drawGame();
 }
  
}

void keyPressedManager(){
  
  game.keyPressedGame();
  
}

void keyReleasedManager(){
  
  game.keyReleasedGame();
  
}

}