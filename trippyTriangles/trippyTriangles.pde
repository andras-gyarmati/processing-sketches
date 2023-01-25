PVector start;
ArrayList<PVector> ps;
float a;

void setup() {
  size(600, 600);
  start = new PVector(width / 2, height / 2);
  ps = new ArrayList<PVector>();
  psadd(-300, -270);
  psadd(300, -270);
  psadd(0, 270);
  frameRate(1);
  a = 0;
  strokeWeight(3);
  stroke(251);
  
}

void draw() {
  background(10);
  translate(start.x, start.y);

  float limit = -TWO_PI;
  rotate(a);
  a = max(a - PI/6, limit);
  if (a <= limit) {
    a = 0;
  }

  if (ps.size() >= 2) {
    for (int i = 0; i < ps.size() - 1; i++) {
      pline(ps.get(i), ps.get(i + 1));
    }
  }
  ps.add(calcNew());

  for (PVector p : ps) {
    p.mult(1/1.1);
  }

  if (ps.size() >= 60) {
    ps.remove(0);
  }
}

PVector calcNew() {
  PVector x = ps.get(ps.size() - 3).copy();
  PVector diff = ps.get(ps.size() - 1).copy();
  PVector newTip = x.sub(diff.sub(x).mult(0.1));
  return newTip;
}

void pline(PVector p1, PVector p2) {
  line(p1.x, p1.y, p2.x, p2.y);
}

void psadd(float x, float y) {
  ps.add(new PVector(x, y));
}
