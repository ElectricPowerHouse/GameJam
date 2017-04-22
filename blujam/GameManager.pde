class GameManager{
  
  PFont font;
  String gameState;
  Game game;
  
  GameManager(){
    
     font = createFont("font/calibri.ttf",32); 
     gameState = "PLAYING";
     game = new Game();    // delete this when menu properly implemented
  }
  
  

void drawManager(){

  //fill(255);
 //rect(0,0,width,height); 
 

 
 if(game!= null && gameState == "PLAYING"){
 game.drawGame();
 }
 
 else{
   drawMenu();
   
 }
  
}


void drawMenu(){
  
   background(255);
   fill(0);
   textFont(font,80);
   text("Press any key to start",width/4,height/2);
  
  
}




void keyPressedManager(){
  
  if(gameState.equals("MAINMENU")){
    
    
    game = new Game();
    gameState = "PLAYING";
    
  }
  else{
    
    if(game!=null){
    game.keyPressedGame();
    }
  }
  
  
  
}

void keyReleasedManager(){
  
  if(gameState.equals("PLAYING")){
  
  game.keyReleasedGame();
  
  }
  
}

}