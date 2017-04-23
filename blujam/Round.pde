
class Round{
  
  BlueHole blueHole;
  Pickup pickup;
  
  boolean screenShake;
  boolean up = true;
  int screeninc;
  int shakeLength = 3;
  float shakeAngle = PI/150.0;
  
  PFont pointed;
  
  //SoundManager round1 = new SoundManager("C:/Users/Jackson/Desktop/GameJam/blujam/sounds/Level1Music.wav");
  //SoundManager round2 = new SoundManager("C:/Users/Jackson/Desktop/GameJam/blujam/sounds/TitleScreen.wav");
  float ellipseSz = 550;
  //float ellipseSz = 800;
  
  float playerWd = 48.0;
  float playerHt = 48.0;
  PImage image1 = loadImage("test1.png");
  PImage image2 = loadImage("test2.png");
  PImage splash = loadImage("splash.png");
  
  PImage l_ava_h = loadImage("l_head.png");
  PImage l_ava_b = loadImage("l_body.png");
  PImage l_ava_g = loadImage("l_glow.png");
  
  PImage r_ava_h = loadImage("r_head.png");
  PImage r_ava_b = loadImage("r_body.png");
  PImage r_ava_g = loadImage("r_glow.png");
  PShape ring = loadShape("ring.svg");
  PShape ring2 = loadShape("ring.svg");

  Player playerOne = new Player(PI, ellipseSz/2.0, playerWd, playerHt, color(100,255,0), image1);
  Player playerTwo = new Player(0.0, ellipseSz/2.0, playerWd, playerHt, color(220,0,255), image2);
  
  ArrayList<Projectile> p1projectiles = new ArrayList<Projectile>();
  float p1projvelocity = 0;
  float p1aim = -1;
  
  ArrayList<Projectile> p2projectiles = new ArrayList<Projectile>();
  float p2projvelocity = 0;
  float p2aim = -1;
  
  float maxVel = 18;
  float minVel = 3;
  float p1movespeed = PI/180.0;
  float p2movespeed = PI/180.0;
  float chargeInc = 0.35;
  float projxvel = 3;
  float jumpHght = 8;
  
  boolean p1right, p1left, p1jump, p1fire, p1charge, p2right, p2left, p2jump, p2fire, p2charge;
  
  int roundOver = 0;
  int roundNum;
  int playerOneScore;
  int playerTwoScore;
  
  float startMilli = 0;
  float currentMilli = 0;
  int minPickupTime = 5000;
  int maxPickupTime = 30000;
  
  ArrayList<Explosion> explosions = new ArrayList<Explosion>();
  
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
  
  SoundManager[] shortShots;
  SoundManager[] medShots;
  SoundManager[] longShots;
  SoundManager[] jumpSounds;
  
  int shortShotMax = 8;
  int medShotMax = 13;
  int longShotMax = 18;
  

  Round(int roundCount, int playerOneScore, int playerTwoScore, SoundManager[] shortShots, SoundManager[] medShots, SoundManager[] longShots, SoundManager[] jumpSounds){
    
    pointed = createFont("font/Pointed.ttf", height/4);
    roundNum = roundCount;
    this.playerOneScore = playerOneScore;
    this.playerTwoScore = playerTwoScore;
    
    blueHole= new BlueHole(ellipseSz/4.0);
    pickup = new Pickup(ellipseSz/2.0);
    
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
    
  }

  void drawRound() {
    
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
    
    background(37);
    pushMatrix();
    translate(width/2.0, height/2.0);
    
    
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
      shakeAngle *= 0.92;
      if (shakeAngle < PI/800.0) {
        screenShake = false;
        shakeAngle = PI/150.0;
      }
    }
    
    drawBounds();
    blueHole.drawHole();
    
