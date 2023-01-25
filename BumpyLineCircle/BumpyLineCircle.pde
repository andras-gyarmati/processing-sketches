ArrayList<PVector> ps;
float b;

void setup() {
  size(1000, 1000, P3D);
  ps = new ArrayList<PVector>();
  smooth(8);
  init();
  b = 0;
  stroke(0);
  noFill();
}

void draw() {
  background(200);
  pushMatrix();
  translate(width / 2, height / 2);
  beginShape();
  for (int i = 0; i < ps.size() - 1; i++) {
    PVector p = ps.get(i);
    strokeWeight(sin(i/19.0795+b)*72f);
    vertex(p.x, p.y, 0);
  }
  endShape(CLOSE);
  popMatrix();
  b += 0.03;
}

void init() {
  PVector base = new PVector(0, 400);
  for (int i = 0; i < 360; i++) {
    ps.add(base.copy());
    base.rotate(radians(1));
  }
}
