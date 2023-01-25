import queasycam.*;

QueasyCam cam;

void setup() {
  size(640, 480, P3D);
  noFill();
  stroke(255);
  strokeWeight(2);
  //cam = new QueasyCam(this);
  //cam.sensitivity = 0.5;
  //cam.speed = 0.5;
}

void draw() {
  background(0);
  translate(width/3, height/2, 100);

  //box(10);

  PVector v = new PVector(0, 0, 0);
  beginShape();
  for (int i = 0; i < 20; i++) {
    rotateX(PI / 8 * i);
    pushMatrix();
    translate(v.x + i * 10, v.y, v.z);
    vertex(v.x + i * 10, v.y + 20, v.z);
    popMatrix();
  }
  endShape();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    cam = new QueasyCam(this);
    cam.sensitivity = 0.5;
    cam.speed = 0.5;
  } else if (mouseButton == RIGHT) {
    cam = null;
  }
}