ArrayList<PVector> ps, r; //<>//
QuadTree qt;
int initPointCount, qtLim;
float resampleDist, relaxMult; 
boolean sw;
PVector center;

void setup() {
  size(1000, 1000);
  sw = true;
  surface.setLocation(10, 10);
  PVector base = new PVector(0, 100);
  center = new PVector(width / 2, height / 2);
  resampleDist = 51;
  relaxMult = 1.5;
  initPointCount = 3;
  qtLim = 4;
  ps = new ArrayList<PVector>();
  r = new ArrayList<PVector>();
  for (int i = 0; i <= initPointCount; i++) {
    ps.add(PVector.add(base, center));
    r.add(PVector.add(base, center));
    base.rotate(TWO_PI / initPointCount);
  }
  noFill();
  stroke(0);
  rectMode(CENTER);
  noLoop();
}

void mouseClicked() {
  update();
  redraw();
}

void update() {
  stroke(0, 0, 255);
  if (sw) {
    r = resample(r, resampleDist);
  } else {
    qt = new QuadTree(new Rect(width / 2, height / 2, width / 2, height / 2));
    for (PVector p : r) {
      qt.add(p);
    }
    //qt.show();
    r = relax(r, resampleDist * relaxMult);
  }
  sw = !sw;
}

void draw() {
  background(150);
  //update();
  stroke(0);
  drawShape(ps);
  stroke(255, 0, 0);
  drawShape(r);
  //saveFrame("frames/####.png");

  //Circle c = new Circle(mouseX, mouseY, 50);
  //ArrayList<PVector> debug = qt.get(c, null);
  //stroke(0, 255, 0);
  //c.show();
  //fill(0, 255, 0);
  //for (PVector p : debug) {
  //  ellipse(p.x, p.y, 3, 3);
  //}
  //noFill();
}

void drawShape(ArrayList<PVector> array) {
  beginShape();
  for (PVector p : array) { 
    vertex(p.x, p.y);
    ellipse(p.x, p.y, 4, 4);
  }
  endShape();
}

ArrayList<PVector> resample(ArrayList<PVector> array, float dist) {
  float corrected = 0;
  float sumLen = 0;
  for (int i = 0; i < array.size() - 1; i++) {
    sumLen += PVector.dist(array.get(i), array.get(i + 1));
  }
  corrected = sumLen / ceil(sumLen / dist);
  //println("sumlen: " + sumLen);
  //println("dist: " + dist);
  //println("(sumLen / dist): " + (sumLen / dist));
  //println("ceil(sumLen / dist): " + ceil(sumLen / dist));
  //println("corrected: " + corrected);
  //println("corrected * array.size() - 1: " + (corrected * (array.size() - 1)));
  //println("array.size() - 1: " + (array.size() - 1));
  //println("------------------------------------");
  //corrected = dist;
  ArrayList<PVector> res =  new ArrayList<PVector>();
  int i = 1;
  float remainder = 0;
  float offset = dist / 20;
  PVector p1 = array.get(0);
  PVector p2 = new PVector();
  PVector diff = PVector.sub(p2, p1);
  diff.setMag(offset);
  p1.add(diff);
  res.add(p1.copy());
  while (i < array.size()) {
    p2 = array.get(i);
    diff = PVector.sub(p2, p1);
    if (remainder > 0) {
      diff.setMag(remainder);
      p1.add(diff);
      res.add(p1.copy());
      remainder = 0;
    }
    diff.setMag(corrected);
    while (p1.dist(p2) >= corrected) {
      p1.add(diff);
      res.add(p1.copy());
    }
    remainder = corrected - p1.dist(p2);
    p1 = p2.copy();
    i++;
  }
  PVector first = res.get(0);
  int count = res.size();
  float epsilon = 1;
  if (count > 1 && PVector.dist(first, res.get(count - 1)) < epsilon) res.remove(count - 1);
  if (count > 0) res.add(first);
  return res;
}

ArrayList<PVector> relax(ArrayList<PVector> array, float dist) {
  ArrayList<PVector> rel = new ArrayList<PVector>();
  for (int i = 0; i < array.size(); i++) {
    PVector cur = array.get(i);
    int ngbrCount = 0;
    PVector diff = new PVector(0, 0);
    ArrayList<PVector> nbrs = qt.get(new Circle(cur.x, cur.y, dist), null);
    for (PVector p : nbrs) {
      //for (PVector p : r) {
      if (p == cur) continue;
      //if (PVector.dist(p, cur) < dist) {
      ngbrCount++;
      //print(ngbrCount + " ");
      PVector v = PVector.sub(cur, p);
      diff.add(v.setMag(dist - v.mag()));
      //}
    }
    diff.mult(1.0f / ngbrCount);
    rel.add(PVector.add(cur, diff));
  }
  return rel;
}

