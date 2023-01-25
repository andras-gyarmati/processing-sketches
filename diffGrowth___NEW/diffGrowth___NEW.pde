ArrayList<PVector> ps = new ArrayList();
QuadTree qTree;
float margin, resampleDist, relaxScalar, relaxDist;

void setup() {
  size(500, 500);
  float pc = 200.f;
  margin = 20;
  resampleDist = 10;
  relaxScalar = 1.1;
  relaxDist = resampleDist * relaxScalar;

  PVector base = new PVector(1, 1);
  for (int i = 0; i < pc; ++i) {
    ps.add(base.copy().mult(50));
    base.rotate(TWO_PI / pc);
  }
  smooth(8);
}

void draw() {
  background(255);
  translate(width / 2.f, height / 2.f);
  beginShape();
  for (PVector p : ps) {
    vertex(p.x, p.y);
  }
  endShape();
  relax();
}

void relax() {
  float d = 2;
  qTree = new QuadTree(new Rect(width / 2, height / 2, width / 2, height / 2));
  for (PVector point : ps) {
    if (point.x < margin) point.x = margin;
    if (point.x > width - margin) point.x = width - margin;
    if (point.y < margin) point.y = margin;
    if (point.y > height - margin) point.y = height - margin;
    qTree.add(point.add(random(d) - d / 2, random(d) - d / 2));
  }
  ArrayList<PVector> relaxedps = new ArrayList<PVector>();
  for (PVector currentPoint : ps) {
    int neighborCount = 0;
    PVector summedDiffVector = new PVector(0, 0);
    ArrayList<PVector> neighbors = qTree.get(new Circle(currentPoint.x, currentPoint.y, relaxDist), null);
    for (PVector neighbor : neighbors) {
      if (neighbor == currentPoint) continue;
      neighborCount++;
      PVector neighborDiffVector = PVector.sub(currentPoint, neighbor);
      summedDiffVector.add(neighborDiffVector.setMag(relaxDist - neighborDiffVector.mag()));
    }
    summedDiffVector.mult(1.0f / neighborCount);
    relaxedps.add(PVector.add(currentPoint, summedDiffVector));
  }
  ps = relaxedps;
}
