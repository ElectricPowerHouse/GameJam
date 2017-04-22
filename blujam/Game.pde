

class Game{
  
  int roundNum;
  boolean gameOver;
  Round round;
  
  int playerOneScore;
  int playerTwoScore;
  
  Game(){
    
    gameOver= false;
    roundNum = 1;
    round = new Round(roundNum, playerOneScore, playerTwoScore);
    
    playerOneScore = 0;
    playerTwoScore = 0;
  
  
  }
  

  
void drawGame(){ 
  
  
  if (round != null) {
    round.drawRound();
    if (round.roundOver == 1) {
      playerTwoScore++;
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

}