class Player{
  float angle, dist, wd, ht, jumpDif, baseDist;
  boolean touchingGround, dead, poweredUp, dangerous, chargeAvailable;
  int powerType = 0;
  color col, defCol, curCol;
  int flipVal = 1;
  PImage img, proj;
  LightTrail[] trail = new LightTrail[3];
  float powerStart, powerDuration, powerCount;
  
  SoundManager[] deathSounds;

  
  Player (float a, float distance, float widt, float hght, color baseCol, PImage image, SoundManager[] deathSounds) {
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
        trail[i] = new LightTrail(col, 10, ht/6.5, mult*dist);
      } else {
        trail[i] = new LightTrail(col, 10, ht/12.0, mult*dist);
      }
    }
    poweredUp=false;
    this.deathSounds=deathSounds;
  }
  
  void display() {
    if (!dead) {
      if (poweredUp && powerType != 2) {
        if (powerType == 3) {
          wd = 64;
          ht = 64;
        }
        powerCount = millis();
        if (powerCount - powerStart >= powerDuration) {
          if (powerType == 3) {
            wd = 48;
            ht = 48;
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
        trail[i].updateLight(angle,dist-(ht/2.7)-(i*(ht/10.8)),col);         
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
      ellipse(flipVal*wd/6.0, dist-ht/2.0, wd/4.0, ht/4.0);
      scale(flipVal,1);
      image(img, -wd/2.0, dist-ht, wd, ht);
      popMatrix();
    }
  }
  
  void update(float angleDif) {
    if (!dead) {
      angle += angleDif;
    }
    
  }
  
  void updateCols() {
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
  
  void updateJump() {
    if (!touchingGround) {
      dist -= jumpDif;
      jumpDif -= 0.5;
      if (dist < baseDist/3.0) {
        dead = true;
      }
    }
  }
  
  void jump(float jumpVel) {
    if (touchingGround) {
      touchingGround = false;
      jumpDif = jumpVel;
    }
  }
  
  void checkCollisions(ArrayList<Projectile> enemyProjs) {
    if (!dead && angle != 0) {
      for(Projectile checkProj : enemyProjs) {
        if (checkProj.dead || checkProj.type == 1) {
          float targAngle = checkProj.finalangle;
          float curAngle = angle;
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
          if (checkProj.type == 3) {
            if (curAngle >= targAngle - PI/10.0 && curAngle <= targAngle + PI/10.0 && dist > baseDist-ht) {
              int randomChoose = int(random(0,3));
              deathSounds[randomChoose].play();
           
              this.jump(15);
            }
          } else {
            if (curAngle >= targAngle - PI/20.0 && curAngle <= targAngle + PI/20.0 && dist > baseDist-ht) {
               int randomChoose = int(random(0,3));
              deathSounds[randomChoose].play();
              this.jump(15);
            }
          }
        }
      }
    }
  }
  
  float getAngle(){
   
    return angle;
  }
}