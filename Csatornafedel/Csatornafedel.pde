ArrayList<PVector> particles;
float pointsPerCircleMultiplier = 1;
float circleDistance = 5;
PVector center = new PVector(0, 0);
int circleCount = 30;
float lineLength = circleDistance;

void setup() {
  size(1000, 1000);
  surface.setLocation(10, 10);
  createPoints();
  strokeWeight(3);
}

void draw() {
  background(255);
  fill(0);
  createPoints();
  PVector r = new PVector(0, circleDistance / 2);
  translate(width / 2, height / 2);
  for (int i = 0; i < particles.size(); i++) {
    PVector p = particles.get(i);
    PVector v = r.copy().rotate(p.dist(center));
    PVector p2 = p.copy().add(v);
    p = p.copy().sub(v);
    line(p.x, p.y, p2.x, p2.y);
  }
  fill(255, 0, 0);
  ellipse(0, 0, 10, 10);
  // pointsPerCircleMultiplier += 0.001;
  circleDistance += 0.008;
  // meg azt kene hogy ne egy fele nezzen az osszes
  // egy koron belul hanem mind a kor kozepehez kepest
  // legyen ugyanolyan szogben
  // saveFrame("out2/#####.png");
}

void createPoints() {
  particles = new ArrayList<PVector>();
  PVector pos = new PVector(0, circleDistance);
  for (int i = 0; i < circleCount; i++) {
    int xx = floor((i + 1) * pointsPerCircleMultiplier);
    for (int j = 0; j < xx; j++) {
      particles.add(pos.copy());
      pos.rotate(TWO_PI / xx);
    }
    pos.setMag(pos.mag() + circleDistance);
  }
}
