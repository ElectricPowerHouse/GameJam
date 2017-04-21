float ellipseSz = 550;

Player playerOne = new Player(0.0, ellipseSz/2.0, 22.0, 22.0, color(20,255,220));
Player playerTwo = new Player(PI, ellipseSz/2.0, 22.0, 22.0, color(255,210,20));

Projectile p1projectile;

boolean p1right, p1left, p1jump, p1fire, p2right, p2left, p2jump;

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
  if (p1fire) {
    p1projectile = new Projectile(ellipseSz/2.0, PI/100.0, playerOne.angle);
  }
  playerOne.display();
  playerTwo.display();
  if (p1projectile != null) {
    p1projectile.display();
  }
  
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
    p1fire = true;
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
    p1fire = false;
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