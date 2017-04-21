float ellipseSz = 600;

Player playerOne = new Player(0.0, ellipseSz/2.0, 30.0, 30.0, color(20,255,220));
Player playerTwo = new Player(PI, ellipseSz/2.0, 30.0, 30.0, color(255,210,20));

boolean p1right, p1left, p2right, p2left;

void setup() {
  size(600,600);
  rectMode(CENTER);
}

void draw() {
  background(237);
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
  playerOne.display();
  playerTwo.display();
  noFill();
  strokeWeight(2);
  stroke(40);
  ellipse(0,0,ellipseSz,ellipseSz);
  popMatrix();
}
void keyPressed() {
  if (key == 'a') {
    p1left = true;
  } else if (key == 'd') {
    p1right = true;
  }
  if (key == CODED) {
    if (keyCode == LEFT) {
      p2left = true;
    } else if (keyCode == RIGHT) {
      p2right = true;
    }
  }
}
void keyReleased() {
  if (key == 'a') {
    p1left = false;
  } else if (key == 'd') {
    p1right = false;
  }
  if (key == CODED) {
    if (keyCode == LEFT) {
      p2left = false;
    } else if (keyCode == RIGHT) {
      p2right = false;
    }
  }
}