

class Game{
  
  int roundNum;
  boolean gameOver;
  Round round;
  
  int playerOneScore;
  int playerTwoScore;
  
  //Audioplayer round1Musics;
  AudioPlayer round1Music;
  AudioPlayer round2Music;
  AudioPlayer round1Start;
  AudioPlayer round2Start;
  AudioPlayer round3Start;
  
  AudioPlayer shortShot1;
  AudioPlayer shortShot2;
  AudioPlayer shortShot3;
  AudioPlayer shortShot4;
  AudioPlayer shortShot5;
  AudioPlayer shortShot6;
  AudioPlayer shortShot7;
  AudioPlayer medShot1;
  AudioPlayer medShot2;
  AudioPlayer medShot3;
  AudioPlayer medShot4;
  AudioPlayer medShot5;
  AudioPlayer medShot6;
  AudioPlayer medShot7;
  AudioPlayer longShot1;
  AudioPlayer longShot2;
  AudioPlayer longShot3;
  AudioPlayer longShot4;
  AudioPlayer longShot5;
  AudioPlayer longShot6;
  AudioPlayer longShot7;
  
  AudioPlayer[] shortShots = new AudioPlayer[7];
  AudioPlayer[] medShots = new AudioPlayer[7];
  AudioPlayer[] longShots = new AudioPlayer[7];
  
 AudioPlayer[] deathSounds = new AudioPlayer[3];
  
 AudioPlayer[] jumpSounds = new AudioPlayer[7];
 
 AudioPlayer[] bounceSounds = new AudioPlayer[11];
 
 AudioPlayer[] pickupSpawnSounds = new AudioPlayer[11];
 AudioPlayer[] pickupGetSounds = new AudioPlayer[5];
 
  AudioPlayer[] explosions = new AudioPlayer[4];
  
  AudioPlayer[] dashes = new AudioPlayer[4];
 
 AudioPlayer chargeUp;
 AudioPlayer chargeUpv2;
  
  
  boolean isTense;
  
