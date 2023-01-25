ArrayList<PVector> points = new ArrayList<PVector>();
float x, y, z, a, b, c, dt, hw, hh, sp, rx, ry, brx, bry, cx, cy, snp;
boolean cmx, cmy;

void setup() {
  size(1000, 1000, P3D);
  //fullScreen(P3D);
  surface.setLocation(10, 10);
  x = 0.01;
  y = 0;
  z = 0;
  a = 10;
  b = 28;
  c = 8.0/3.0;
  dt = 0.05; //speed, def: 0.2 or 0.1
  hw = width / 2;
  hh = height / 2;
  sp = 0.001;
  cmx = true;
  cmy = true;
  colorMode(HSB);
  strokeWeight(0.7); // def: 0.3
  smooth(8);
  noFill();
  // ortho();
}

void draw() {
  background(0);
  translate(hw, hh, 0);
  rotateX(ry);
  rotateY(rx);
  float dx = (a * (y - x))*dt;
  float dy = (x * (b - z) - y)*dt;
  float dz = (x * y - c * z)*dt;
  x = x + dx;
  y = y + dy;
  z = z + dz;
  points.add(new PVector(x, y, z));
  scale(13);
  float hue = 0;
  beginShape();
  for (PVector v : points) {
    stroke(hue, 255, 255);
    curveVertex(v.x, v.y, v.z - 40);
    hue += 0.5;
    if (hue > 255) {
      hue = 0;
    }
  }
  endShape();
  if (points.size() > 255) points.remove(0); //def: 1000
}

float dx() {
  return (mouseX - cx) * sp;
}

float dy() {
  return (mouseY - cy) * sp;
}

void touchStarted() {
  cx = mouseX;
  cy = mouseY;
}

void touchMoved() {
  if (cmx) rx = brx + dx();
  if (cmy) ry = bry - dy();
}

void touchEnded() {
  brx = rx;
  bry = ry;
}
