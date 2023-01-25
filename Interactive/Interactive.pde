float hw, hh, sp, rx, ry, brx, bry, cx, cy, snap;
int xa, ya, phase;

/*
phases:
0: box, sw: if angles align
1: hexagon: spins increasingly faster on down scroll, sw when spins fast enough
2: black circle, from the spinning hexagon, has a dot in the center, sw: reach the other point
*/ 

void setup() {
  size(1000, 1000, P3D);
  surface.setLocation(10, 10);
  noFill();
  strokeWeight(5);
  hw = width / 2;
  hh = height / 2;
  sp = 0.002;
  xa = 45;
  ya = 35;
  snap = 10;
  phase = 0;
  ortho();
  smooth(8);
  strokeCap(SQUARE);
  strokeJoin(SQUARE);
}

float dx() {
  return (mouseX - cx) * sp;
}

float dy() {
  return (mouseY - cy) * sp;
}

void mousePressed() { 
  cx = mouseX;
  cy = mouseY;
}

void mouseDragged() { 
  rx = brx + dx();
  ry = bry - dy();
}

void mouseReleased() { 
  brx = rx;
  bry = ry;
}

void draw() {
  background(255);
  translate(hw, hh, 0);
  rotateX(ry);
  rotateY(rx);
  box(300, 300, 300);
  if (abs(degrees(rx) % xa) < snap &&
      abs(degrees(ry) % ya) < snap &&
      abs(degrees(ry)) >= snap &&
      abs(degrees(ry)) >= snap) {
    rx = radians(xa);
    ry = radians(ya);
  }
  println("rx: " + degrees(rx) + ", ry: " + degrees(ry));
}
