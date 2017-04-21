float ellipseSz = 550;

Player playerOne = new Player(0.0, ellipseSz/2.0, 22.0, 22.0, color(20,255,220));
Player playerTwo = new Player(PI, ellipseSz/2.0, 22.0, 22.0, color(255,210,20));

Projectile p1projectile;
float p1projvelocity = 3;
float p1aim = 0;

Projectile p2projectile;
float p2projvelocity = 3;
float p2aim = 0;

boolean p1right, p1left, p1jump, p1fire, p1charge, p2right, p2left, p2jump, p2fire, p2charge;

void setup() {
  size(600,600);
  rectMode(CENTER);
}

void draw() {
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
    }
  }
  if (p1fire) {
    if(p1left) {
      p1aim = -1;
    } else if (p1right) {
      p1aim = 1;
    } else {
      p1aim = 0;
    }
    p1projectile = new Projectile(playerOne.dist, ellipseSz/2.0, 3*p1aim, playerOne.angle, p1projvelocity);
    p1fire = false;
    p1projvelocity = 3;
  }
  if (p2charge) {
    if (p2projvelocity < 15) {
      p2projvelocity += 0.3;
    }
  }
  if (p2fire) {
    if(p2left) {
      p2aim = -1;
    } else if (p2right) {
      p2aim = 1;
    } else {
      p2aim = 0;
    }
    p2projectile = new Projectile(playerTwo.dist, ellipseSz/2.0, 3*p2aim, playerTwo.angle, p2projvelocity);
    p2fire = false;
    p2projvelocity = 3;
  }
  if (p2projectile != null) {
    p2projectile.display();
  }
  if (p1projectile != null) {
    p1projectile.display();
  }
  playerOne.display();
  playerTwo.display();
  
  drawCore();
  drawBounds();
 
  popMatrix();
}

void drawCore(){
}

void drawBounds(){
  noFill();
  strokeWeight(2);
  stroke(240);
  ellipse(0,0,ellipseSz,ellipseSz);
}

void keyPressed() {
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
void keyReleased() {
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