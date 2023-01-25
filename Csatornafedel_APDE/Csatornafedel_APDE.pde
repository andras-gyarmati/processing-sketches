ArrayList<PVector> ps;
float yz = 10;
float dd = 20;
PVector c = new PVector(0,0);
void setup() {
  size(1440, 1440);
  createPoints();
  strokeWeight(5);
}

void draw() {
  background(220);
  fill(0);
  createPoints();
  PVector r = new PVector(0, 10);
  translate(width / 2, height / 2);
  for (int i = 0; i < ps.size(); i++) {
    PVector p = ps.get(i);
    PVector v = r.copy().rotate(p.dist(c));
    PVector p2 = p.copy().add(v);
    p = p.copy().sub(v);
    //ellipse(p.x, p.y, 10, 10);
    line(p.x, p.y, p2.x, p2.y);
  }
  fill(255, 0, 0);
  ellipse(0, 0, 10, 10);
  // yz += 0.01;
  dd += 0.005;
  // meg azt kene hogy ne egy fele nezzen az osszes
  // egy koron belul hanem mind a kor kozepehez kepest
  // legyen ugyanolyan szogben
}

void createPoints() {
  ps = new ArrayList<PVector>();
  PVector pos = new PVector(0, dd);
  for (int i = 0; i < 30; i++) {
    int xx = floor((i + 1) * yz);
    for (int j = 0; j < xx; j++) {
      ps.add(pos.copy());
      pos.rotate(TWO_PI / xx);
    }
    pos.setMag(pos.mag() + dd);
  }
}
