

class Game{
  
  Round round = new Round();
  

  
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