

class Game{
  
  int roundNum;
  boolean gameOver;
  Round round;
  
  Game(){
    
  int roundNum = 1;
  round = new Round();
  
  
  }
  

  
void drawGame(){ 
  if (round != null) {
    round.drawRound();
    if (round.roundOver == 1) {
      println("Player Two Wins!");
      if (roundNum < 3) {
        round = new Round();
        roundNum++;
      }
    }
    else if (round.roundOver == 2) {
      println("Player One Wins!");
      if (roundNum < 3) {
        round = new Round();
        roundNum++;
      }
    }  
    if (roundNum >= 3) {
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