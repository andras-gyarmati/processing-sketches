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
  frameRate(10);
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
  drawShape(points);
  update();
}

void drawShape(ArrayList<PVector> array) {
  beginShape();
  for (PVector p : array) {
    vertex(p.x, p.y);
    ellipse(p.x, p.y, 4, 4);
  }
  endShape();
}

ArrayList<PVector> resample(ArrayList<PVector> pointsArray, float distance) {
  ArrayList<PVector> resampledPoints = new ArrayList<PVector>();
  float currentLength = 0;
  for (int i = 0; i < pointsArray.size() - 1; i++) {
    PVector p1 = pointsArray.get(i);
    PVector p2 = pointsArray.get(i + 1);
    float segmentLength = PVector.dist(p1, p2);
    currentLength += segmentLength;
    while (currentLength >= distance) {
        float t = (distance - currentLength + segmentLength) / segmentLength;
        PVector newPoint = PVector.lerp(p1, p2, t);
        resampledPoints.add(newPoint);
        currentLength = currentLength - distance;
    }
  }
  resampledPoints.add(pointsArray.get(0));
  return resampledPoints;
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
