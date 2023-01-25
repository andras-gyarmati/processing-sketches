ArrayList<PVector> points, debug; //<>//
QuadTree qTree;
int initPointCount, treeNodePointCount;
float resampleDist, relaxScalar, relaxDist, margin, maxMag; 
PVector center, base;

void setup() {
  size(1000, 1000);
  surface.setLocation(10, 10);
  base = new PVector(0, 1).setMag(200);
  center = new PVector(width / 2, height / 2);
  resampleDist = 20;
  relaxScalar = 1;
  relaxDist = resampleDist * relaxScalar;
  initPointCount = 20;
  treeNodePointCount = 4;
  initPoints();
  margin = resampleDist * 2;
maxMag = /*random(resampleDist / relaxScalar) +*/ 0.2;
  noFill();
  stroke(255);
  strokeWeight(2);
  frameRate(20);
  rectMode(CENTER);
  //frameRate(0.3);
  strokeCap(SQUARE);
}

void initPoints() {
  points = new ArrayList<PVector>();
  //debug = new ArrayList<PVector>();
  for (int i = 0; i <= initPointCount; i++) {
    PVector v = PVector.add(base, center); //.mult(0.9 + random(0.2));
    points.add(v);
    //debug.add(v);
    base.rotate(TWO_PI / initPointCount);
  }
  //points.add(points.get(0)); // TODO FIX BUG: first and last point should stay together
}

void update() {
  divideLongEdges();
  pointRelax();
}

//void mousePressed() {
//  resampleDist /= 2;
//  relaxDist = resampleDist * relaxScalar;
//}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  resampleDist *= 1 + (0.5 * e);
  resampleDist = constrain(resampleDist, 10, 40);
  relaxDist = resampleDist * relaxScalar;
}

void draw() {
  background(0);
  update();
  drawShape(points);
  //frameRate(1);
}

void drawShape(ArrayList<PVector> array) {
  noFill();
  stroke(255);
  int count = array.size();
  beginShape();
  for (int i = 0; i < count + 1; i++) { 
    PVector p = array.get(i % count);
    curveVertex(p.x, p.y);
  }
  endShape(CLOSE);

  //beginShape();
  //for (PVector p : array) {
  //  stroke(255);
  //  vertex(p.x, p.y);
  //  //stroke(255, 0, 0);
  //  //ellipse(p.x, p.y, 5, 5);
  //  //stroke(255);
  //}
  //endShape(CLOSE);
}

void divideLongEdges() {
  for (int i = 0; i < points.size() - 1; i++) {
    PVector former = points.get(i);
    PVector later = points.get(i + 1);
    if (PVector.dist(former, later) > resampleDist) {
      subdivideEdge(former, later);
    }
  }
}

void subdivideEdge(PVector former, PVector later) {
  float newX = (former.x + later.x) / 2; // + random(1) - 0.5;
  float newY = (former.y + later.y) / 2; // + random(1) - 0.5;
  PVector newPoint = new PVector(newX, newY);
  points.add(points.indexOf(later), newPoint);
  if (PVector.dist(former, newPoint) > resampleDist) {
    subdivideEdge(former, newPoint);
    subdivideEdge(newPoint, later);
  }
}

void pointRelax() {
  float d = 2;
  qTree = new QuadTree(new Rect(width / 2, height / 2, width / 2, height / 2));
  for (PVector point : points) {
    if (point.x < margin) point.x = margin;
    if (point.x > width - margin) point.x = width - margin;
    if (point.y < margin) point.y = margin;
    if (point.y > height - margin) point.y = height - margin;
    qTree.add(point.add(random(d) - d / 2, random(d) - d / 2));
  }
  ArrayList<PVector> relaxedPoints = new ArrayList<PVector>();
  for (PVector currentPoint : points) {
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
    if (summedDiffVector.mag() > maxMag) {
      summedDiffVector.setMag(maxMag);
    }
    relaxedPoints.add(PVector.add(currentPoint, summedDiffVector));
  }
  points = relaxedPoints;
  //PVector last = points.get(points.size() - 1);
  //points.get(0).set(last.x, last.y);
}
