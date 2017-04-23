

class Game{
  
  int roundNum;
  boolean gameOver;
  Round round;
  
  int playerOneScore;
  int playerTwoScore;
  
  SoundManager round1Music;
  SoundManager round2Music;
  
  boolean isTense;
  
  Game(){
    
    gameOver= false;
    roundNum = 1;
    round = new Round(roundNum, playerOneScore, playerTwoScore);
    
    playerOneScore = 0;
    playerTwoScore = 0;
    
    round1Music = new SoundManager("C:/Illium/GameJam/blujam/sounds/music/Level_1_Music.wav");
    round2Music = new SoundManager("C:/Illium/GameJam/blujam/sounds/music/Level_2_Music.wav");
  
    round1Music.playLoop();
    
    isTense = false;
  
  }
  

  
void drawGame(){ 
  
  
  if (round != null) {
    round.drawRound();
    if (round.roundOver == 1) {
      playerTwoScore++;
      if(playerTwoScore==2){
        if(isTense==false){
          round1Music.stop();
          round2Music.playLoop();
        }
        isTense = true;
        
      }
      if (playerTwoScore==3) {
        gameOver=true;
        roundNum++;
        
      }
      else{
        roundNum++;
        round = new Round(roundNum,playerOneScore,playerTwoScore);
      }
      
     
      
    }
    else if (round.roundOver == 2) {
      playerOneScore++;
       if(playerTwoScore==2){
          if(isTense==false){
          round1Music.stop();
          round2Music.playLoop();
        }
        isTense = true;
        
      }
      if (playerOneScore==3) {
        gameOver=true;
        roundNum++;
      }
      else{
        roundNum++;
        round = new Round(roundNum,playerOneScore,playerTwoScore);
      }
    }  
  
  }
}

void keyPressedGame(){
  
  
  
 round.keyPressedRound(); 
  
}


void keyReleasedGame(){
  
  round.keyReleasedRound();
  
}

void stopMusic(){
 
  round1Music.stop();
  round2Music.stop();
}

}