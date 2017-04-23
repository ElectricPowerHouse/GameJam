class GameManager {

  PFont calibri;
  PFont pointed;

  PImage wasd = loadImage("data/wasd.png");
  PImage arrows = loadImage("data/arrows.png");
  int wasdWidth = wasd.width;
  int wasdHeight = wasd.height;
  int arrowWidth = arrows.width;
  int arrowHeight = arrows.height;

  boolean moveDown = true;
  float startMillis;
  float flashMillis;
  float currentMillis;
  float modY = 0;
  
  boolean flash = true;
  

  String gameState;
  Game game;
  
  
  SoundManager menuMusic;
  SoundManager startSound;

  GameManager() {
    
    menuMusic = new SoundManager("C:/Illium/GameJam/blujam/sounds/music/Title_Screen.wav");
    startSound = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Round_1.wav");

    calibri = createFont("font/calibri.ttf", 32); 
    pointed = createFont("font/Pointed.ttf", height/4);

    gameState = "MAINMENU";
    //game = new Game();    // delete this when menu properly implemented
    
    
    menuMusic.playLoop();
  }



  void drawManager() {



    if (game!= null && gameState == "PLAYING") {
      game.drawGame();
    } else {
      drawMenu();
    }
    /*if (game!= null && game.gameOver) {
      gameState = "MAINMENU";
      drawMenu();
    }*/
  }


  void drawMenu() {

    background(37);
    fill(255);


    textFont(pointed, height/3);
    text("ELIUM", width/4, (height/2.3));
    textFont(pointed, height/12);
    
    if(flash){
    text("press any key to battle", width/3.5, (height-(height/2.2)));
    }

    image(wasd, width/15, height-(height/3) );
    wasd.resize(int(wasdWidth/1.5), int(wasdHeight/1.5));
    image(arrows, width/1.9, height-(height/3));
    arrows.resize(int(arrowWidth/1.5), int(arrowHeight/1.5));



    if (moveDown) {
      modY+=0.2;
    } else {
      modY-=0.2;
    }
    
    
    currentMillis = millis();
    if(currentMillis-startMillis>1500){
      
      
      moveDown = !moveDown;
      startMillis = currentMillis;
      
    }
    if(currentMillis-flashMillis>800){
      
      flash = !flash;
      flashMillis = currentMillis;
    }
    
    
    
  }




  void keyPressedManager() {
    
    

    if (gameState.equals("MAINMENU")) {

      
      menuMusic.stop();

      game = new Game();
      gameState = "PLAYING";
    } else {
      
     
      
      if(keyCode == ENTER && game.gameOver==true){
         
        game.stopMusic();
        
        menuMusic.playLoop();
        gameState="MAINMENU";
        
       }

      if (game!=null) {
        game.keyPressedGame();
      }
    }
  }

  void keyReleasedManager() {

    if (gameState.equals("PLAYING")) {

      game.keyReleasedGame();
    }
  }
}