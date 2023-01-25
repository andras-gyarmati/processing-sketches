ArrayList<PVector> points, debug; //<>//
QuadTree tree;
int initPointCount, treeNodePointCount;
float resampleDist, relaxScalar, relaxDist, margin; 
PVector center, base;
boolean sw;

void setup() {
  size(1000, 1000);
  surface.setLocation(10, 10);
  base = new PVector(0, 1).setMag(200);
  center = new PVector(width / 2, height / 2);
  resampleDist = 20;
  relaxScalar = 1.1;
  relaxDist = resampleDist * relaxScalar;
  initPointCount = 6;
  treeNodePointCount = 4;
  points = new ArrayList<PVector>();
  debug = new ArrayList<PVector>();
  for (int i = 0; i <= initPointCount; i++) {
    PVector v = PVector.add(base, center);
    points.add(v);
    debug.add(v);
    base.rotate(TWO_PI / initPointCount);
  }
  margin = 50;
  noFill();
  stroke(0);
  strokeWeight(1);
  sw = true;
  frameRate(10);
}

void keyPressed() {
  float step = 10;
  if (key == CODED) {
    if (keyCode == UP) {
      relaxDist += step;
    } else if (keyCode == DOWN) {
      relaxDist -= step;
    }
  }
}

void mouseClicked() {
  if (sw) {
    resample();
  } else {
    relax();
  }
  sw = !sw;
  redraw();
}

void update() {
  resample();
  //int relCount = 1;
  //for (int i = 0; i < relCount; i++) {
  relax();
  //}
}

void draw() {
  background(255);
  points = new ArrayList<PVector>();
  debug = new ArrayList<PVector>();
  for (int i = 0; i <= initPointCount; i++) {
    PVector v = PVector.add(base, center);
    points.add(v);
    debug.add(v);
    base.rotate(TWO_PI / initPointCount);
  }
  update();
  resample();
  stroke(255, 0, 0);
  drawShape(debug);
  stroke(0);
  drawShape(points);
}

void drawShape(ArrayList<PVector> array) {
  beginShape();
  for (PVector p : array) { 
    vertex(p.x, p.y);
    ellipse(p.x, p.y, 3, 3);
  }
  endShape(CLOSE);
}

void resample() {
  ArrayList<PVector> res =  new ArrayList<PVector>();
  int i = 1;
  float remainder = 0;
  PVector p1 = points.get(0);
  PVector p2 = new PVector();
  res.add(p1.copy());
  while (i < points.size()) {
    p2 = points.get(i);
    PVector diff = PVector.sub(p2, p1);
    if (remainder > 0) {
      diff.setMag(remainder);
      p1.add(diff);
      res.add(p1.copy());
      remainder = 0;
    }
    diff.setMag(resampleDist);
    while (p1.dist(p2) >= resampleDist) {
      p1.add(diff);
      res.add(p1.copy());
    }
    remainder = resampleDist - p1.dist(p2);
    p1 = p2.copy();
    i++;
  }
  PVector first = res.get(0);
  int count = res.size();
  //float epsilon = 4;
  if (count > 1 /*&& PVector.dist(first, res.get(count - 1)) < epsilon*/) res.remove(count - 1);
  if (count > 0) res.add(first);
  points = res;
}

void relax() {
  tree = new QuadTree(new Rect(width / 2, height / 2, width / 2, height / 2));
  for (PVector p : points) {
    if (p.x < margin) p.x = margin;
    if (p.x > width - margin) p.x = width - margin;
    if (p.y < margin) p.y = margin;
    if (p.y > height - margin) p.y = height - margin;
    tree.add(p);
  }
  ArrayList<PVector> rel = new ArrayList<PVector>();
  for (int i = 0; i < points.size(); i++) {
    PVector cur = points.get(i);
    int ngbrCount = 0;
    PVector diff = new PVector(0, 0);
    ArrayList<PVector> nbrs = tree.get(new Circle(cur.x, cur.y, relaxDist), null);
    for (PVector p : nbrs) {
      if (p == cur) continue;
      ngbrCount++;
      PVector v = PVector.sub(cur, p);
      diff.add(v.setMag(relaxDist - v.mag()));
    }
    diff.mult(1.0f / ngbrCount);
    rel.add(PVector.add(cur, diff));
  }
  points = rel;
}
