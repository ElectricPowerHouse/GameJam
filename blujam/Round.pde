
class Round{
  
  BlueHole blueHole;
  Pickup pickup;
  Round(){
    
    blueHole= new BlueHole(ellipseSz/3.0);
    pickup = new Pickup(ellipseSz/2.0, 22.0, 22.0);
    
    
  }

float ellipseSz = 550;


  
PImage image1 = loadImage("test1.png");
PImage image2 = loadImage("test1.png");
  

Player playerOne = new Player(0.0, ellipseSz/2.0, 64.0, 64.0, color(20,255,220), image1);
Player playerTwo = new Player(PI, ellipseSz/2.0, 64.0, 64.0, color(255,210,20), image2);

ArrayList<Projectile> p1projectiles = new ArrayList<Projectile>();
float p1projvelocity = 0;
float p1aim = 0;

Projectile p2projectile;
ArrayList<Projectile> p2projectiles = new ArrayList<Projectile>();
float p2projvelocity = 0;
float p2aim = 0;

boolean p1right, p1left, p1jump, p1fire, p1charge, p2right, p2left, p2jump, p2fire, p2charge;

float startMilli = 0;
float currentMilli = 0;



void drawRound() {
  
  checkPickupSpawn();
  checkPickupCollision();
  
  //print(width,height);
  background(57);
  pushMatrix();
  translate(width/2.0, height/2.0);
  if (p1left) {
    playerOne.update(PI/180.0);
  }
  if (p1right) {
    playerOne.update(-PI/180.0);
  }
  if (p2left) {
    playerTwo.update(PI/180.0);
  }
  if (p2right) {
    playerTwo.update(-PI/180.0);
  }
  if (p1jump) {
    playerOne.jump(8);
    p1jump = false;
  }
  if (p2jump) {
    playerTwo.jump(8);
    p2jump = false;
  }
  if (p1charge) {
    if (p1projvelocity < 15) {
      p1projvelocity += 0.3;
    } else {
      playerOne.col = color(255,0,0);
    }
  }
  if (p1fire) {
    if(p1projvelocity > 3) {
      if(p1left) {
        p1aim = -1;
      } else if (p1right) {
        p1aim = 1;
      } else {
        p1aim = 0;
      }
      p1projectiles.add(new Projectile(playerOne.dist, ellipseSz/2.0, 3*p1aim, playerOne.angle, p1projvelocity));
    }
    p1fire = false;
    p1projvelocity = 0;
    playerOne.col = color(20,255,220);
  }
  if (p2charge) {
    if (p2projvelocity < 15) {
      p2projvelocity += 0.3;
    }
  }
  if (p2fire) {
    if(p2projvelocity > 3) {
      if(p2left) {
        p2aim = -1;
      } else if (p2right) {
        p2aim = 1;
      } else {
        p2aim = 0;
      }
      p2projectiles.add(new Projectile(playerTwo.dist, ellipseSz/2.0, 3*p2aim, playerTwo.angle, p2projvelocity));
    }
    p2fire = false;
    p2projvelocity = 0;
  }
  if (p1projectiles.size() > 0) {
    for(Projectile curProj : p1projectiles) {
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
  
  blueHole.drawHole();
  
  playerOne.display();
  playerTwo.display();
  
  pickup.drawPickup();
  
  drawBounds();
  
 
  popMatrix();
}

void checkPickupSpawn(){
  
  currentMilli = millis();
  if(currentMilli-startMilli > 10000){
    
    pickup = new Pickup(ellipseSz/2.0, 22.0, 22.0);
    
   startMilli = currentMilli;
   
   
  }
  
}

void checkPickupCollision(){
  
  
        float targAngle = pickup.getAngle();
        float curAngle = playerOne.getAngle();
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
        println(targAngle);
        println(curAngle);
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