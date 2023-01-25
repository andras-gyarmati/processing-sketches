ArrayList<PVector> points;
QuadTree qTree;
int initPointCount, quadTreeNodePointCapacity, stopMargin;
float resampleDist, relaxScalar, maxMag;
PVector center, base;
boolean stop;

void setup() {
  size(1000, 1000);
  surface.setLocation(10, 10);
  base = new PVector(100, 0); //PVector.random2D().setMag(randomlen());
  center = new PVector(width / 2, height / 2);
  resampleDist = 30; //random(3) + 5;
  relaxScalar = 20; //random(2) + 1.3;
  initPointCount = 10; //floor(random(7)) + 3;
  maxMag = /*random(resampleDist / relaxScalar) +*/ 0.4;
  quadTreeNodePointCapacity = 4;
  points = new ArrayList<PVector>();
  for (int i = 0; i <= initPointCount; i++) {
    points.add(PVector.add(base, center));
    base.rotate(TWO_PI / initPointCount); //.setMag(randomlen());
  }
  stopMargin = 50;
  noFill();
  stroke(30);
  strokeWeight(resampleDist / 3);
  //noStroke();
  //fill(255);
  rectMode(CENTER);
  frameRate(1);
}

float randomlen() {
  return random(250) + 50;
}

void update() {
  points = resample(points, resampleDist);
  qTree = new QuadTree(new Rect(width / 2, height / 2, width / 2, height / 2));
  for (PVector p : points) {
    if (p.x < stopMargin || p.x > width - stopMargin || p.y < stopMargin || p.y > height - stopMargin)
      stop = true;
    qTree.add(p);
  }
  //points = relax(points, resampleDist * relaxScalar);
  relax(points, resampleDist * relaxScalar);
}

void draw() {
  background(220);
  update();
  drawShape(points);
  if (stop) {
    noLoop();
    String s = "" + initPointCount
      + "_" + resampleDist
      + "_" + relaxScalar
      + "_" + maxMag
      + "_" + base.x
      + "_" + base.y;
    //saveFrame("export/fill/" + s + ".png");
  }
  //saveFrame("frames/####.png");
}

void drawShape(ArrayList<PVector> array) {
  beginShape();
  for (PVector p : array) {
    curveVertex(p.x, p.y);
    stroke(220, 21, 21);
    ellipse(p.x, p.y, 3, 3);
    stroke(30);
  }
  //endShape(CLOSE);
  endShape();
}

ArrayList<PVector> resample_old(ArrayList<PVector> array, float dist) {
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
  //float epsilon = 4;
  if (count > 1 /*&& PVector.dist(first, res.get(count - 1)) < epsilon*/) res.remove(count - 1);
  if (count > 0) res.add(first);
  return res;
}

ArrayList<PVector> resample(ArrayList<PVector> points, float spacing) {
  ArrayList<PVector> newPoints = new ArrayList<PVector>();
  float d = 0;
  for (int i = 1; i < points.size(); i++) {
    PVector p1 = points.get(i - 1);
    PVector p2 = points.get(i);
    float d2 = PVector.dist(p1, p2);
    if (d + d2 >= spacing) {
      PVector newPoint = PVector.lerp(p1, p2, (spacing - d) / d2);
      newPoints.add(newPoint);
      points.add(i, newPoint);
      d = 0;
    }
    else {
      d += d2;
    }
  }
  return newPoints;
}


// todo: voronoi
ArrayList<PVector> relax_old(ArrayList<PVector> array, float dist) {
  ArrayList<PVector> rel = new ArrayList<PVector>();
  for (int i = 0; i < array.size(); i++) {
    PVector cur = array.get(i);
    float scalar = noise(cur.x, cur.y) + 0.5;
    println(scalar);
    float curDist = dist * scalar * 2;
    int ngbrCount = 0;
    PVector diff = new PVector(0, 0);
    ArrayList<PVector> nbrs = qTree.get(new Circle(cur.x, cur.y, curDist), null);
    for (PVector p : nbrs) {
      if (p == cur) continue;
      ngbrCount++;
      PVector v = PVector.sub(cur, p);
      diff.add(v.setMag(curDist - v.mag()));
    }
    diff.mult(1.0f / ngbrCount);
    if (diff.mag() > maxMag) {
      diff.setMag(maxMag);
    }
    //println(resampleDist, relaxScalar, maxMag, diff.mag());
    rel.add(PVector.add(cur, diff));
  }
  return rel;
}

void relax(ArrayList<PVector> points, float relaxation) {
  float k = relaxation;
  for (int i = 0; i < points.size(); i++) {
    PVector p1 = points.get(i);
    for (int j = i + 1; j < points.size(); j++) {
      PVector p2 = points.get(j);
      float d = PVector.dist(p1, p2);
      PVector dir = PVector.sub(p1, p2);
      dir.normalize();
      dir.mult(k * (d - 1));
      p1.sub(dir);
      p2.add(dir);
    }
  }
}
