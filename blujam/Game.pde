

class Game{
  
  int roundNum;
  boolean gameOver;
  Round round;
  
  int playerOneScore;
  int playerTwoScore;
  
  Game(){
    
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
      if (roundNum < 4) {
        roundNum++;
        round = new Round(roundNum,playerOneScore,playerTwoScore);
      }
    }
    else if (round.roundOver == 2) {
      playerOneScore++;
      if (roundNum < 4) {
        roundNum++;
        round = new Round(roundNum,playerOneScore,playerTwoScore);
      }
    }  
    if (roundNum >= 4) {
      round = null;
      gameOver = true;
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