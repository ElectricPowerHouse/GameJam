

class Game{
  
  int roundNum;
  boolean gameOver;
  Round round;
  
  int playerOneScore;
  int playerTwoScore;
  
  SoundManager round1Music;
  SoundManager round2Music;
  SoundManager round1Start;
  SoundManager round2Start;
  SoundManager round3Start;
  
  
  boolean isTense;
  
  Game(){
    
    gameOver= false;
    roundNum = 1;
    round = new Round(roundNum, playerOneScore, playerTwoScore);
    
    playerOneScore = 0;
    playerTwoScore = 0;
    
    round1Music = new SoundManager("C:/Illium/GameJam/blujam/sounds/music/Level_1_Music.wav");
    round2Music = new SoundManager("C:/Illium/GameJam/blujam/sounds/music/Level_2_Music.wav");
    
    round1Start = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Round_1.wav");
    round2Start = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Round_2.wav");
    round3Start = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Round_3.wav");
    
    round1Start.play();
  
    round1Music.playLoop();
    
    isTense = false;
    
 
  
  }
  

  
void drawGame(){ 
  
  
  if (round != null) {
    round.drawRound();
    if (round.roundOver == 1) {
      
      if(roundNum==1){
        round1Start.play();
      }
      else if(roundNum==2){
        round2Start.play();
      }
      else if(roundNum>=3){
        round3Start.play();
      }
      
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
      
      
       if(roundNum==1){
        round1Start.play();
      }
      else if(roundNum==2){
        round2Start.play();
      }
      else if(roundNum>=3){
        round3Start.play();
      }
      
      
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