    if (p1left) {
      p1aim = -1;
      playerOne.flipVal = 1;
      if (playerOne.powerType == 3) {
        playerOne.update(p1movespeed*0.7);
      } else {
        playerOne.update(p1movespeed);
      }
    }
    if (p1right) {
      p1aim = 1;
      playerOne.flipVal = -1;
      if (playerOne.powerType == 3) {
        playerOne.update(-p1movespeed*0.7);
      } else {
        playerOne.update(-p1movespeed);
      }
    }
    if (p2left) {
      p2aim = -1;
      playerTwo.flipVal = 1;
      if (playerTwo.powerType == 3) {
        playerTwo.update(p2movespeed*0.7);
      } else {
        playerTwo.update(p2movespeed);
      }
    }
    if (p2right) {
      p2aim = 1;
      playerTwo.flipVal = -1;
      if (playerTwo.powerType == 3) {
        playerTwo.update(-p2movespeed*0.7);
      } else {
        playerTwo.update(-p2movespeed);
      }
    }
    if (p1jump) {
      if(playerOne.touchingGround){
      int randomChoose = int(random(0,7));
      jumpSounds[randomChoose].play();
      }
      
      playerOne.jump(jumpHght);
      p1jump = false;
    }
    if (p2jump) {
      if(playerTwo.touchingGround){
      int randomChoose = int(random(0,7));
      jumpSounds[randomChoose].play();
      }
      
      playerTwo.jump(jumpHght);
      p2jump = false;
    }
    if (p1charge) {
      if (playerOne.powerType == 2) {
        p1movespeed *= 0.98;
      }
      if (p1projvelocity < maxVel) {
        p1projvelocity += chargeInc;
      } else {
        playerOne.col = color(255,0,0); //change max charge appearance here
      }
    }
    if (p1fire) {
      if (playerOne.powerType != 2) {
        if(p1projvelocity > minVel) {
          
          int randomChoose = int(random(0,7));
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
          
         
          p1projectiles.add(new Projectile(playerOne.dist, ellipseSz/2.0, projxvel*p1aim, playerOne.angle, p1projvelocity,playerOne.powerType, playerOne.proj, playerOne.col));
        }
      } else {
        playerOne.dangerous = true;
        p1movespeed = PI/360.0*p1projvelocity;
        if (p1movespeed > PI/30.0) {
          p1movespeed = PI/30.0;
        }
      }
      p1fire = false;
      p1projvelocity = 0;
      playerOne.col = playerOne.defCol; //revert to non charged appearance here
    }
    
    if (p1movespeed > PI/180.0) {
      p1movespeed *= 0.95;
    } else if (!p1charge && playerOne.chargeAvailable && playerOne.dangerous) {
      playerOne.dangerous = false;
      playerOne.chargeAvailable = false;
      p1movespeed = PI/180.0;
    }
    
    if (p2charge) {
      if (playerTwo.powerType == 2) {
        p2movespeed *= 0.98;
      }
      if (p2projvelocity < maxVel) {
        p2projvelocity += chargeInc;
      } else {
        playerTwo.col = color(255,0,0); //change max charge appearance here
      }
    }
    if (p2fire) {
      if (playerTwo.powerType != 2) {
        // if p2 ...
      if(p2projvelocity > minVel) {
        
        
          
          int randomChoose = int(random(0,7));
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
          
        
        p2projectiles.add(new Projectile(playerTwo.dist, ellipseSz/2.0, projxvel*p2aim, playerTwo.angle, p2projvelocity, playerTwo.powerType, playerTwo.proj, playerTwo.col));
      }
      } else {
        playerTwo.dangerous = true;
        p2movespeed = PI/360.0*p2projvelocity;
        if (p2movespeed > PI/30.0) {
          p2movespeed = PI/30.0;
        }
      }
      p2fire = false;
      p2projvelocity = 0;
      playerTwo.col = playerTwo.defCol; //revert to non charged appearance here
    }
    
