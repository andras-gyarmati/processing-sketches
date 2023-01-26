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
  initPointCount = 5;
  quadTreeSectionCapacity = 4;
  points = new ArrayList<PVector>();
  for (int i = 0; i <= initPointCount; i++) {
    points.add(PVector.add(currentPointVector, center));
    currentPointVector.rotate(TWO_PI / initPointCount);
  }
  noFill();
  stroke(0);
  strokeWeight(3);
  rectMode(CENTER);
  //frameRate(1);
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
  float scaler = 1.001;
  if (scaler < 1.001) scaler = 1.001;
  relaxDistance = scaler * resampleDistance;
  background(150);
  drawShape(points);
  update();
}

void drawShape(ArrayList<PVector> array) {
  beginShape();
  for (PVector point : array) {
    vertex(point.x, point.y);
    ellipse(point.x, point.y, 3, 3);
  }
  //for (int i = 0; i < 3; i++) {
  //  PVector point = array.get(i);
  //  curveVertex(point.x, point.y);
  //}
  endShape();
}

ArrayList<PVector> resample(ArrayList<PVector> pointsArray, float distance) {
  ArrayList<PVector> resampledPoints = new ArrayList<PVector>();
  float currentLength = 0;
  PVector p1, p2, newPoint;
  for (int i = 0; i < pointsArray.size() - 1; i++) {
    p1 = pointsArray.get(i);
    p2 = pointsArray.get(i + 1);
    float segmentLength = PVector.dist(p1, p2);
    currentLength += segmentLength;
    while (currentLength >= distance) {
      float t = (distance - currentLength + segmentLength) / segmentLength;
      newPoint = PVector.lerp(p1, p2, t);
      resampledPoints.add(newPoint);
      currentLength = currentLength - distance;
    }
  }
  resampledPoints.add(resampledPoints.get(0));
  return resampledPoints;
}

ArrayList<PVector> relax(ArrayList<PVector> array, float distance) {
  ArrayList<PVector> relaxedPoints = new ArrayList<PVector>();
  for (int i = 0; i < array.size(); i++) {
    PVector currentPoint = array.get(i);
    int neighbourCount = 0;
    PVector sumDifference = new PVector(0, 0);
    ArrayList<PVector> neighbours = quadTree.get(new CircleQuadTreeMask(currentPoint.x, currentPoint.y, distance), null);
    for (PVector neighbour : neighbours) {
      if (neighbour == currentPoint) continue;
      neighbourCount++;
      PVector difference = PVector.sub(currentPoint, neighbour);
      sumDifference.add(difference.setMag(distance - difference.mag()));
    }
    sumDifference.mult(1.0f / neighbourCount);
    relaxedPoints.add(PVector.add(currentPoint, sumDifference));
  }
  return relaxedPoints;
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

  void add(PVector point) {
    if (this.points.size() < quadTreeSectionCapacity) {
      this.points.add(point);
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
      if (point.x < this.bound.centerX) {
        if (point.y < this.bound.centerY) {
          this.nw.add(point);
        } else {
          this.sw.add(point);
        }
      } else {
        if (point.y < this.bound.centerY) {
          this.ne.add(point);
        } else {
          this.se.add(point);
        }
      }
    }
  }

  ArrayList<PVector> get(CircleQuadTreeMask circle, ArrayList<PVector> array) {
    if (null == array) {
      array = new ArrayList<PVector>();
    }
    if (!this.bound.overlaps(circle)) {
      return array;
    } else {
      for (PVector p : this.points) {
        if (circle.contains(p)) {
          array.add(p);
        }
      }
      if (this.hasSubSections) {
        this.nw.get(circle, array);
        this.ne.get(circle, array);
        this.sw.get(circle, array);
        this.se.get(circle, array);
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

  boolean contains(PVector point) {
    return point.x > this.centerX - this.halfWidth && point.x < this.centerX + this.halfWidth &&
      point.y > this.centerY - this.halfHeight && point.y < this.centerY + this.halfHeight;
  }
}

class CircleQuadTreeMask {
  float x, y, r;

  CircleQuadTreeMask(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
  }

  boolean overlaps(RectQuadTreeSectionBound rect) {
    return rect.overlaps(this);
  }

  boolean overlaps(CircleQuadTreeMask circle) {
    return PVector.dist(new PVector(this.x, this.y), new PVector(circle.x, circle.y)) < this.r + circle.r;
  }

  boolean contains(PVector point) {
    return pow(point.x - this.x, 2) + pow(point.y - this.y, 2) < pow(this.r, 2);
  }
}
