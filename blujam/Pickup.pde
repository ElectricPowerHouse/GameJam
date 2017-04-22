
//random 0-2 pi angle
class Pickup {

  float angle, dist, wd, ht;
  boolean active;
  int type;

  color c = color(0, 0, 0);


  Pickup (float distance) {

    getRandomType();


    active = true;
    dist = distance;
    //wd = widt;
    


    angle = random(0, 2)*PI;
  }


  void drawPickup() {

    if (!active) {
      return;
    }

    pushMatrix();

    rotate(angle);
    noStroke();
    fill(c);
    ellipse(0, dist-(ht/2.0), wd, wd);
    popMatrix();
  }


  float getAngle() {

    return angle;
  }

  void deActivate() {

    active = false;
  }

  void activate() {

    angle = random(0, 2)*PI;
    getRandomType();
    active = true;
  }

  boolean isActive() {
    return active;
  }


  void getRandomType() {

    type = int(random(0, 3));
    //type = 2;
    
    if (type==0) {
      c = color(255,0,0);
      wd = 20;
    } else if (type ==1) {
      c = color(0,255,0);
      wd = 30;
    } else {
      c = color(0,0,255);
      wd = 40;
    }
    ht=wd;
  }
  
  
}