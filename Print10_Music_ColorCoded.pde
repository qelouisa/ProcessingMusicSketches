import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer track;
BeatDetect beat;
BeatListener bl;

int size;
int x;
int y;
int spacing = 5;
color[] colArray = {
  color(35, 31, 32), //raisin
  color(187, 68, 48), 
  color(126, 189, 194), 
  color(243, 223, 162), 
  color(239, 230, 221)
};

float kickSize, snareSize, hatSize;

class BeatListener implements AudioListener
{
  private BeatDetect beat;
  private AudioPlayer source;

  BeatListener(BeatDetect beat, AudioPlayer source)
  {
    this.source = source;
    this.source.addListener(this);
    this.beat = beat;
  }

  void samples(float[] samps)
  {
    beat.detect(source.mix);
  }

  void samples(float[] sampsL, float[] sampsR)
  {
    beat.detect(source.mix);
  }
}

void setup() {
  //fullScreen();
  size(700, 700);
  background(50);
  //frameRate(15);

  minim = new Minim(this);
  //track = minim.loadFile("constellations.wav");
  //track = minim.loadFile("badgirlsgigamesh.wav");
  track = minim.loadFile("meetmeinthewoods.wav");
  track.play();
  beat = new BeatDetect(track.bufferSize(), track.sampleRate());
  beat.setSensitivity(80);  
  kickSize = snareSize = hatSize = 16;
  // make a new beat listener, so that we won't miss any buffers for the analysis
  bl = new BeatListener(beat, track);  
  textFont(createFont("Helvetica", 16));
  textAlign(CENTER);
}

void draw() {
  //background(0);

  if ( beat.isSnare() ) { 
    strokeWeight(3);
    //stroke(76, 53, 73);
    //stroke(111, 45, 189);
    stroke(81, 13, 10);
  } else if ( beat.isKick() ) {
    strokeWeight(2);
    //stroke(187, 68, 48);
    //stroke(166, 99, 204);
    stroke(162, 159, 21);
  } else if (beat.isHat() ) {
    strokeWeight(1);
    //stroke(126, 189, 194);
    //stroke(185, 250, 248);
    stroke(243, 182, 31);
  } else {
    strokeWeight(0);
    //stroke(243, 223, 162);
    stroke(50);
  }



  //stroke(255);
  //stroke(colArray[int(random(5))]);
  //fill(colArray[int(random(5))]);


  if (random(1) < 0.5) {
    line(x, y, x+spacing, y+spacing);
  } else {
    line(x, y + spacing, x +spacing, y);
  }


  x = x + spacing;
  if (x >= width) {
    x = 0;
    if (y >= height) {
      background(50);
      y = 0;
    } else {
      y += spacing;
    }
  }
}
//y = y + spacing;
