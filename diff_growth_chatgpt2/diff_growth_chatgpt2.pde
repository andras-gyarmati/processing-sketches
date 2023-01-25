ArrayList<PVector> points;
QuadTree quadTree;
int initPointCount, quadTreeSectionCapacity;
float resampleDistance, relaxDistance;

void setup() {
  size(1000, 1000);
  surface.setLocation(10, 10);
  PVector currentPointVector = new PVector(0, 100);
  PVector center = new PVector(width / 2, height / 2);
  resampleDistance = 10;
  relaxDistance = 1.5 * resampleDistance;
  initPointCount = 3;
  quadTreeSectionCapacity = 4;
  points = new ArrayList<PVector>();
  for (int i = 0; i <= initPointCount; i++) {
    points.add(PVector.add(currentPointVector, center));
    currentPointVector.rotate(TWO_PI / initPointCount);
  }
  noFill();
  stroke(0);
  rectMode(CENTER);
}

void update() {
  points = resample(points, resampleDistance);
  quadTree = new QuadTree(new RectQuadTreeSectionBound(width / 2, height / 2, width / 2, height / 2));
  for (PVector point : points) {
    quadTree.add(point);
  }
  points = relax(points, relaxDistance);
}

void draw() {
  background(150);
  update();
  drawShape(points);
}

void drawShape(ArrayList<PVector> array) {
  beginShape();
  for (PVector p : array) {
    vertex(p.x, p.y);
    ellipse(p.x, p.y, 4, 4);
  }
  endShape();
}

ArrayList<PVector> resample(ArrayList<PVector> array, float distance) {
  float corrected = 0;
  float sumLen = 0;
  for (int i = 0; i < array.size() - 1; i++) {
    sumLen += PVector.dist(array.get(i), array.get(i + 1));
  }
  corrected = sumLen / ceil(sumLen / distance);
  ArrayList<PVector> res =  new ArrayList<PVector>();
  int i = 1;
  float remainder = 0;
  float offset = distance / 20;
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
    ArrayList<PVector> nbrs = quadTree.get(new CircleQuadTreeMask(cur.x, cur.y, dist), null);
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

class QuadTree {
  QuadTree nw;
  QuadTree ne;
  QuadTree sw;
  QuadTree se;
  RectQuadTreeSectionBound bound;
  ArrayList<PVector> points;
  boolean hasSubSections;

  QuadTree(RectQuadTreeSectionBound bound) {
    this.bound = bound;
    this.hasSubSections = false;
    this.points = new ArrayList<PVector>();
  }

  void add(PVector p) {
    if (this.points.size() < quadTreeSectionCapacity) {
      this.points.add(p);
    } else {
      if (!this.hasSubSections) {
        float cx = this.bound.centerX;
        float cy = this.bound.centerY;
        float hhw = this.bound.halfWidth / 2;
        float hhh = this.bound.halfHeight / 2;
        this.nw = new QuadTree(new RectQuadTreeSectionBound(cx - hhw, cy - hhh, hhw, hhh));
        this.ne = new QuadTree(new RectQuadTreeSectionBound(cx + hhw, cy - hhh, hhw, hhh));
        this.sw = new QuadTree(new RectQuadTreeSectionBound(cx - hhw, cy + hhh, hhw, hhh));
        this.se = new QuadTree(new RectQuadTreeSectionBound(cx + hhw, cy + hhh, hhw, hhh));
        this.hasSubSections = true;
      }
      if (p.x < this.bound.centerX) {
        if (p.y < this.bound.centerY) {
          this.nw.add(p);
        } else {
          this.sw.add(p);
        }
      } else {
        if (p.y < this.bound.centerY) {
          this.ne.add(p);
        } else {
          this.se.add(p);
        }
      }
    }
  }

  ArrayList<PVector> get(CircleQuadTreeMask c, ArrayList<PVector> array) {
    if (null == array) {
      array = new ArrayList<PVector>();
    }
    if (!this.bound.overlaps(c)) {
      return array;
    } else {
      for (PVector p : this.points) {
        if (c.contains(p)) {
          array.add(p);
        }
      }
      if (this.hasSubSections) {
        this.nw.get(c, array);
        this.ne.get(c, array);
        this.sw.get(c, array);
        this.se.get(c, array);
      }
    }
    return array;
  }

  void show() {
    if (this.hasSubSections) {
      this.nw.show();
      this.ne.show();
      this.sw.show();
      this.se.show();
    }
  }
}

class RectQuadTreeSectionBound {
  float centerX, centerY, halfWidth, halfHeight;

  RectQuadTreeSectionBound(float centerX, float centerY, float halfWidth, float halfHeight) {
    this.centerX = centerX;
    this.centerY = centerY;
    this.halfWidth = halfWidth;
    this.halfHeight = halfHeight;
  }

  boolean overlaps(RectQuadTreeSectionBound rect) {
    return !(this.centerX - this.halfWidth > rect.centerX + rect.halfWidth || this.centerX + this.halfWidth < rect.centerX - rect.halfWidth
      || this.centerY - this.halfHeight > rect.centerY + rect.halfHeight || this.centerY + this.halfHeight < rect.centerY - rect.halfHeight);
  }

  boolean overlaps(CircleQuadTreeMask circle) {
    float centerDistanceX = abs(circle.x - this.centerX);
    float centerDistanceY = abs(circle.y - this.centerY);
    if (centerDistanceX > (this.halfWidth + circle.r)) return false;
    if (centerDistanceY > (this.halfHeight + circle.r)) return false;
    if (centerDistanceX <= (this.halfWidth)) return true;
    if (centerDistanceY <= (this.halfHeight)) return true;
    float cornerDistanceSquared = pow(centerDistanceX - this.halfWidth, 2) + pow(centerDistanceY - this.halfHeight, 2);
    return (cornerDistanceSquared <= pow(circle.r, 2));
  }

  boolean contains(PVector p) {
    return p.x > this.centerX - this.halfWidth && p.x < this.centerX + this.halfWidth &&
      p.y > this.centerY - this.halfHeight && p.y < this.centerY + this.halfHeight;
  }
}

class CircleQuadTreeMask {
  float x, y, r;

  CircleQuadTreeMask(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
  }

  boolean overlaps(RectQuadTreeSectionBound r) {
    return r.overlaps(this);
  }

  boolean overlaps(CircleQuadTreeMask c) {
    return PVector.dist(new PVector(this.x, this.y), new PVector(c.x, c.y)) < this.r + c.r;
  }

  boolean contains(PVector p) {
    return pow(p.x - this.x, 2) + pow(p.y - this.y, 2) < pow(this.r, 2);
  }
}
