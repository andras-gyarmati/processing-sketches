import queasycam.*;

QueasyCam cam;
PImage pic;

void setup() {
  size(1000, 1000, P3D);
  cam = new QueasyCam(this);
  cam.speed = 0.5;
  cam.sensitivity = 0.5;
  init();
}

void draw() {
  background(0);
  calc();
}

void init() {
  pic = loadImage("img2.png");
  image(pic, 0, 0);
}

void calc() {
  pic.loadPixels();
  for (int i = 0; i < pic.pixels.length; i++) {
    pushMatrix();
    translate(i % pic.width, i / pic.width, 0);
    noStroke();
    fill(pic.pixels[i]);
    box(1, 1, hue(pic.pixels[i]) / 20);
    popMatrix();
  }
}


void keyPressed() {
  if (key == CODED) {
    if (keyCode == SHIFT) {
      cam.speed = 2;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == SHIFT) {
      cam.speed = 0.5;
    }
  }
}