  Game(Minim m){
    
    round1Music = minim.loadFile("sounds/music/Level_1_Music.wav");
    //round1Musics= minim.loadFile("Level_1_Music.wav");
    round2Music = minim.loadFile("sounds/music/Level_2_Music.wav");
    
    round1Start = minim.loadFile("sounds/fx/Round_1.wav");
    round2Start = minim.loadFile("sounds/fx/Round_2.wav");
    round3Start = minim.loadFile("sounds/fx/Round_3.wav");
    
    shortShots[0] = minim.loadFile("sounds/fx/Shot_Weak_1.wav");
    shortShots[1] = minim.loadFile("sounds/fx/Shot_Weak_2.wav");
    shortShots[2] = minim.loadFile("sounds/fx/Shot_Weak_3.wav");
    shortShots[3] = minim.loadFile("sounds/fx/Shot_Weak_4.wav");
    shortShots[4] = minim.loadFile("sounds/fx/Shot_Weak_5.wav");
    shortShots[5] = minim.loadFile("sounds/fx/Shot_Weak_6.wav");
    shortShots[6] = minim.loadFile("sounds/fx/Shot_Weak_7.wav");
    medShots[0] = minim.loadFile("sounds/fx/Shot_Medium_1.wav");
    medShots[1] = minim.loadFile("sounds/fx/Shot_Medium_2.wav");
    medShots[2] = minim.loadFile("sounds/fx/Shot_Medium_3.wav");
    medShots[3] = minim.loadFile("sounds/fx/Shot_Medium_4.wav");
    medShots[4] = minim.loadFile("sounds/fx/Shot_Medium_5.wav");
    medShots[5] = minim.loadFile("sounds/fx/Shot_Medium_6.wav");
    medShots[6] = minim.loadFile("sounds/fx/Shot_Medium_7.wav");
    longShots[0] = minim.loadFile("sounds/fx/Shot_Full_1.wav");
    longShots[1] = minim.loadFile("sounds/fx/Shot_Full_2.wav");
    longShots[2] = minim.loadFile("sounds/fx/Shot_Full_3.wav");
    longShots[3] = minim.loadFile("sounds/fx/Shot_Full_4.wav");
    longShots[4] = minim.loadFile("sounds/fx/Shot_Full_5.wav");
    longShots[5] = minim.loadFile("sounds/fx/Shot_Full_6.wav");
    longShots[6] = minim.loadFile("sounds/fx/Shot_Full_7.wav");
    
    jumpSounds[0] = minim.loadFile("sounds/fx/Jumping_1.wav");
    jumpSounds[1] = minim.loadFile("sounds/fx/Jumping_2.wav");
    jumpSounds[2] = minim.loadFile("sounds/fx/Jumping_3.wav");
    jumpSounds[3] = minim.loadFile("sounds/fx/Jumping_4.wav");
    jumpSounds[4] = minim.loadFile("sounds/fx/Jumping_5.wav");
    jumpSounds[5] = minim.loadFile("sounds/fx/Jumping_6.wav");
    jumpSounds[6] = minim.loadFile("sounds/fx/Jumping_7.wav");
    
    deathSounds[0] = minim.loadFile("sounds/fx/Death_1.wav");
    deathSounds[1] = minim.loadFile("sounds/fx/Death_2.wav");
    deathSounds[2] = minim.loadFile("sounds/fx/Death_3.wav");
    
    bounceSounds[0] = minim.loadFile("sounds/fx/Bouncing_Ball_1.wav");
    bounceSounds[1] = minim.loadFile("sounds/fx/Bouncing_Ball_2.wav");
    bounceSounds[2] = minim.loadFile("sounds/fx/Bouncing_Ball_3.wav");
    bounceSounds[3] = minim.loadFile("sounds/fx/Bouncing_Ball_4.wav");
    bounceSounds[4] = minim.loadFile("sounds/fx/Bouncing_Ball_5.wav");
    bounceSounds[5] = minim.loadFile("sounds/fx/Bouncing_Ball_6.wav");
    bounceSounds[6] = minim.loadFile("sounds/fx/Bouncing_Ball_7.wav");
    bounceSounds[7] = minim.loadFile("sounds/fx/Bouncing_Ball_8.wav");
    bounceSounds[8] = minim.loadFile("sounds/fx/Bouncing_Ball_9.wav");
    bounceSounds[9] = minim.loadFile("sounds/fx/Bouncing_Ball_10.wav");
    bounceSounds[10] = minim.loadFile("sounds/fx/Bouncing_Ball_11.wav");
    
     pickupSpawnSounds[0] = minim.loadFile("sounds/fx/Powerup_Spawn_1.wav");
    pickupSpawnSounds[1] = minim.loadFile("sounds/fx/Powerup_Spawn_2.wav");
    pickupSpawnSounds[2] = minim.loadFile("sounds/fx/Powerup_Spawn_3.wav");
    pickupSpawnSounds[3] = minim.loadFile("sounds/fx/Powerup_Spawn_4.wav");
    pickupSpawnSounds[4] = minim.loadFile("sounds/fx/Powerup_Spawn_5.wav");
    pickupSpawnSounds[5] = minim.loadFile("sounds/fx/Powerup_Spawn_6.wav");
    pickupSpawnSounds[6] = minim.loadFile("sounds/fx/Powerup_Spawn_7.wav");
    pickupSpawnSounds[7] = minim.loadFile("sounds/fx/Powerup_Spawn_8.wav");
    pickupSpawnSounds[8] = minim.loadFile("sounds/fx/Powerup_Spawn_9.wav");
    pickupSpawnSounds[9] = minim.loadFile("sounds/fx/Powerup_Spawn_10.wav");
    pickupSpawnSounds[10] = minim.loadFile("sounds/fx/Powerup_Spawn_11.wav");
    
    chargeUp = minim.loadFile("C:/Illium/GameJam/blujam/sounds/fx/Charge_Up.wav");
    chargeUpv2 = minim.loadFile("C:/Illium/GameJam/blujam/sounds/fx/Charge_Up.wav");
    
     pickupGetSounds[0] = minim.loadFile("sounds/fx/Powerup_Pickup_1.wav");
    pickupGetSounds[1] = minim.loadFile("sounds/fx/Powerup_Pickup_2.wav");
    pickupGetSounds[2] = minim.loadFile("sounds/fx/Powerup_Pickup_3.wav");
    pickupGetSounds[3] = minim.loadFile("sounds/fx/Powerup_Pickup_4.wav");
    pickupGetSounds[4] = minim.loadFile("sounds/fx/Powerup_Pickup_5.wav");
   
     explosions[0] = minim.loadFile("C:/Illium/GameJam/blujam/sounds/fx/Shaking_1.wav");
    explosions[1] = minim.loadFile("C:/Illium/GameJam/blujam/sounds/fx/Shaking_2.wav");
    explosions[2] = minim.loadFile("C:/Illium/GameJam/blujam/sounds/fx/Shaking_3.wav");
    explosions[3] = minim.loadFile("C:/Illium/GameJam/blujam/sounds/fx/Shaking_4.wav");
    
    dashes[0] = minim.loadFile("C:/Illium/GameJam/blujam/sounds/fx/Dash_Low_1.wav");
    dashes[1] = minim.loadFile("C:/Illium/GameJam/blujam/sounds/fx/Dash_Low_2.wav");
    dashes[2] = minim.loadFile("C:/Illium/GameJam/blujam/sounds/fx/Dash_Low_3.wav");
    dashes[3] = minim.loadFile("C:/Illium/GameJam/blujam/sounds/fx/Dash_Low_4.wav");
    
    gameOver= false;
    roundNum = 1;
    round = new Round(roundNum, playerOneScore, playerTwoScore,shortShots,medShots,longShots,jumpSounds,deathSounds, bounceSounds, chargeUp, chargeUpv2, pickupSpawnSounds, 
    pickupGetSounds, explosions, dashes);
    
    playerOneScore = 0;
    playerTwoScore = 0;
    
    
    
    
  
    
    round1Start.play();
  
    round1Music.loop();
    
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
          round1Music.pause();
          round1Music.rewind();
          round2Music.loop();
        }
        isTense = true;
        
      }
      if (playerTwoScore==3) {
        gameOver=true;
        roundNum++;
        
      }
      else{
        roundNum++;
        round = new Round(roundNum,playerOneScore,playerTwoScore,shortShots,medShots,longShots,jumpSounds,deathSounds, bounceSounds, chargeUp, chargeUpv2, pickupSpawnSounds,
        pickupGetSounds, explosions, dashes);
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
       if(playerOneScore==2){
          if(isTense==false){
          round1Music.pause();
          round1Music.rewind();
          round2Music.loop();
        }
        isTense = true;
        
      }
      if (playerOneScore==3) {
        gameOver=true;
        roundNum++;
      }
      else{
        roundNum++;
        round = new Round(roundNum,playerOneScore,playerTwoScore,shortShots,medShots,longShots,jumpSounds,deathSounds, bounceSounds, chargeUp, chargeUpv2, pickupSpawnSounds,
        pickupGetSounds, explosions, dashes);
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
 
  round1Music.pause();
  round1Music.rewind();
  round2Music.pause();
  round2Music.rewind();
}

}