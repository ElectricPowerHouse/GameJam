import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 
import ddf.minim.analysis.*; 
import ddf.minim.effects.*; 
import ddf.minim.signals.*; 
import ddf.minim.spi.*; 
import ddf.minim.ugens.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Ilium extends PApplet {









GameManager gameManager;
Minim minim;

public void setup(){
  
  minim = new Minim(this);
  
  
  //size(600,600);
  rectMode(CENTER);
gameManager = new GameManager(minim);



//SoundManager test = new SoundManager("C:/Illium/GameJam/blujam/sounds/TitleScreen.wav");
//test.play();



}

public void draw(){
  
  gameManager.drawManager();
}


public void keyPressed(){
  
 
 gameManager.keyPressedManager();
  
}
public void keyReleased(){
  
  
gameManager.keyReleasedManager();
  
  
}
class BlueHole{
  
  float sz;
  float ang;
  PImage voi, debris;
  
  BlueHole(float size){
    
    sz = size;
    voi = loadImage("center.png");
    debris = loadImage("debris.png");
  }
  
  
  
  public void drawHole(){
    pushStyle();
    pushMatrix();
    imageMode(CENTER);
    ang += PI/2000;
    noStroke();
    fill(20,132,244);
    pushMatrix();
    rotate(ang);
    image(voi, 0,0,sz,sz);
    popMatrix();
    pushMatrix();
    rotate(-ang);
    image(debris, 0,0,sz,sz);
    popMatrix();
    popMatrix();
    popStyle();
  }
  
  
}
class Explosion {
  
  float a, distance, inc;
  int basecol, lerpcol;
  float colinc = 0;
  float colincagain = 0.0f;
  boolean expired;
  ArrayList<Particle> parts = new ArrayList<Particle>();
  PImage partImg;
  
  Explosion(float angle, float dist, int col, PImage particle) {
    partImg = particle;
    a = angle;
    distance = dist;
    basecol = col;
    lerpcol = color(255, 220, 20);
    int num = PApplet.parseInt(random(3, 9));
    for (int i = 0; i < num; i++) {
      parts.add(new Particle(partImg));
    }
  }
  
  public void display() {
    this.updateCol();
    pushMatrix();
    pushStyle();
    noStroke();
    tint(basecol);
    rotate(a);
    translate(0,distance);
    for (Particle part : parts) {
      pushMatrix();
      rotate(part.angle);
      part.display();
      popMatrix();
    }
    popStyle();
    popMatrix();
  }
  
  public void updateCol() {
    basecol = lerpColor(basecol, lerpcol, colinc);
    colinc += colincagain;
    colincagain += 0.008f;
    if (colinc > 1) {
      expired = true;
      for (int i = parts.size()-1; i >=0; i--) {
        parts.remove(i);
      }
    }
  }
}


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
    
    chargeUp = minim.loadFile("sounds/fx/Charge_Up.wav");
    chargeUpv2 = minim.loadFile("sounds/fx/Charge_Up.wav");
    
     pickupGetSounds[0] = minim.loadFile("sounds/fx/Powerup_Pickup_1.wav");
    pickupGetSounds[1] = minim.loadFile("sounds/fx/Powerup_Pickup_2.wav");
    pickupGetSounds[2] = minim.loadFile("sounds/fx/Powerup_Pickup_3.wav");
    pickupGetSounds[3] = minim.loadFile("sounds/fx/Powerup_Pickup_4.wav");
    pickupGetSounds[4] = minim.loadFile("sounds/fx/Powerup_Pickup_5.wav");
   
     explosions[0] = minim.loadFile("sounds/fx/Shaking_1.wav");
    explosions[1] = minim.loadFile("sounds/fx/Shaking_2.wav");
    explosions[2] = minim.loadFile("sounds/fx/Shaking_3.wav");
    explosions[3] = minim.loadFile("sounds/fx/Shaking_4.wav");
    
    dashes[0] = minim.loadFile("sounds/fx/Dash_Low_1.wav");
    dashes[1] = minim.loadFile("sounds/fx/Dash_Low_2.wav");
    dashes[2] = minim.loadFile("sounds/fx/Dash_Low_3.wav");
    dashes[3] = minim.loadFile("sounds/fx/Dash_Low_4.wav");
    
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
  

  
public void drawGame(){ 
  
  
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

public void keyPressedGame(){
  
  
  
 round.keyPressedRound(); 
  
}


public void keyReleasedGame(){
  
  round.keyReleasedRound();
  
}

public void stopMusic(){
 
  round1Music.pause();
  round1Music.rewind();
  round2Music.pause();
  round2Music.rewind();
}

}




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
  
  Minim m;

  String gameState;
  Game game;
  
  AudioPlayer menuMusic;
  AudioPlayer startSound;

  GameManager(Minim m) {
    
    menuMusic = minim.loadFile("data/sounds/music/Title_Screen.wav");
    //menuMusic = new SoundManager("C:/Illium/GameJam/blujam/sounds/music/Title_Screen.wav");
    startSound = minim.loadFile("data/sounds/fx/Round_1.wav");

    calibri = createFont("font/calibri.ttf", 32); 
    pointed = createFont("font/Pointed.ttf", height/4);

    gameState = "MAINMENU";
    //gameState = "PLAYING";
    //game = new Game();    // delete this when menu properly implemented
    this.m=m;
    
    //menuMusic.playLoop();
    menuMusic.loop();
  }



  public void drawManager() {



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


  public void drawMenu() {
    pushStyle();
    imageMode(CENTER);
    //textMode(CENTER);
    background(37);
    fill(255);


    textFont(pointed, height/3);
    text("ILIUM", width*0.3f, (height/2.3f));
    textFont(pointed, height/12);
    
    if(flash){
    text("press any key to battle", width*0.31f, (height-(height/2.2f)));
    }
    
    
    image(wasd, width*0.3f, height*0.66f, wasdWidth/1.5f, wasdHeight/1.5f);
    image(arrows, width*0.75f, height*0.66f - 20, arrowWidth/1.5f, arrowHeight/1.5f);
    popStyle();


    if (moveDown) {
      modY+=0.2f;
    } else {
      modY-=0.2f;
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




  public void keyPressedManager() {
    
    

    if (gameState.equals("MAINMENU")) {

      
      menuMusic.pause();
      menuMusic.rewind();

      game = new Game(m);
      gameState = "PLAYING";
    } else {
      
     
      
      if(keyCode == ENTER && game.gameOver==true){
         
        game.stopMusic();
        
        menuMusic.loop();
        gameState="MAINMENU";
        
       }

      if (game!=null) {
        game.keyPressedGame();
      }
    }
  }

  public void keyReleasedManager() {

    if (gameState.equals("PLAYING")) {

      game.keyReleasedGame();
    }
  }
}
class LightBar{
  
  float prevx, prevy, curx, cury;
  
  float sz;
  int col;
  float dur;
  boolean expired;
  
  LightBar(float hght, int basecol, float duration, float x1, float x2, float y1, float y2) {
    
    sz = hght;
    prevx = x1;
    prevy = y1;
    curx = x2;
    cury = y2;
    
    col = basecol;
    dur = duration;
  }
  
  public void display() {
    this.update();
    pushMatrix();
    stroke(col);
    strokeWeight(sz);
    strokeCap(SQUARE);
    line(prevx, prevy, curx, cury);
    popMatrix();
    
  }
  
  public void update(){
    col = color(red(col), green(col), blue(col), alpha(col) - dur);
    sz *= 0.98f;
    if (alpha(col) <= 0) {
      expired = true;
    }
  }
}
class LightTrail{
  
  float x1, y1, x2, y2;
  int col;
  float dur, sz;
  ArrayList<LightBar> trail = new ArrayList<LightBar>();
  
  LightTrail(int lightCol, float duration, float hght, float dist) {
    col = lightCol;
    dur = duration;
    sz = hght;
    y1 = dist;
    y2 = dist;
  }
  
  public void drawLight() {
    for (LightBar segment : trail) {
      segment.display();
    }
    for (int i = trail.size() - 1; i >= 0; i--) {
      LightBar tempBar = trail.get(i);
      if (tempBar.expired) {
        trail.remove(i);
      }
    }
  }
  
  public void updateLight(float angle, float dist, int newCol) {
    col = newCol;
    x1 = x2;
    y1 = y2;
    x2 = -(dist)*sin(angle);
    y2 = (dist)*cos(angle);
    trail.add(new LightBar(sz,col,dur,x1, x2, y1, y2));
  }
}
class Particle {
  
  float inc = random(2,7);
  float ydiff = 0;
  float wd, ht, angle;
  PImage part;
  
  Particle(PImage disp) {
    part = disp;
    wd = random(3,8);
    ht = random(4,10);
    angle = random(-3*PI/7.0f, 3*PI/7.0f);
  }
  
  public void display(){
    image(part, 0, -ydiff, wd, ht);
    ydiff += inc;
  }
}

//random 0-2 pi angle
class Pickup {

  
  PImage[] pickupImage = new PImage[3];
  
  float angle, dist, wd, ht;
  boolean active, activateMe;
  int type;
  int imageNum = 0;
  float startTime;
  float curTime;
  float dur = 10000;

  int c = color(0, 0, 0);
  
  AudioPlayer[] pickupSpawnSounds;
  AudioPlayer[] pickupGetSounds;


  Pickup (float distance, AudioPlayer[] pickupSpawnSounds, AudioPlayer[] pickupGetSounds) {

    getRandomType();

    pickupImage[0] = loadImage("cyangem.png");
    pickupImage[1] = loadImage("redgem.png");
    pickupImage[2] = loadImage("orangegem.png");
    active = false;
    startTime = millis();
    dist = distance;

    angle = random(0, 2)*PI;
    
    this.pickupSpawnSounds=pickupSpawnSounds;
    this.pickupGetSounds=pickupGetSounds;
  }


  public void drawPickup() {
    this.updatePickup();
    if (!active) {
      return;
    }

    pushMatrix();

    rotate(angle);
    pushStyle();
    imageMode(CENTER);
    image(pickupImage[imageNum],0, dist-(ht/2.0f), wd, ht);
    popStyle();
    popMatrix();
  }


  public float getAngle() {

    return angle;
  }

  public void deActivate() {
    int randomChoose = PApplet.parseInt(random(0,5));
    pickupGetSounds[randomChoose].play();
        
    startTime = millis();
    active = false;
    dur = PApplet.parseInt(random(10000, 15000));
  }
  
  public void updatePickup() {
    if (!active) {
      curTime = millis();
      if (curTime - startTime >= dur) {
        
        int randomChoose = PApplet.parseInt(random(0,11));
        pickupSpawnSounds[randomChoose].play();
              
        activateMe = true;
      }
    }
  }

  public void activate(float angle1, float angle2) {
    float targAngle = angle1;
    float curAngle = angle2;
    if (abs(targAngle/(2*PI)) > 1) {
      targAngle -= (PApplet.parseInt(targAngle/(2*PI))*2*PI);
    }
    if (abs(curAngle/(2*PI)) > 1) {
      curAngle -= (PApplet.parseInt(curAngle/(2*PI))*2*PI);
    }
    if (curAngle < 0) {
      curAngle += 2*PI;
    }
    if (targAngle < 0) {
      targAngle += 2*PI;
    }
    float[] angles = new float[2];
    angles[0] = (targAngle + curAngle)/2.0f;
    angles[1] = ((targAngle + curAngle)/2.0f)-PI;
    angle = angles[PApplet.parseInt(random(2))];
    getRandomType();
    activateMe = false;
    active = true;
  }

  public boolean isActive() {
    return active;
  }


  public void getRandomType() {

    type = PApplet.parseInt(random(1, 4));
    
    if (type==1) {
      imageNum = 0;
      wd = width/45;
    } else if (type ==2) {
      imageNum = 1;
      wd = width/34;
    } else {
      imageNum = 2;
      wd = width/27;
    }
    ht=wd;
  }
  
  
}
class Player{
  float angle, dist, wd, ht, jumpDif, baseDist;
  boolean touchingGround, dead, poweredUp, dangerous, chargeAvailable;
  int powerType = 0;
  int col, defCol, curCol;
  int flipVal = 1;
  PImage img, proj;
  LightTrail[] trail = new LightTrail[3];
  float powerStart, powerDuration, powerCount;
  
  AudioPlayer[] deathSounds;

  
  Player (float a, float distance, float widt, float hght, int baseCol, PImage image, AudioPlayer[] deathSounds) {
    angle = a;
    dist = distance;
    baseDist = distance;
    wd = widt;
    ht = hght;
    col = baseCol;
    defCol = baseCol;
    curCol = baseCol;
    jumpDif = 0;
    img = image;
    proj = loadImage("proj.png");
    powerDuration = 4000;
    int mult;
    if (angle > 0) {
      mult = -1;
    } else {
      mult = 1;
    }
    for (int i = 0; i < 3; i++) {   
      if (i == 1) {
        trail[i] = new LightTrail(col, 10, ht/6.5f, mult*dist);
      } else {
        trail[i] = new LightTrail(col, 10, ht/12.0f, mult*dist);
      }
    }
    poweredUp=false;
    this.deathSounds=deathSounds;
  }
  
  public void display() {
    if (!dead) {
      if (poweredUp && powerType != 2) {
        if (powerType == 3) {
          wd = 100;
          ht = 100;
        }
        powerCount = millis();
        if (powerCount - powerStart >= powerDuration) {
          if (powerType == 3) {
            wd = 64;
            ht = 64;
          }
          poweredUp = false;
          powerType = 0;
        }
      } else if (powerType == 2) {
        if (!chargeAvailable) {
          poweredUp = false;
          powerType = 0;
        }
      }
      pushMatrix();
      this.updateJump();
      for (int i = 0; i < 3; i++) {  
        trail[i].updateLight(angle,dist-(ht/2.7f)-(i*(ht/10.8f)),col);         
        trail[i].drawLight();
      }
      
      if (dist > baseDist) {
        touchingGround = true;
        dist = baseDist;
        jumpDif = 0;
      }
      rotate(angle);
      noStroke();
      fill(col);
      ellipse(flipVal*wd/6.0f, dist-ht/2.0f, wd/4.0f, ht/4.0f);
      scale(flipVal,1);
      image(img, -wd/2.0f, dist-ht, wd, ht);
      popMatrix();
    }
  }
  
  public void update(float angleDif) {
    if (!dead) {
      angle += angleDif;
    }
    
  }
  
  public void updateCols() {
    if (powerType == 0) {
      col = defCol;
      curCol = defCol;
    } else if (powerType == 1) {
      col = color(23,236,255);
      curCol = color(23,236,255);
    } else if (powerType == 2) {
      col = color(211,0,64);
      curCol = color(211,0,64);
    } else if (powerType == 3) {
      col = color(243,87,0);
      curCol = color(243,87,0);
    }
  }
  
  public void updateJump() {
    if (!touchingGround) {
      dist -= jumpDif;
      jumpDif -= 0.5f;
      if (dist < baseDist/3.0f) {
        dead = true;
      }
    }
  }
  
  public void jump(float jumpVel) {
    if (touchingGround) {
      touchingGround = false;
      jumpDif = jumpVel;
    }
  }
  
  public void checkCollisions(ArrayList<Projectile> enemyProjs) {
    if (!dead && angle != 0) {
      for(Projectile checkProj : enemyProjs) {
        if (checkProj.dead || checkProj.type == 1) {
          float targAngle = checkProj.finalangle;
          float curAngle = angle;
          if (abs(targAngle/(2*PI)) > 1) {
            targAngle -= (PApplet.parseInt(targAngle/(2*PI))*2*PI);
          }
          if (abs(curAngle/(2*PI)) > 1) {
            curAngle -= (PApplet.parseInt(curAngle/(2*PI))*2*PI);
          }
          if (curAngle < 0) {
            curAngle += 2*PI;
          }
          if (targAngle < 0) {
            targAngle += 2*PI;
          }
          if (checkProj.type == 3) {
            if (curAngle >= targAngle - PI/10.0f && curAngle <= targAngle + PI/10.0f && dist > baseDist-ht) {
              int randomChoose = PApplet.parseInt(random(0,3));
              deathSounds[randomChoose].play();
           
              this.jump(20);
            }
          } else {
            if (curAngle >= targAngle - PI/20.0f && curAngle <= targAngle + PI/20.0f && dist > baseDist-ht) {
               int randomChoose = PApplet.parseInt(random(0,3));
              deathSounds[randomChoose].play();
              this.jump(20);
            }
          }
        }
      }
    }
  }
  
  public float getAngle(){
   
    return angle;
  }
}
class Projectile{
  float dist, baseDist, xVel, yVel, angle, finalangle;
  float xPos = 0;
  int bounces = 2;
  int type = 1;
  boolean dead = false;
  float initXVel, initYVel;
  boolean isBouncy;
  PImage pro;
  int col;
  float wd = 18;
  float ht = 18;
  AudioPlayer[] bounceSounds;
  AudioPlayer[] explosions;
  
  Projectile(float distance, float bounds, float xVelocity, float a, float yVelocity, int type, PImage proj, int initCol, AudioPlayer[] bounceSounds, AudioPlayer[] explosions) {
    dist = distance;
    baseDist = bounds;
    xVel = xVelocity;
    yVel = yVelocity;
    initXVel = xVel;
    initYVel = yVel;
    angle = a;
    pro = proj;
    col = initCol;
    this.type = type;
    if (type == 3) {
      wd = 40;
      ht = 40;
    }
    this.bounceSounds = bounceSounds;
    this.explosions = explosions;
    
  }
  
  public void display() {
    if (!dead) {
      if (type == 0 || type == 3) {
        this.update();
      } else if (type == 1) {
        this.bounceUpdate();
      }
      pushMatrix();
      rotate(angle);
      pushStyle();
      tint(col);
      image(pro, xPos, dist-10, wd, ht);
      popStyle();
      popMatrix();
    }
  }
  
  public void update() {
    if(xVel != 0) {
      xPos += xVel;
      xVel += ((abs(xVel))/xVel)*0.05f;
    }
    dist -= yVel;
    yVel -= 0.25f;
    if (sqrt(sq(xPos)+sq(dist)) >= baseDist) {
      finalangle = angle-(((abs(xVel))/xVel)*2*(asin(((sqrt(sq(xPos)+sq(baseDist-dist)))/2.0f)/baseDist)));
      dead = true;
      
       int randomChoose = PApplet.parseInt(random(0,4));
        explosions[randomChoose].play();
        
    }
  }
  
  public void bounceUpdate(){
    if(xVel != 0) {
      xPos += xVel;
      xVel += ((abs(xVel))/xVel)*0.05f;
    }
    dist -= yVel;
    yVel -= 0.25f;
    if (sqrt(sq(xPos)+sq(dist)) >= baseDist) {
      if(bounces>0){
        
        int randomChoose = PApplet.parseInt(random(0,11));
        bounceSounds[randomChoose].play();
        
        finalangle = angle-(((abs(xVel))/xVel)*2*(asin(((sqrt(sq(xPos)+sq(baseDist-dist)))/2.0f)/baseDist)));
        angle = finalangle;
        xPos = 0;
        xVel = initXVel;
        yVel = initYVel;
        dist = baseDist-2;
        bounces--;
      } else {
        finalangle = angle-(((abs(xVel))/xVel)*2*(asin(((sqrt(sq(xPos)+sq(baseDist-dist)))/2.0f)/baseDist)));
        
        int randomChoose = PApplet.parseInt(random(0,4));
        explosions[randomChoose].play();
        
        dead = true;
      }
    }
  }
  
}

class Round{
  
  BlueHole blueHole;
  Pickup pickup;
  
  boolean chargeSoundp1;
  boolean screenShake;
  boolean up = true;
  int screeninc;
  int shakeLength = 2;
  float shakeAngle = PI/200.0f;
  int count = 180;
  boolean fade = false;
  PFont pointed;
  
  //SoundManager round1 = new SoundManager("C:/Users/Jackson/Desktop/GameJam/blujam/sounds/Level1Music.wav");
  //SoundManager round2 = new SoundManager("C:/Users/Jackson/Desktop/GameJam/blujam/sounds/TitleScreen.wav");

  float ellipseSz = 800;
  
  float playerWd = ellipseSz/13;
  float playerHt = ellipseSz/13;
  
  PImage image1 = loadImage("test1.png");
  PImage image2 = loadImage("test2.png");
  PImage splash = loadImage("splash.png");
  
  PImage l_ava_h = loadImage("l_head.png");
  PImage l_ava_b = loadImage("l_body.png");
  PImage l_ava_g = loadImage("l_glow.png");
  
  PImage r_ava_h = loadImage("r_head.png");
  PImage r_ava_b = loadImage("r_body.png");
  PImage r_ava_g = loadImage("r_glow.png");
  PImage bg = loadImage("bg.png");
  PImage mainbg = loadImage("mainbg.png");
  PShape ring = loadShape("ring.svg");
  PShape ring2 = loadShape("ring.svg");
  PImage proj = loadImage("proj.png");

  Player playerOne;
  Player playerTwo;
  

  
  ArrayList<Projectile> p1projectiles = new ArrayList<Projectile>();
  float p1projvelocity = 0;
  float p1aim = -1;
  
  ArrayList<Projectile> p2projectiles = new ArrayList<Projectile>();
  float p2projvelocity = 0;
  float p2aim = -1;
  
  float maxVel = 18;
  float minVel = 3;
  float p1movespeed = PI/180.0f;
  float p2movespeed = PI/180.0f;
  float chargeInc = 0.35f;
  float projxvel = 3;
  float jumpHght = 8;
  
  boolean p1right, p1left, p1jump, p1fire, p1charge, p2right, p2left, p2jump, p2fire, p2charge;
  
  int roundOver = 0;
  int roundNum;
  int playerOneScore;
  int playerTwoScore;
  
  ArrayList<Explosion> explosions = new ArrayList<Explosion>();
  

  
  AudioPlayer[] shortShots;
  AudioPlayer[] medShots;
  AudioPlayer[] longShots;
  AudioPlayer[] jumpSounds;
  AudioPlayer[] deathSounds;
  AudioPlayer[] bounceSounds;
  AudioPlayer[] pickupSpawnSounds;
  AudioPlayer[] pickupGetSounds;
  AudioPlayer[] explosion;
  AudioPlayer[] dashes;
  
  AudioPlayer chargeUp1;
  AudioPlayer chargeUp2;
  AudioPlayer chargeMax;
  
  
  
  int shortShotMax = 8;
  int medShotMax = 13;
  int longShotMax = 18;
  

  Round(int roundCount, int playerOneScore, int playerTwoScore, AudioPlayer[] shortShots, AudioPlayer[] medShots, AudioPlayer[] longShots, AudioPlayer[] jumpSounds, 
  AudioPlayer[] deathSounds, AudioPlayer[] bounceSounds, AudioPlayer chargeUp, AudioPlayer chargeUpv2, AudioPlayer[]  pickupSpawnSounds,
   AudioPlayer[] pickupGetSounds, AudioPlayer[] explosions, AudioPlayer[] dashes){
    
    
     ellipseSz = width/2.48f;
     
    this.deathSounds = deathSounds;
    
    playerOne = new Player(PI, ellipseSz/2.0f, playerWd, playerHt, color(100,255,0), image1, deathSounds);
    playerTwo = new Player(0.0f, ellipseSz/2.0f, playerWd, playerHt, color(220,0,255), image2, deathSounds);
    
    pointed = createFont("font/Pointed.ttf", height/4);
    roundNum = roundCount;
    this.playerOneScore = playerOneScore;
    this.playerTwoScore = playerTwoScore;
    
    blueHole= new BlueHole(ellipseSz/4.0f);
    pickup = new Pickup(ellipseSz/2.0f,pickupSpawnSounds,pickupGetSounds);
    
    if (roundNum == 1) {
      //round1.playLoop();
    } else if (roundNum == 2) {
      //round2.playLoop();
    }
    
    //STYLE BACKGROUND
    ring.disableStyle();
    
    ring2.disableStyle();
    
    
    this.shortShots = shortShots;
    this.medShots = medShots;
    this.longShots = longShots;
    this.jumpSounds = jumpSounds;
    this.bounceSounds=bounceSounds;
    this.chargeUp1 = chargeUp;
    this.chargeUp2 = chargeUpv2;
    this.pickupSpawnSounds=pickupSpawnSounds;
    this.pickupGetSounds=pickupGetSounds;
    this.explosion = explosions;
    this.dashes = dashes;
    
    
  }

  public void drawRound() {
    
    
    checkChargeSounds();
    checkPickupSpawn();
    checkPickupCollision(playerOne);
    checkPickupCollision(playerTwo);
    if (playerOne.dead) {
      roundOver = 1;
    }
    if (playerTwo.dead) {
      roundOver = 2;
    }
    if (roundOver > 0) {
      if (roundNum == 1) {
        //round1.stop();
      } else if (roundNum == 2) {
        //round2.stop();
      }
    }
    
    background(10);
    pushMatrix();
    translate(width/2.0f, height/2.0f);
    
    
    if (screenShake) {
      rotate(shakeAngle*screeninc);
      if (up && screeninc < shakeLength) {
        screeninc++;
      } else if (up && screeninc == shakeLength) {
        up = false;
        screeninc--;
      } else if (!up && screeninc > -shakeLength) {
        screeninc--;
      } else if (!up && screeninc == -shakeLength) {
        up = true;
        screeninc++;
      }
      shakeAngle *= 0.90f;
      if (shakeAngle < PI/800.0f) {
        screenShake = false;
        shakeAngle = PI/200.0f;
      }
    }
    
    pushStyle();
    imageMode(CENTER);
    image(mainbg,0,0,width,height);
    
    fill(255);
    textFont(pointed, height/18.0f);
    text("ILIUM", -(height/15), -(height/2.3f));
   
    popStyle();
    drawBounds();
    blueHole.drawHole();
    
    if (p1left) {
      p1aim = -1;
      playerOne.flipVal = 1;
      if (playerOne.powerType == 3) {
        playerOne.update(p1movespeed*0.7f);
      } else {
        playerOne.update(p1movespeed);
      }
    }
    if (p1right) {
      p1aim = 1;
      playerOne.flipVal = -1;
      if (playerOne.powerType == 3) {
        playerOne.update(-p1movespeed*0.7f);
      } else {
        playerOne.update(-p1movespeed);
      }
    }
    if (p2left) {
      p2aim = -1;
      playerTwo.flipVal = 1;
      if (playerTwo.powerType == 3) {
        playerTwo.update(p2movespeed*0.7f);
      } else {
        playerTwo.update(p2movespeed);
      }
    }
    if (p2right) {
      p2aim = 1;
      playerTwo.flipVal = -1;
      if (playerTwo.powerType == 3) {
        playerTwo.update(-p2movespeed*0.7f);
      } else {
        playerTwo.update(-p2movespeed);
      }
    }
    if (p1jump) {
      if(playerOne.touchingGround){
      int randomChoose = PApplet.parseInt(random(0,7));
      jumpSounds[randomChoose].play();
      }
      
      playerOne.jump(jumpHght);
      p1jump = false;
    }
    if (p2jump) {
      if(playerTwo.touchingGround){
      int randomChoose = PApplet.parseInt(random(0,7));
      jumpSounds[randomChoose].play();
      }
      
      playerTwo.jump(jumpHght);
      p2jump = false;
    }
    if (p1charge) {
      if (playerOne.powerType == 2) {
        p1movespeed *= 0.98f;
      }
      if (p1projvelocity < maxVel) {
        p1projvelocity += chargeInc;
        playerOne.col = lerpColor(playerOne.curCol, color(255,0,0), map(p1projvelocity, 0, maxVel, 0, 1));
      } else {
        playerOne.col = color(255,0,0); //change max charge appearance here
      }
    }
    if (p1fire) {
      if (playerOne.powerType != 2) {
        if(p1projvelocity > minVel) {
          
          int randomChoose = PApplet.parseInt(random(0,7));
          //if p1 vel is above 
          if(p1projvelocity>2&&p1projvelocity<shortShotMax){
            shortShots[randomChoose].play();
            
          }
          else if(p1projvelocity>shortShotMax&&p1projvelocity<medShotMax){
            medShots[randomChoose].play();
          }
          else{
            longShots[randomChoose].play();
          }
          
         
          p1projectiles.add(new Projectile(playerOne.dist, ellipseSz/2.0f, projxvel*p1aim, playerOne.angle, p1projvelocity,playerOne.powerType, playerOne.proj, playerOne.col,bounceSounds, explosion));
        }
      } else {
         int randomChoose = PApplet.parseInt(random(0,4));
        dashes[randomChoose].play();
        
        playerOne.dangerous = true;
        p1movespeed = PI/360.0f*p1projvelocity;
        if (p1movespeed > PI/30.0f) {
          p1movespeed = PI/30.0f;
        }
      }
      p1fire = false;
      p1projvelocity = 0;
      playerOne.col = playerOne.defCol; //revert to non charged appearance here
    }
    
    if (p1movespeed > PI/180.0f) {
      p1movespeed *= 0.95f;
    } else if (!p1charge && playerOne.chargeAvailable && playerOne.dangerous) {
      playerOne.dangerous = false;
      playerOne.chargeAvailable = false;
      p1movespeed = PI/180.0f;
    }
    
    if (p2charge) {
      if (playerTwo.powerType == 2) {
        p2movespeed *= 0.98f;
      }
      if (p2projvelocity < maxVel) {
        p2projvelocity += chargeInc;
        playerTwo.col = lerpColor(playerTwo.curCol, color(255,0,0), map(p2projvelocity, 0, maxVel, 0, 1));
      } else {
        playerTwo.col = color(255,0,0); //change max charge appearance here
      }
    }
    if (p2fire) {
      if (playerTwo.powerType != 2) {
        // if p2 ...
      if(p2projvelocity > minVel) {
        
          int randomChoose = PApplet.parseInt(random(0,7));
          //if p1 vel is above 
          if(p2projvelocity>2&&p2projvelocity<shortShotMax){
            shortShots[randomChoose].play();     
          }
          else if(p2projvelocity>shortShotMax&&p2projvelocity<medShotMax){
            medShots[randomChoose].play();
          }
          else{
            longShots[randomChoose].play();
          }
         
        p2projectiles.add(new Projectile(playerTwo.dist, ellipseSz/2.0f, projxvel*p2aim, playerTwo.angle, p2projvelocity, playerTwo.powerType, playerTwo.proj, playerTwo.col,bounceSounds, explosion));
      }
      } else {
        int randomChoose = PApplet.parseInt(random(0,4));
        dashes[randomChoose].play();
        
        
        playerTwo.dangerous = true;
        p2movespeed = PI/360.0f*p2projvelocity;
        if (p2movespeed > PI/30.0f) {
          p2movespeed = PI/30.0f;
        }
      }
      p2fire = false;
      p2projvelocity = 0;
      playerTwo.col = playerTwo.defCol; //revert to non charged appearance here
    }
    
    if (p2movespeed > PI/180.0f) {
      p2movespeed *= 0.95f;
    } else if (!p2charge && playerTwo.chargeAvailable && playerTwo.dangerous) {
      playerTwo.dangerous = false;
      playerTwo.chargeAvailable = false;
      p2movespeed = PI/180.0f;
    }
    
    
    if (p1projectiles.size() > 0 && playerOneScore < 3 && playerTwoScore < 3) {
      for(Projectile curProj : p1projectiles) {
        curProj.display();
        if (curProj.dead) {
          screenShake = true;
          explosions.add(new Explosion(curProj.finalangle, ellipseSz/2.0f, curProj.col, proj));
        }
      }
    }
    
    
    if (p2projectiles.size() > 0 && playerOneScore < 3 && playerTwoScore < 3) {
      for(Projectile curProj : p2projectiles) {
        curProj.display();
        if (curProj.dead) {
          screenShake = true;
          explosions.add(new Explosion(curProj.finalangle, ellipseSz/2.0f, curProj.col, proj));
        }
      }
    }
    
    if (p2projectiles.size() > 0) {
      playerOne.checkCollisions(p2projectiles);
    }
    if (p1projectiles.size() > 0) {
      playerTwo.checkCollisions(p1projectiles);
    }
    
    for (Explosion explode : explosions) {
      explode.display();
    }
    
    for(int i = explosions.size()-1; i >= 0; i--) {
      Explosion curExp = explosions.get(i);
      if (curExp.expired) {
        explosions.remove(i);
      }
    }
    
    for(int i = p2projectiles.size()-1; i >= 0; i--) {
      Projectile curProj = p2projectiles.get(i);
      if (curProj.dead) {
        p2projectiles.remove(i);
      }
    }
    for(int i = p1projectiles.size()-1; i >= 0; i--) {
      Projectile curProj = p1projectiles.get(i);
      if (curProj.dead) {
        p1projectiles.remove(i);
      }
    }
    
    checkPlayerCollision();
    
    if(playerOneScore<3&&playerTwoScore<3){
      if (!p1charge) {
        playerOne.updateCols();
      }
      if (!p2charge) {
        playerTwo.updateCols();
      }
      playerOne.display();
      playerTwo.display();
    }
    
    pickup.drawPickup(); 

    popMatrix();
    if(playerOneScore>=3||playerTwoScore>=3){
      drawAvatars();
    }    
     //need to do this after the matrix has been popped to properly overlay
    drawScores();
    drawWinScreen();
    
  }
  
  public void checkPickupSpawn(){    
    if(pickup.activateMe){
      pickup.activate(playerOne.angle, playerTwo.angle);
    }   
  }
  
  public void checkPlayerCollision() {
    float targAngle = playerOne.angle;
    float curAngle = playerTwo.angle;
    if (abs(targAngle/(2*PI)) > 1) {
      targAngle -= (PApplet.parseInt(targAngle/(2*PI))*2*PI);
    }
    if (abs(curAngle/(2*PI)) > 1) {
      curAngle -= (PApplet.parseInt(curAngle/(2*PI))*2*PI);
    }
    if (curAngle < 0) {
      curAngle += 2*PI;
    }
    if (targAngle < 0) {
      targAngle += 2*PI;
    }
    if (curAngle >= targAngle - PI/20.0f && curAngle <= targAngle + PI/20.0f) {
      if (playerOne.dangerous && playerTwo.dist > playerOne.dist - playerOne.ht) {
        playerTwo.jump(20);
      } else if (playerTwo.dangerous && playerOne.dist > playerTwo.dist - playerTwo.ht) {
        playerOne.jump(20);
      }
    }
  }
  
  public void checkPickupCollision(Player player){
    float targAngle = pickup.getAngle();
    float curAngle = player.getAngle();
    if (abs(targAngle/(2*PI)) > 1) {
      targAngle -= (PApplet.parseInt(targAngle/(2*PI))*2*PI);
    }
    if (abs(curAngle/(2*PI)) > 1) {
      curAngle -= (PApplet.parseInt(curAngle/(2*PI))*2*PI);
    }
    if (curAngle < 0) {
      curAngle += 2*PI;
    }
    if (targAngle < 0) {
      targAngle += 2*PI;
    }
    if (pickup.active && curAngle >= targAngle - PI/20.0f && curAngle <= targAngle + PI/20.0f && player.dist > player.baseDist-player.ht) {
      pickup.deActivate();
      player.poweredUp=true;
      player.powerStart = millis();
      if (pickup.type == 2) {
        player.chargeAvailable = true;
      }
      player.powerType = pickup.type;
    }  
  }  
  
  public void drawBounds(){
    pushStyle();
    imageMode(CENTER);
    noStroke();
    fill(22);
    ellipse(0,0,ellipseSz,ellipseSz);
    image(bg,0,0,ellipseSz,ellipseSz);
    popStyle();
   
  }
  
  public void drawAvatars(){
    
    
    pushStyle();
    
    if (playerOneScore < 3) {
      tint(220, 100, 255);
      image(l_ava_b, 0, 0,width,height);
      tint(255, count);
      image(l_ava_g, 0, 0,width,height);
      tint(255,100);
      image(l_ava_h, 0, 0,width,height);
    }
    
    if (playerTwoScore < 3) {
      tint(220, 255, 100);
      image(r_ava_b, 0, 0,width,height);
      tint(255, count);
      image(r_ava_g, 0, 0,width,height);
      tint(255,100);
      image(r_ava_h, 0, 0,width,height);
    }
    popStyle();
    if(count >= 180){
      fade = true;
    }else if(count <= 100){
      fade = false;
    }
    
    if (fade){
      count -= 1;
    }else{
      count += 1;
    }
  }
  
  public void keyPressedRound() {
    if (key == 'a') {
      p2left = true;
    } else if (key == 'd') {
      p2right = true;
    } else if (key == 'w') {
      p2jump = true;
    } else if (key == ' ') {
      p2charge = true;
    } else if (key == '.') {
      p1charge = true;
    }
    if (key == CODED) {
      if (keyCode == LEFT) {
        p1left = true;
      } else if (keyCode == RIGHT) {
        p1right = true;
      } else if (keyCode == UP) {
        p1jump = true;
      }
   
   }
  }
  
  
  public void keyReleasedRound() {
    if (key == 'a') {
      p2left = false;
    } else if (key == 'd') {
      p2right = false;
    } else if (key == 'w') {
      p2jump = false;
    } else if (key == ' ') {
      p2fire = true;
      p2charge = false;
    } else if (key == '.') {
      p1fire = true;
      p1charge = false;
    }
    if (key == CODED) {
      if (keyCode == LEFT) {
        p1left = false;
      } else if (keyCode == RIGHT) {
        p1right = false;
      } else if (keyCode == UP) {
        p1jump = false;
      }
    }
  }
  
  public void drawScores(){
    
    if(playerOneScore>2||playerTwoScore>2){
     return; 
    }
    
    fill(255);
    pushMatrix();
    translate(width/2.0f, height/2.0f+10);
    textFont(pointed, height/5);
    text(playerTwoScore, -width/2.14f, -height/3.1f);
    text(playerOneScore, width/2.4f, height/2.2f);
    popMatrix();
    
  }
  
  public void checkChargeSounds(){
    if (p1charge && p1projvelocity == 0) {
      chargeUp1.play();
    } else if (!p1charge) {
      chargeUp1.pause();
      chargeUp1.rewind();
    }   
    if (p2charge && p2projvelocity == 0) {
      chargeUp2.play();
    } else if (!p2charge) {
      chargeUp2.pause();
      chargeUp2.rewind();
    }   
  }
  
  
  public void drawWinScreen(){
    
    
    if(playerOneScore>2){
    fill(255);
    textFont(pointed, height/10);
    text("VICTOR", width/16, (height/2));
    textFont(pointed, height/20);
    text("PLAYER2", width/12, (height-(height/2.3f)));
    textFont(pointed, height/25);
    text("'ENTER'", width/10, (height-(height/4)));
    text("TO RETURN", width/12, (height-(height/4.6f)));
    }
    
    if(playerTwoScore>2){
      fill(255);
    textFont(pointed, height/10);
    text("VICTOR", width-(width/5), (height/2));
    textFont(pointed, height/20);
    text("PLAYER1", width-(width/5.6f), (height-(height/2.3f)));
    textFont(pointed, height/25);
    text("'ENTER'", width-(width/6.4f), (height-(height/4)));
    text("TO RETURN", width-(width/5.8f), (height-(height/4.6f)));
    
    }
    
    
    
  }

  
}
  public void settings() {  fullScreen(P2D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--hide-stop", "Ilium" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
