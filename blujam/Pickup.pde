
//random 0-2 pi angle
class Pickup {

  
  PImage[] pickupImage = new PImage[3];
  
  float angle, dist, wd, ht;
  boolean active;
  int type;
  int imageNum = 0;

  color c = color(0, 0, 0);


  Pickup (float distance) {

    getRandomType();

    pickupImage[0] = loadImage("cyangem.png");
    pickupImage[1] = loadImage("redgem.png");
    pickupImage[2] = loadImage("orangegem.png");
    active = true;
    dist = distance;

    angle = random(0, 2)*PI;
  }


  void drawPickup() {

    if (!active) {
      return;
    }

    pushMatrix();

    rotate(angle);
    pushStyle();
    imageMode(CENTER);
    image(pickupImage[imageNum],0, dist-(ht/2.0), wd, ht);
    popStyle();
    popMatrix();
  }


  float getAngle() {

    return angle;
  }

  void deActivate() {

    active = false;
  }

  void activate(float angle1, float angle2) {
    float targAngle = angle1;
    float curAngle = angle2;
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
    float[] angles = new float[2];
    angles[0] = (targAngle + curAngle)/2.0;
    angles[1] = ((targAngle + curAngle)/2.0)-PI;
    angle = angles[int(random(2))];
    getRandomType();
    active = true;
  }

  boolean isActive() {
    return active;
  }


  void getRandomType() {

    type = int(random(1, 4));
    
    if (type==1) {
      imageNum = 0;
      wd = 30;
    } else if (type ==2) {
      imageNum = 1;
      wd = 40;
    } else {
      imageNum = 2;
      wd = 50;
    }
    ht=wd;
  }
  
  
}