    if (p2movespeed > PI/180.0) {
      p2movespeed *= 0.95;
    } else if (!p2charge && playerTwo.chargeAvailable && playerTwo.dangerous) {
      playerTwo.dangerous = false;
      playerTwo.chargeAvailable = false;
      p2movespeed = PI/180.0;
    }
    
    
    if (p1projectiles.size() > 0) {
      for(Projectile curProj : p1projectiles) {
        curProj.display();
        if (curProj.dead) {
          screenShake = true;
          explosions.add(new Explosion(curProj.finalangle, ellipseSz/2.0, curProj.col));
        }
      }
    }
    
    
    if (p2projectiles.size() > 0) {
      for(Projectile curProj : p2projectiles) {
        curProj.display();
        if (curProj.dead) {
          screenShake = true;
          explosions.add(new Explosion(curProj.finalangle, ellipseSz/2.0, curProj.col));
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
    drawScores();
    

    popMatrix();
    
     //need to do this after the matrix has been popped to properly overlay
    drawWinScreen();
    drawAvatars();
  }
  
  void checkPickupSpawn(){
    currentMilli = millis();
    
    int randomSpawn = int(random(minPickupTime,maxPickupTime));
    
    if(currentMilli-startMilli > 10000){
      pickup.activate(playerOne.angle, playerTwo.angle);
      startMilli = currentMilli; 
    }   
  }
  
  void checkPlayerCollision() {
    float targAngle = playerOne.angle;
    float curAngle = playerTwo.angle;
    if (abs(targAngle/(2*PI)) > 1) {
      targAngle -= (int(targAngle/(2*PI))*2*PI);
    }
    if (abs(curAngle/(2*PI)) > 1) {
      curAngle -= (int(curAngle/(2*PI))*2*PI);
    }
    if (curAngle < 0) {
      curAngle += 2*PI;
    }
    if (targAngle < 0) {
      targAngle += 2*PI;
    }
    if (curAngle >= targAngle - PI/20.0 && curAngle <= targAngle + PI/20.0) {
      if (playerOne.dangerous && playerTwo.dist > playerOne.dist - playerOne.ht) {
        playerTwo.jump(15);
      } else if (playerTwo.dangerous && playerOne.dist > playerTwo.dist - playerTwo.ht) {
        playerOne.jump(15);
      }
    }
  }
  
  void checkPickupCollision(Player player){
    float targAngle = pickup.getAngle();
    float curAngle = player.getAngle();
    if (abs(targAngle/(2*PI)) > 1) {
      targAngle -= (int(targAngle/(2*PI))*2*PI);
    }
    if (abs(curAngle/(2*PI)) > 1) {
      curAngle -= (int(curAngle/(2*PI))*2*PI);
    }
    if (curAngle < 0) {
      curAngle += 2*PI;
    }
    if (targAngle < 0) {
      targAngle += 2*PI;
    }
    if (curAngle >= targAngle - PI/20.0 && curAngle <= targAngle + PI/20.0 && player.dist > player.baseDist-player.ht) {
      pickup.deActivate();
      player.poweredUp=true;
      player.powerStart = millis();
      if (pickup.type == 2) {
        player.chargeAvailable = true;
      }
      player.powerType = pickup.type;
    }  
  }  
  
  void drawBounds(){
    pushStyle();
    //shapeMode(CENTER);
    //pushMatrix();
    //rotate(PI/4000.0*frameCount);
    //fill(43);
    //noStroke();
    ////strokeWeight(18);
    ////stroke(37);
    //shape(ring, 0,0,ellipseSz*2,ellipseSz*2);
    //popMatrix();
    
    //pushMatrix();
    //rotate(-PI/8000.0*frameCount);
    //fill(50);
    //shape(ring2, 0,0,ellipseSz*2,ellipseSz*2);
    //popMatrix();
    
    fill(23);
    stroke(80);
    strokeWeight(2);
    ellipse(0,0,ellipseSz,ellipseSz);
    popStyle();
   
  }
  
  void drawAvatars(){
    pushStyle();
    
    if (playerOneScore < 3) {
      tint(120, 250, 280);
      image(l_ava_b, 0, 0);
      tint(255, 180);
      image(l_ava_g, 0, 0);
      noTint();
      image(l_ava_h, 0, 0);
    }
    
    if (playerTwoScore < 3) {
      tint(250, 120, 255);
      image(r_ava_b, 0, 0);
      tint(255, 180);
      image(r_ava_g, 0, 0);
      noTint();
      image(r_ava_h, 0, 0);
    }
    popStyle();
  }
  
  void keyPressedRound() {
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
  
  
  void keyReleasedRound() {
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
  
  void drawScores(){
    
    if(playerOneScore>2||playerTwoScore>2){
     return; 
    }
    
    fill(255);
    textFont(pointed, height/5);
    text(playerTwoScore, -width/2.14, -height/3.1);
    text(playerOneScore, width/2.4, height/2.2);
    
    
    
  }
  
  void enterPressed(){
    
    
    
  }
  
  
  void drawWinScreen(){
    
    
    if(playerOneScore>2){
    fill(255);
    textFont(pointed, height/10);
    text("VICTOR", width/16, (height/2));
    textFont(pointed, height/20);
    text("PLAYER2", width/12, (height-(height/2.3)));
    textFont(pointed, height/25);
    text("'ENTER'", width/10, (height-(height/4)));
    text("TO RETURN", width/12, (height-(height/4.6)));
    }
    
    if(playerTwoScore>2){
      fill(255);
    textFont(pointed, height/10);
    text("VICTOR", width-(width/5), (height/2));
    textFont(pointed, height/20);
    text("PLAYER1", width-(width/5.6), (height-(height/2.3)));
    textFont(pointed, height/25);
    text("'ENTER'", width-(width/6.4), (height-(height/4)));
    text("TO RETURN", width-(width/5.8), (height-(height/4.6)));
    
    }
    
    
    
  }

  
}