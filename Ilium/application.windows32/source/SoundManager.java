import java.io.File;
import java.io.IOException;
import javax.sound.sampled.*;

class SoundManager {

  String song;
  Clip clip;
  boolean clipOpen;

  // Constructs a sound clip object for a file
  public SoundManager(String file) {
    this.song = file;
    clipOpen = false;
    
    // Sanity check that this file exist before going any further
    File f = new File(file);
    if (!f.exists()) {
      throw new RuntimeException("File " + file + " could not be found.");
    }

    // Create an audiostream from the inputstream
    try {
      clip = AudioSystem.getClip();
    } catch (LineUnavailableException e) {
      e.printStackTrace();
    }
  }
  
  public void play() {
    play(false);
  }
  
  public void playLoop() {
    play(true);
  }

  private void play(boolean loop) {
    try {
      if(!clipOpen) {
        clip.open(AudioSystem.getAudioInputStream(new File(this.song)));
        clipOpen = true;
      }
      
      clip.stop();
      clip.setFramePosition(0);
      
      if (loop) {
        clip.loop(Clip.LOOP_CONTINUOUSLY);
      } else {
        clip.start();
      }

    } catch (LineUnavailableException | UnsupportedAudioFileException | IOException e) {
      e.printStackTrace();
    }
  }


  public void stop() {
    clip.stop();
    clip.close();
    clipOpen = false;
  }
}