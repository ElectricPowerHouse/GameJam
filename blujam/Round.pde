
class Round{
  
  BlueHole blueHole;
  Pickup pickup;
  
  //SoundManager round1 = new SoundManager("C:/Users/Jackson/Desktop/GameJam/blujam/sounds/Level1Music.wav");
  //SoundManager round2 = new SoundManager("C:/Users/Jackson/Desktop/GameJam/blujam/sounds/TitleScreen.wav");
  
  float ellipseSz = 550;
  float playerWd = 48.0;
  float playerHt = 48.0;
  PImage image1 = loadImage("test1.png");
  PImage image2 = loadImage("test1.png");

  Player playerOne = new Player(0.0, ellipseSz/2.0, playerWd, playerHt, color(20,255,220), image1);
  Player playerTwo = new Player(PI, ellipseSz/2.0, playerWd, playerHt, color(255,210,20), image2);
  
  ArrayList<Projectile> p1projectiles = new ArrayList<Projectile>();
  float p1projvelocity = 0;
  float p1aim = -1;
  
  ArrayList<Projectile> p2projectiles = new ArrayList<Projectile>();
  float p2projvelocity = 0;
  float p2aim = -1;
  
  float maxVel = 18;
  float minVel = 3;
  float movespeed = PI/180.0;
  float chargeInc = 0.35;
  float projxvel = 3;
  float jumpHght = 8;
  
  boolean p1right, p1left, p1jump, p1fire, p1charge, p2right, p2left, p2jump, p2fire, p2charge;
  
  int roundOver = 0;
  int roundNum;
  
  float startMilli = 0;
  float currentMilli = 0;
  int minPickupTime = 5000;
  int maxPickupTime = 30000;

  Round(int roundCount){
    roundNum = roundCount;
    
    blueHole= new BlueHole(ellipseSz/3.0);
    pickup = new Pickup(ellipseSz/2.0);
    
    if (roundNum == 1) {
      //round1.playLoop();
    } else if (roundNum == 2) {
      //round2.playLoop();
    }
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
    
    blueHole.drawHole();
    
    if (p1left) {
      p1aim = -1;
      playerOne.update(movespeed);
    }
    if (p1right) {
      p1aim = 1;
      playerOne.update(-movespeed);
    }
    if (p2left) {
      p2aim = -1;
      playerTwo.update(movespeed);
    }
    if (p2right) {
      p2aim = 1;
      playerTwo.update(-movespeed);
    }
    if (p1jump) {
      playerOne.jump(jumpHght);
      p1jump = false;
    }
    if (p2jump) {
      playerTwo.jump(jumpHght);
      p2jump = false;
    }
    if (p1charge) {
      if (p1projvelocity < maxVel) {
        p1projvelocity += chargeInc;
      } else {
        playerOne.col = color(255,0,0); //change max charge appearance here
      }
    }
    if (p1fire) {
      if(p1projvelocity > minVel) {
        p1projectiles.add(new Projectile(playerOne.dist, ellipseSz/2.0, projxvel*p1aim, playerOne.angle, p1projvelocity));
      }
      p1fire = false;
      p1projvelocity = 0;
      playerOne.col = color(20,255,220); //revert to non charged appearance here
    }
    
    
    if (p2charge) {
      if (p2projvelocity < maxVel) {
        p2projvelocity += chargeInc;
      } else {
        playerTwo.col = color(255,0,0); //change max charge appearance here
      }
    }
    if (p2fire) {
      if(p2projvelocity > minVel) {
        p2projectiles.add(new Projectile(playerTwo.dist, ellipseSz/2.0, projxvel*p2aim, playerTwo.angle, p2projvelocity));
      }
      p2fire = false;
      p2projvelocity = 0;
      playerTwo.col = color(255,210,20); //revert to non charged appearance here
    }
    
    
    if (p1projectiles.size() > 0) {
      for(Projectile curProj : p1projectiles) {
        curProj.display();
        if (curProj.dead) {
          pushMatrix();
          rotate(curProj.finalangle); //final rotation
          noStroke(); //explosion code here
          fill(255,255,255);
          ellipse(0,ellipseSz/2.0,50,50); //make sure to position it at (0, ellipseSz/2.0)
          popMatrix();
        }
      }
    }
    
    
    if (p2projectiles.size() > 0) {
      for(Projectile curProj : p2projectiles) {
        curProj.display();
        if (curProj.dead) {
          pushMatrix();
          rotate(curProj.finalangle); //final rotation
          noStroke(); //explosion code here
          fill(255,255,255);
          ellipse(0,ellipseSz/2.0,50,50); //make sure to position it at (0, ellipseSz/2.0)
          popMatrix();
        }
      }
    }
    
    if (p2projectiles.size() > 0) {
      playerOne.checkCollisions(p2projectiles);
    }
    if (p1projectiles.size() > 0) {
      playerTwo.checkCollisions(p1projectiles);
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
    
    playerOne.display();
    playerTwo.display();
    
    pickup.drawPickup();
    
    drawBounds();
    
    popMatrix();
  }
  
  void checkPickupSpawn(){
    currentMilli = millis();
    
    int randomSpawn = int(random(minPickupTime,maxPickupTime));
    
    if(currentMilli-startMilli > 10000){
      pickup.activate();
      startMilli = currentMilli; 
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
    if (curAngle >= targAngle - PI/20.0 && curAngle <= targAngle + PI/20.0) {
      pickup.deActivate();
    }  
  }  
  
  void drawBounds(){
    noFill();
    strokeWeight(2);
    stroke(240);
    ellipse(0,0,ellipseSz,ellipseSz);
  }
  
  void keyPressedRound() {
    if (key == 'a') {
      p1left = true;
    } else if (key == 'd') {
      p1right = true;
    } else if (key == 'w') {
      p1jump = true;
    } else if (key == ' ') {
      p1charge = true;
    } else if (key == '.') {
      p2charge = true;
    }
    if (key == CODED) {
      if (keyCode == LEFT) {
        p2left = true;
      } else if (keyCode == RIGHT) {
        p2right = true;
      } else if (keyCode == UP) {
        p2jump = true;
      }
   }
  }
  
  
  void keyReleasedRound() {
    if (key == 'a') {
      p1left = false;
    } else if (key == 'd') {
      p1right = false;
    } else if (key == 'w') {
      p1jump = false;
    } else if (key == ' ') {
      p1fire = true;
      p1charge = false;
    } else if (key == '.') {
      p2fire = true;
      p2charge = false;
    }
    if (key == CODED) {
      if (keyCode == LEFT) {
        p2left = false;
      } else if (keyCode == RIGHT) {
        p2right = false;
      } else if (keyCode == UP) {
        p2jump = false;
      }
    }
  }
  
}