float x, y, z;
float angle;
int scale;

void setup() {
  size(600, 600, P3D);
  scale = 5;
  x = min(width/scale, height/scale);
  y = min(width/scale, height/scale);
  z = min(width/scale, height/scale);
  angle = 0;
}

void draw() {
  pushMatrix();
  background(100);
  rectMode(CENTER);
  fill(50, 34, 222);
  stroke(255);
  strokeWeight(3);

  translate(height / 2, width / 2, -100);
  rotateX(radians(angle));
  rotateY(radians(angle));
  rotateZ(radians(angle));
  box(x, y, z);
  angle += 0.5;
  if (angle > 360) {
    angle = 0;
  }
  popMatrix();
  rect(mouseX, mouseY, 30, 30);
}