class Point {
  float x, y;
  Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

class Rectangle {
  float x, y, w, h;
  Rectangle(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  boolean contains(Point point) {
    return (point.x >= this.x - this.w &&
      point.x <= this.x + this.w &&
      point.y >= this.y - this.h &&
      point.y <= this.y + this.h);
  }

  boolean intersects(Rectangle range) {
    return !(range.x - range.w > this.x + this.w ||
      range.x + range.w < this.x - this.w ||
      range.y - range.h > this.y + this.h ||
      range.y + range.h < this.y - this.h);
  }
}

class QuadTree {
  Rectangle boundary;
  int capacity;
  ArrayList<Point> points;
  boolean divided;
  QuadTree northeast, northwest, southeast, southwest;

  QuadTree(Rectangle boundary, int n) {
    this.boundary = boundary;
    this.capacity = n;
    this.points = new ArrayList<Point>();
    this.divided = false;
  }

  void subdivide() {
    float x = this.boundary.x;
    float y = this.boundary.y;
    float w = this.boundary.w;
    float h = this.boundary.h;
    Rectangle ne = new Rectangle(x + w / 2, y - h / 2, w / 2, h / 2);
    this.northeast = new QuadTree(ne, this.capacity);
    Rectangle nw = new Rectangle(x - w / 2, y - h / 2, w / 2, h / 2);
    this.northwest = new QuadTree(nw, this.capacity);
    Rectangle se = new Rectangle(x + w / 2, y + h / 2, w / 2, h / 2);
    this.southeast = new QuadTree(se, this.capacity);
    Rectangle sw = new Rectangle(x - w / 2, y + h / 2, w / 2, h / 2);
    this.southwest = new QuadTree(sw, this.capacity);
    this.divided = true;
  }

  boolean insert(Point point) {
    if (!this.boundary.contains(point)) {
      return false;
    }
    if (this.points.size() < this.capacity) {
      this.points.add(point);
      return true;
    } else {
      if (!this.divided) {
        this.subdivide();
      }
      if (this.northeast.insert(point)) {
        return true;
      } else if (this.northwest.insert(point)) {
        return true;
      } else if (this.southeast.insert(point)) {
        return true;
      } else if (this.southwest.insert(point)) {
        return true;
      }
    }
    return false;
  }

  ArrayList<Point> query(Rectangle range) {
    return query(range, null);
  }

  ArrayList<Point> query(Rectangle range, ArrayList<Point> found) {
    if (null == found) {
      found = new ArrayList<Point>();
    }
    if (!this.boundary.intersects(range)) {
      return null;
    } else {
      for (Point p : this.points) {
        if (range.contains(p)) {
          found.add(p);
        }
      }
      if (this.divided) {
        this.northwest.query(range, found);
        this.northeast.query(range, found);
        this.southwest.query(range, found);
        this.southeast.query(range, found);
      }
    }
    return found;
  }


  void show() {
    stroke(255);
    noFill();
    strokeWeight(1);
    rectMode(CENTER);
    rect(this.boundary.x, this.boundary.y, this.boundary.w * 2, this.boundary.h * 2);
    for (Point p : this.points) {
      strokeWeight(2);
      point(p.x, p.y);
    }

    if (this.divided) {
      this.northeast.show();
      this.northwest.show();
      this.southeast.show();
      this.southwest.show();
    }
  }
}
