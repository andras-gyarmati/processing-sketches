PVector start;
ArrayList<PVector> ps;
float a;
boolean adding;

void setup() {
  size(1000, 1000);
  start = new PVector(width / 2, height / 2);
  ps = new ArrayList<PVector>();
  psadd(-3, -2.7);
  psadd(3, -2.7);
  psadd(0, 2.7);
  //frameRate(10);
  adding = true;
  a = 0;
  strokeWeight(2);
  stroke(251);
}

void draw() {
  background(10);
  translate(start.x, start.y);

  if (ps.size() >= 2) {
    for (int i = 0; i < ps.size() - 1; i++) {
      pline(ps.get(i), ps.get(i + 1));
    }
  }
  if (adding) {
    if (ps.size() < 130) ps.add(calcNew());
    else adding = false;
  } else 
  {
    if (ps.size() <= 3) adding = true;
    else ps.remove(ps.get(ps.size() - 1));
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

//each line is a fibo length line
