ArrayList<PVector> points, debug; //<>//
QuadTree qTree;
int initPointCount, treeNodePointCount;
float resampleDist, relaxScalar, relaxDist, margin, cm; 
PVector center, base;
//boolean sw;

void setup() {
  size(1000, 1000);
  surface.setLocation(10, 10);
  base = new PVector(0, 1).setMag(200);
  center = new PVector(width / 2.f, height / 2.f);
  resampleDist = 40;
  relaxScalar = 1.4;
  relaxDist = resampleDist * relaxScalar;
  initPointCount = 6;
  treeNodePointCount = 4;
  initPoints();
  margin = 200;
  cm = width / 3f;
  noFill();
  stroke(255);
  strokeWeight(20);
  //sw = true;
  frameRate(20);
  rectMode(CENTER);
}

void initPoints() {
  points = new ArrayList<PVector>();
  debug = new ArrayList<PVector>();
  for (int i = 0; i <= initPointCount; i++) {
    PVector v = PVector.add(base, center);
    points.add(v);
    debug.add(v);
    base.rotate(TWO_PI / initPointCount);
  }
}

//void keyPressed() {
//  float step = 1;
//  if (key == CODED) {
//    if (keyCode == UP) {
//      resampleDist += step;
//    } else if (keyCode == DOWN) {
//      resampleDist -= step;
//      resampleDist = max(1, resampleDist);
//    } else if (keyCode == RIGHT) {
//      relaxDist += step;
//    } else if (keyCode == LEFT) {
//      relaxDist -= step;
//      relaxDist = max(1, relaxDist);
//    }
//  }
//}

//void mouseClicked() {
//  resampleDist = 3;
//  relaxDist = resampleDist * relaxScalar;
//}

void mouseClicked() {
  //saveFrame("still/####.png");
}
//  if (sw) {
//    resample();
//  } else {
//    relax();
//  }
//  sw = !sw;
//  redraw();
//}

void update() {
  resample();
  //int relCount = 2;
  //for (int i = 0; i < relCount; i++) {
  relax();
  //}
}

void draw() {
  background(0);
  //initPoints();
  update();
  //stroke(255, 0, 0);
  //drawShape(debug);
  //stroke(0);
  drawShape(points);
  //fill(255, 0, 0);
  //noStroke();
  //ellipse(width / 2, height / 2, width / 4, height / 4);
  //saveFrame("frames/####.png");
}

void drawShape(ArrayList<PVector> array) {
  noFill();
  stroke(255);
  //beginShape();
  //for (PVector p : array) { 
  //  vertex(p.x, p.y);
  //  ellipse(p.x, p.y, 3, 3);
  //}
  //endShape();
  int count = array.size();
  beginShape();
  for (int i = 0; i < count + 1; i++) { 
    PVector p = array.get(i % count);
    curveVertex(p.x, p.y);
  }
  endShape(CLOSE);
}

void resample() {
  ArrayList<PVector> res =  new ArrayList<PVector>();
  int i = 1;
  float remainder = 0;
  PVector p1 = points.get(0);
  PVector p2;
  //res.add(p1.copy());
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
  qTree = new QuadTree(new Rect(width / 2, height / 2, width / 2, height / 2));
  for (PVector p : points) {
    //if (p.x < margin) p.x = margin;
    //if (p.x > width - margin) p.x = width - margin;
    //if (p.y < margin) p.y = margin;
    //if (p.y > height - margin) p.y = height - margin;
    
    if (PVector.dist(center, p) > cm) p.limit(cm); 
    qTree.add(p);
  }
  ArrayList<PVector> rel = new ArrayList<PVector>();
  for (PVector cur : points) {
    int ngbrCount = 0;
    PVector diff = new PVector(0, 0);
    ArrayList<PVector> nbrs = qTree.get(new Circle(cur.x, cur.y, relaxDist), null);
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
