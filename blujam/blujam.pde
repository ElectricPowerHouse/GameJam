
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

GameManager gameManager;
Minim minim;

void setup(){
  
  minim = new Minim(this);
  
  fullScreen(P2D);
  //size(600,600);
  rectMode(CENTER);
gameManager = new GameManager(minim);



//SoundManager test = new SoundManager("C:/Illium/GameJam/blujam/sounds/TitleScreen.wav");
//test.play();



}

void draw(){
  
  gameManager.drawManager();
}


void keyPressed(){
  
 
 gameManager.keyPressedManager();
  
}
void keyReleased(){
  
  
gameManager.keyReleasedManager();
  
  
}