import queasycam.*;

QueasyCam cam; 

int hMax, sMax, bMax, opacity;
float size, a, pad;

void setup() {
  size(1000, 1000, P3D);
  hMax = 255;
  sMax = 255;
  bMax = 255;
  size = 10;
  pad = size / 1.1;
  opacity = 255;
  a = 0;
  colorMode(HSB);
  noStroke();
  smooth(8);

  cam = new QueasyCam(this);
  cam.speed = 1;              // default is 3
  cam.sensitivity = 0.5;      // default is 2
  cam.position.x = 100;
  cam.position.y = 500;
  cam.position.z = 150;
}

void draw() {
  background(0);
  cam.position.add(new PVector(1, 0));

  for (int h = 0; h < hMax; h+=size) {
    for (int s = 0; s < sMax; s+=size) {
      for (int b = 0; b < bMax; b+=size) {
        fill(h, s, 255, opacity);
        pushMatrix();
        translate(width / 2, height / 2, 0);
        translate(h, s, b);
        box(size - pad);
        popMatrix();
      }
    }
  }
}
