
class Round{
  
  BlueHole blueHole;
  Pickup pickup;
  
  //Arena scale
  float ellipseSz = 550;

  //Instantiate players
  Player playerOne = new Player(0.0, ellipseSz/2.0, 22.0, 22.0, color(20,255,220));
  Player playerTwo = new Player(PI, ellipseSz/2.0, 22.0, 22.0, color(255,210,20));
  
  //Player one projectile variables
  ArrayList<Projectile> p1projectiles = new ArrayList<Projectile>();
  float p1projvelocity = 0;
  float p1aim = 0;
  
  //Player two projectile variables
  ArrayList<Projectile> p2projectiles = new ArrayList<Projectile>();
  float p2projvelocity = 0;
  float p2aim = 0;
  
  //Max and min projectile y velocity
  float maxVel = 15;
  float minVel = 3;
  //Player move speed
  float movespeed = PI/180.0;
  //Player jump height
  float jumpHght = 8;
  //Charge speed of attack (increments once per frame until it reaches max velocity)
  float chargeInc = 0.3;
  //Projectile x velocity
  float projxVel = 3;
  
  //BOOL CHECKS FOR MOVEMENT
  boolean p1right, p1left, p1jump, p1fire, p1charge, p2right, p2left, p2jump, p2fire, p2charge;
  
  float currentMilli, startMilli;
  
  Round(){
    
    blueHole= new BlueHole(ellipseSz/3.0);
    pickup = new Pickup(ellipseSz/2.0, 22.0, 22.0);
    
  }
  
void drawRound() {
  
    checkProjectileSpawn();
    
    background(57);
    pushMatrix();
    translate(width/2.0, height/2.0); //Position center axis
    
    blueHole.drawHole();
    
    //Movement checks
    if (p1left) {
      playerOne.update(PI/180.0);
    }
    if (p1right) {
      playerOne.update(-movespeed);
    }
    if (p2left) {
      playerTwo.update(movespeed);
    }
    if (p2right) {
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
    
    
    //PLAYER ONE ATTACK CODE
    //Charge your attack code
    if (p1charge) {
      if (p1projvelocity < maxVel) {
        p1projvelocity += chargeInc; //increment projectile velocity
      } else {
        playerOne.col = color(255,0,0); //Change player one appearance at max charge here
      }
    }
    
    //Fire code
    if (p1fire) {
      if(p1projvelocity > minVel) { //Only fire if projectile velocity exceeds minimum velocity
        if(p1left) { //code to determine firing direction based on movement
          p1aim = -1;
        } else if (p1right) {
          p1aim = 1;
        } else {
          p1aim = 0;
        }
        p1projectiles.add(new Projectile(playerOne.dist, ellipseSz/2.0, projxVel*p1aim, playerOne.angle, p1projvelocity)); //instantiate projectile
      }
      p1fire = false; //reset conditions
      p1projvelocity = 0;
      playerOne.col = color(20,255,220); //Change player one appearance back to current non-charged default
    }
    
    //PLAYER TWO ATTACK CODE
    //Charge your attack code
    if (p2charge) {
      if (p2projvelocity < maxVel) {
        p2projvelocity += chargeInc; //increment projectile velocity
      } else {
        playerTwo.col = color(255,0,0); //Change player two appearance at max charge here
      }
    }
    
    //Fire code
    if (p2fire) {
      if(p2projvelocity > minVel) {
        if(p2left) {
          p2aim = -1;
        } else if (p2right) {
          p2aim = 1;
        } else {
          p2aim = 0;
        }
        p2projectiles.add(new Projectile(playerTwo.dist, ellipseSz/2.0, projxVel*p2aim, playerTwo.angle, p2projvelocity)); //instantiate projectile
      }
      p2fire = false; //reset conditions
      p2projvelocity = 0;
      playerTwo.col = color(255,210,20); //Change player one appearance back to current non-charged default
    }
    
    //Check player one projectiles for explosions and draw projectiles
    if (p1projectiles.size() > 0) {
      for(Projectile curProj : p1projectiles) {
        curProj.display(); //draw projectile
        if (curProj.dead) {
          pushMatrix(); 
          rotate(curProj.finalangle); //position of projectile endpoint
          noStroke(); //put instatiation of proj explosion animation code in here
          fill(255,255,255);
          ellipse(0,ellipseSz/2.0,50,50);
          popMatrix();
        }
      }
    }
    
    //As above but for player two
    if (p2projectiles.size() > 0) {
      for(Projectile curProj : p2projectiles) {
        curProj.display();
        if (curProj.dead) {
          pushMatrix();
          rotate(curProj.finalangle);
          noStroke();
          fill(255,255,255);
          ellipse(0,ellipseSz/2.0,50,50);
          popMatrix();
        }
      }
    }
    
    //Check player two projectiles against player one for collisions
    if (p2projectiles.size() > 0) {
      playerOne.checkCollisions(p2projectiles);
    }
    //Check player one projectiles against player two for collisions
    if (p1projectiles.size() > 0) {
      playerTwo.checkCollisions(p1projectiles);
    }
    
    //REMOVE DEAD PROJECTILES
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
    
    //DISPLAY PLAYERS
    playerOne.display();
    playerTwo.display();
    
    //DRAW PICKUP
    pickup.drawPickup();
    
    //DISPLAY ARENA
    drawBounds();
   
    popMatrix();
  }
  
  void checkProjectileSpawn(){
    currentMilli = millis();
    if(currentMilli-startMilli > 10000){
      pickup = new Pickup(ellipseSz/2.0, 22.0, 22.0);
      startMilli = currentMilli;
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
    