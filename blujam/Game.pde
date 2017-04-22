

class Game{
  
  int roundNum;
  
  Round round;
  
  Game(){
    
  int roundNum = 1;
  round = new Round();
  
  
  }
  

  
void drawGame(){
  
 
  round.drawRound();
  
  
  
}

void keyPressedGame(){
  
 round.keyPressedRound(); 
  
}


void keyReleasedGame(){
  
  round.keyReleasedRound();
  
}

}