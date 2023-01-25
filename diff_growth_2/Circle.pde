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
