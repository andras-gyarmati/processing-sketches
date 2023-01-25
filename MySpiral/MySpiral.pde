import queasycam.*;
QueasyCam cam;
void setup() {
  size(800, 600, P3D);
  cam = new QueasyCam(this);
  cam.speed = 2;
  cam.sensitivity = 0.5;
}

void draw() {
  background(0);
  PVector v = new PVector(50, 0, 0);
  translate(width/2, height/2);
  scale(10);
  stroke(255, 0, 255);
  noFill();
  
  strokeWeight(2);
  beginShape();
  vertex(0, 0, 0);
  vertex(v.x, v.y, v.z);
  PVector vcopy = v.copy();
  vcopy.rotate(PI/2);
  vcopy = vcopy.normalize();
  v.add(vcopy);
  vertex(v.x, v.y, v.z);
  //vertex(0, 0, 0);
  endShape();
}