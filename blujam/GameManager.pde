class GameManager{
  
  PFont calibri;
  PFont pointed;
  
  PImage wasd = loadImage("data/wasd.png");
  PImage arrows = loadImage("data/arrows.png");
  int wasdWidth = wasd.width;
  int wasdHeight = wasd.height;
  int arrowWidth = arrows.width;
  int arrowHeight = arrows.height;
  
  
  String gameState;
  Game game;
  
  GameManager(){
    
     calibri = createFont("font/calibri.ttf",32); 
     pointed = createFont("font/Pointed.ttf",height/4);
     
     gameState = "MAINMENU";
     //game = new Game();    // delete this when menu properly implemented
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
 if (game!= null && game.gameOver) {
   gameState = "MAINMENU";
   drawMenu();
 }
  
}


void drawMenu(){
  
   background(94,62,62);
   fill(255);
   textFont(pointed,height/3);
   text("ELIUM",width/4,height/2.3);
   textFont(pointed,height/12);
   text("press any key to battle",width/3.5,height-(height/2.2));
   
   image(wasd,width/15,height-(height/3));
   wasd.resize(int(wasdWidth/1.5),int(wasdHeight/1.5));
   image(arrows,width/1.9,height-(height/3));
   arrows.resize(int(arrowWidth/1.5),int(arrowHeight/1.5));
  
  
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