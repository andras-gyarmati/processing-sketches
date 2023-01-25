class QuadTree { //<>//
  Rectangle boundary;
  int capacity;
  ArrayList<Ball> balls;
  boolean divided;
  QuadTree northeast, northwest, southeast, southwest;

  QuadTree(Rectangle boundary, int n) {
    this.boundary = boundary;
    this.capacity = n;
    this.balls = new ArrayList<Ball>();
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

  boolean insert(Ball ball) {
    if (!this.boundary.contains(ball)) {
      return false;
    }
    if (this.balls.size() < this.capacity) {
      this.balls.add(ball);
      return true;
    } else {
      if (!this.divided) {
        this.subdivide();
      }
      if (this.northeast.insert(ball)) {
        return true;
      } else if (this.northwest.insert(ball)) {
        return true;
      } else if (this.southeast.insert(ball)) {
        return true;
      } else if (this.southwest.insert(ball)) {
        return true;
      }
    }
    return false;
  }

  ArrayList<Ball> query(Rectangle range) {
    return query(range, null);
  }

  ArrayList<Ball> query(Rectangle range, ArrayList<Ball> found) {
    if (null == found) {
      found = new ArrayList<Ball>();
    }
    if (!this.boundary.intersects(range)) {
      return null;
    } else {
      for (Ball b : this.balls) {
        if (range.contains(b)) {
          found.add(b);
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


  ArrayList<Ball> cutAllBalls() {
    return cutAllBalls(null);
  }

  ArrayList<Ball> cutAllBalls(ArrayList<Ball> allBalls) {
    if (null == allBalls) {
      allBalls = new ArrayList<Ball>();
    }

    for (int i = this.balls.size()-1; i >= 0; i--) {
      Ball b = this.balls.get(i);
      allBalls.add(b);
      this.balls.remove(b);
    }
    if (this.divided) {
      this.northwest.cutAllBalls(allBalls);
      this.northeast.cutAllBalls(allBalls);
      this.southwest.cutAllBalls(allBalls);
      this.southeast.cutAllBalls(allBalls);
    }
    return allBalls;
  }

  void displayBalls() {
    for (Ball b : this.balls) {
      b.display();
    }
    if (this.divided) {
      this.northeast.displayBalls();
      this.northwest.displayBalls();
      this.southeast.displayBalls();
      this.southwest.displayBalls();
    }
  }

  ArrayList<Ball> updateBalls() {
    ArrayList<Ball> newBalls = new ArrayList<Ball>();
    for (int i = this.balls.size()-1; i >= 0; i--) {
      Ball b = this.balls.get(i);
      ArrayList<Ball> newPiecesAfterExpolion = b.update();
      if (null != newPiecesAfterExpolion && newPiecesAfterExpolion.size() > 0) {
        for (Ball nb : newPiecesAfterExpolion) {
          newBalls.add(nb);
        }
        this.balls.remove(b);
      }
    }
    if (this.divided) {
      this.northeast.updateBalls();
      this.northwest.updateBalls();
      this.southeast.updateBalls();
      this.southwest.updateBalls();
    }
    return newBalls;
  }

  void showBoundary() {
    stroke(255);
    noFill();
    strokeWeight(2);
    rectMode(CENTER);
    rect(this.boundary.x, this.boundary.y, this.boundary.w * 2, this.boundary.h * 2);
    if (this.divided) {
      this.northeast.showBoundary();
      this.northwest.showBoundary();
      this.southeast.showBoundary();
      this.southwest.showBoundary();
    }
  }
}