class QuadTree {
  QuadTree nw;
  QuadTree ne;
  QuadTree sw;
  QuadTree se;
  Rect bound;
  ArrayList<PVector> points;
  boolean isDivd;

  QuadTree(Rect bound) {
    this.bound = bound;
    this.isDivd = false;
    this.points = new ArrayList<PVector>();
  }

  void add(PVector p) {
    if (this.points.size() < qtLim) {
      this.points.add(p);
    } else {
      if (!this.isDivd) {
        float cx = this.bound.cx;
        float cy = this.bound.cy;
        float hhw = this.bound.hw / 2;
        float hhh = this.bound.hh / 2;
        this.nw = new QuadTree(new Rect(cx - hhw, cy - hhh, hhw, hhh));
        this.ne = new QuadTree(new Rect(cx + hhw, cy - hhh, hhw, hhh));
        this.sw = new QuadTree(new Rect(cx - hhw, cy + hhh, hhw, hhh));
        this.se = new QuadTree(new Rect(cx + hhw, cy + hhh, hhw, hhh));
        this.isDivd = true;
      }
      if (p.x < this.bound.cx) {
        if (p.y < this.bound.cy) {
          this.nw.add(p);
        } else {
          this.sw.add(p);
        }
      } else {
        if (p.y < this.bound.cy) {
          this.ne.add(p);
        } else {
          this.se.add(p);
        }
      }
    }
  }
  //todo add random color to every qt box to see whats where
  //also might wanna have points only in leaves
  ArrayList<PVector> get(Circle c, ArrayList<PVector> array) {
    if (null == array) {
      array = new ArrayList<PVector>();
    }
    //stroke(255, 255, 255);
    //this.bound.show();
    //c.show();
    if (!this.bound.overlaps(c)) {
      return array;
    } else {
      for (PVector p : this.points) {
        if (c.contains(p)) {
          array.add(p);
        }
      }
      if (this.isDivd) {
        this.nw.get(c, array);
        this.ne.get(c, array);
        this.sw.get(c, array);
        this.se.get(c, array);
      }
    }
    return array;
  }

  void show() {
    this.bound.show();
    if (this.isDivd) {
      this.nw.show();
      this.ne.show();
      this.sw.show();
      this.se.show();
    }
  }
}

class Rect {
  float cx, cy, hw, hh;

  Rect(float cx, float cy, float hw, float hh) {
    this.cx = cx;
    this.cy = cy;
    this.hw = hw;
    this.hh = hh;
  }

  boolean overlaps(Rect r) {
    return !(this.cx - this.hw > r.cx + r.hw || this.cx + this.hw < r.cx - r.hw
      || this.cy - this.hh > r.cy + r.hh || this.cy + this.hh < r.cy - r.hh);
  }

  boolean overlaps(Circle c) {
    float cdx = abs(c.x - this.cx);
    float cdy = abs(c.y - this.cy);
    if (cdx > (this.hw + c.r)) return false;
    if (cdy > (this.hh + c.r)) return false;
    if (cdx <= (this.hw)) return true;
    if (cdy <= (this.hh)) return true;
    float cornerDist_sq = pow(cdx - this.hw, 2) + pow(cdy - this.hh, 2);
    return (cornerDist_sq <= pow(c.r, 2));
  }

  boolean contains(PVector p) {
    return p.x > this.cx - this.hw && p.x < this.cx + this.hw && 
      p.y > this.cy - this.hh && p.y < this.cy + this.hh;
  }

  void show() {
    rect(this.cx, this.cy, this.hw * 2, this.hh * 2);
  }
}

class Circle {
  float x, y, r;

  Circle(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
  }

  boolean overlaps(Rect r) {
    return r.overlaps(this);
  }

  boolean overlaps(Circle c) {
    return PVector.dist(new PVector(this.x, this.y), new PVector(c.x, c.y)) < this.r + c.r;
  }

  boolean contains(PVector p) {
    return pow(p.x - this.x, 2) + pow(p.y - this.y, 2) < pow(this.r, 2);
  }

  void show() {
    ellipse(this.x, this.y, this.r * 2, this.r * 2);
  }
}
