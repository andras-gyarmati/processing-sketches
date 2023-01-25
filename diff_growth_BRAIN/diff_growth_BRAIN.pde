ArrayList<PVector> points; //<>//
QuadTree qTree;
int initPointCount, quadTreeNodePointCapacity;
float resampleDist, relaxScalar; 
PVector center, base;
boolean stop;
ArrayList<Circle> bounds;
boolean start;
PVector newBoundCenter, newBoundEdge;

void setup() {
  size(1000, 1000);
  surface.setLocation(10, 10);
  base = PVector.random2D().setMag(randomlen());
  center = new PVector(width / 2, height / 2);
  resampleDist = 10; //random(3) + 5;
  relaxScalar = 4; //random(2) + 1.3;
  initPointCount = floor(random(7)) + 3;
  quadTreeNodePointCapacity = 4;
  points = new ArrayList<PVector>();
  for (int i = 0; i <= initPointCount; i++) {
    points.add(PVector.add(base, center));
    base.rotate(TWO_PI / initPointCount);//.setMag(randomlen());
  }
  bounds = new ArrayList<Circle>();
  //bounds.add(new Circle(width / 2, height / 2, 300));
  start = false;
  noFill();
  stroke(255);
  strokeWeight(resampleDist / 3);
  rectMode(CENTER);
}

float randomlen() {
  return random(250) + 50;
}

void update() {
  points = resample(points, resampleDist);
  qTree = new QuadTree(new Rect(width / 2, height / 2, width / 2, height / 2));
  for (PVector p : points) {
    qTree.add(p);
  }
  points = relax(points, resampleDist * relaxScalar);
}

void draw() {
  background(0);
  if (start) {
    update();
    drawShape(points);
  } else {
    for (Circle bound : bounds) {
      bound.show();
    }
  }
}

void keyPressed() {
  if ( key == ' ' ) {
    start = true;
  }
}

void mousePressed() {
  newBoundCenter = new PVector(mouseX, mouseY);
}

void mouseDragged() {
  newBoundEdge = new PVector(mouseX, mouseY);
  float dist = PVector.dist(newBoundCenter, newBoundEdge);
  ellipse(newBoundCenter.x, newBoundCenter.y, dist * 2, dist * 2);
}

void mouseReleased() {
  float dist = PVector.dist(newBoundCenter, newBoundEdge);
  bounds.add(new Circle(newBoundCenter.x, newBoundCenter.y, dist));
}

void drawShape(ArrayList<PVector> array) {
  beginShape();
  for (PVector p : array) { 
    curveVertex(p.x, p.y);
  }
  endShape(CLOSE);
}

ArrayList<PVector> resample(ArrayList<PVector> array, float dist) {
  ArrayList<PVector> res =  new ArrayList<PVector>();
  int i = 1;
  float remainder = 0;
  PVector p1 = array.get(0);
  PVector p2 = new PVector();
  res.add(p1.copy());
  while (i < array.size()) {
    p2 = array.get(i);
    PVector diff = PVector.sub(p2, p1);
    if (remainder > 0) {
      diff.setMag(remainder);
      p1.add(diff);
      res.add(p1.copy());
      remainder = 0;
    }
    diff.setMag(dist);
    while (p1.dist(p2) >= dist) {
      p1.add(diff);
      res.add(p1.copy());
    }
    remainder = dist - p1.dist(p2);
    p1 = p2.copy();
    i++;
  }
  PVector first = res.get(0);
  int count = res.size();
  if (count > 1) res.remove(count - 1);
  if (count > 0) res.add(first);
  return res;
}

boolean isOutsideOfBounds(PVector p) {
  boolean isOutside = true;
  for (Circle bound : bounds) {
    ArrayList<PVector> inside = qTree.get(bound, null);
    if (inside.contains(p)) {
      isOutside = false;
    }
  }
  return isOutside;
}

ArrayList<PVector> relax(ArrayList<PVector> array, float dist) {
  ArrayList<PVector> rel = new ArrayList<PVector>();
  for (int i = 0; i < array.size(); i++) {
    PVector cur = array.get(i);
    if (isOutsideOfBounds(cur)) continue;
    int ngbrCount = 0;
    PVector diff = new PVector(0, 0);
    ArrayList<PVector> nbrs = qTree.get(new Circle(cur.x, cur.y, dist), null);
    for (PVector p : nbrs) {
      if (p == cur) continue;
      ngbrCount++;
      PVector v = PVector.sub(cur, p);
      diff.add(v.setMag(dist - v.mag()));
    }
    diff.mult(1.0f / ngbrCount);
    rel.add(PVector.add(cur, diff));
  }
  return rel;
}
