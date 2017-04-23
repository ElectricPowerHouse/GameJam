

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
  
   SoundManager shortShot1;
  SoundManager shortShot2;
  SoundManager shortShot3;
  SoundManager shortShot4;
  SoundManager shortShot5;
  SoundManager shortShot6;
  SoundManager shortShot7;
  SoundManager medShot1;
  SoundManager medShot2;
  SoundManager medShot3;
  SoundManager medShot4;
  SoundManager medShot5;
  SoundManager medShot6;
  SoundManager medShot7;
  SoundManager longShot1;
  SoundManager longShot2;
  SoundManager longShot3;
  SoundManager longShot4;
  SoundManager longShot5;
  SoundManager longShot6;
  SoundManager longShot7;
  
  SoundManager[] shortShots = new SoundManager[7];
  SoundManager[] medShots = new SoundManager[7];
  SoundManager[] longShots = new SoundManager[7];
  
 SoundManager[] deathSounds = new SoundManager[3];
  
 SoundManager[] jumpSounds = new SoundManager[7];
 
 SoundManager[] bounceSounds = new SoundManager[11];
 
 SoundManager chargeUp;
 SoundManager chargeMax;
  
  
  boolean isTense;
  
  Game(){
    
    round1Music = new SoundManager("C:/Illium/GameJam/blujam/sounds/music/Level_1_Music.wav");
    round2Music = new SoundManager("C:/Illium/GameJam/blujam/sounds/music/Level_2_Music.wav");
    
    round1Start = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Round_1.wav");
    round2Start = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Round_2.wav");
    round3Start = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Round_3.wav");
    
    shortShots[0] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Shot_Weak_1.wav");
    shortShots[1] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Shot_Weak_2.wav");
    shortShots[2] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Shot_Weak_3.wav");
    shortShots[3] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Shot_Weak_4.wav");
    shortShots[4] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Shot_Weak_5.wav");
    shortShots[5] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Shot_Weak_6.wav");
    shortShots[6] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Shot_Weak_7.wav");
    medShots[0] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Shot_Medium_1.wav");
    medShots[1] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Shot_Medium_2.wav");
    medShots[2] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Shot_Medium_3.wav");
    medShots[3] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Shot_Medium_4.wav");
    medShots[4] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Shot_Medium_5.wav");
    medShots[5] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Shot_Medium_6.wav");
    medShots[6] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Shot_Medium_7.wav");
    longShots[0] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Shot_Full_1.wav");
    longShots[1] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Shot_Full_2.wav");
    longShots[2] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Shot_Full_3.wav");
    longShots[3] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Shot_Full_4.wav");
    longShots[4] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Shot_Full_5.wav");
    longShots[5] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Shot_Full_6.wav");
    longShots[6] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Shot_Full_7.wav");
    
    jumpSounds[0] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Jumping_1.wav");
    jumpSounds[1] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Jumping_2.wav");
    jumpSounds[2] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Jumping_3.wav");
    jumpSounds[3] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Jumping_4.wav");
    jumpSounds[4] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Jumping_5.wav");
    jumpSounds[5] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Jumping_6.wav");
    jumpSounds[6] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Jumping_7.wav");
    
    deathSounds[0] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Death_1.wav");
    deathSounds[1] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Death_2.wav");
    deathSounds[2] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Death_3.wav");
    
    bounceSounds[0] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Bouncing_Ball_1.wav");
    bounceSounds[1] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Bouncing_Ball_2.wav");
    bounceSounds[2] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Bouncing_Ball_3.wav");
    bounceSounds[3] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Bouncing_Ball_4.wav");
    bounceSounds[4] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Bouncing_Ball_5.wav");
    bounceSounds[5] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Bouncing_Ball_6.wav");
    bounceSounds[6] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Bouncing_Ball_7.wav");
    bounceSounds[7] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Bouncing_Ball_8.wav");
    bounceSounds[8] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Bouncing_Ball_9.wav");
    bounceSounds[9] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Bouncing_Ball_10.wav");
    bounceSounds[10] = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Bouncing_Ball_11.wav");
    
    chargeUp = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Charge_Up.wav");
    chargeMax = new SoundManager("C:/Illium/GameJam/blujam/sounds/fx/Full_Charge_Loop.wav");
    
    gameOver= false;
    roundNum = 1;
    round = new Round(roundNum, playerOneScore, playerTwoScore,shortShots,medShots,longShots,jumpSounds,deathSounds, bounceSounds, chargeUp, chargeMax);
    
    playerOneScore = 0;
    playerTwoScore = 0;
    
    
    
    
  
    
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
        round = new Round(roundNum,playerOneScore,playerTwoScore,shortShots,medShots,longShots,jumpSounds,deathSounds, bounceSounds, chargeUp, chargeMax);
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
        round = new Round(roundNum,playerOneScore,playerTwoScore,shortShots,medShots,longShots,jumpSounds,deathSounds, bounceSounds, chargeUp, chargeMax);
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