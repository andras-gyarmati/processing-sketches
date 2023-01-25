import queasycam.*;

QueasyCam cam;

PVector shaft, dir;
ArrayList<PVector> dots;

void setup() {
  size(640, 640, P3D);
  cam = new QueasyCam(this);
  cam.speed = 0.5;
  cam.sensitivity = 0.5;

  shaft = new PVector(0, 0, 0);
  dir = new PVector(1, 1, 1);
  dots = new ArrayList<PVector>();
}

void draw() {
  strokeWeight(3);
  noFill();
  background(255);

  dir.set(random(0.1), random(0.1), random(0.1));
  shaft.add(dir);
  dots.add(new PVector(shaft.x, shaft.y, shaft.z));

  //beginShape();
  PVector v;
  for (int i = 0; i < dots.size(); i++) {
    v = dots.get(i);
    pushMatrix();
    translate(v.x, v.y, v.z);
    box(0.1, 0.1, 0.1);
    //vertex(0, 0, 0);
    popMatrix();
  }
  //endShape();
  int m = 1000;
  box(m, m, m);
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
