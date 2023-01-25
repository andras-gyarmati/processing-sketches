class QuadTree {
  QuadTree nw;
  QuadTree ne;
  QuadTree sw;
  QuadTree se;
  Rect bound;
  ArrayList<PVector> points;
  boolean isDivided;
  int treeNodePointCount;

  QuadTree(Rect bound) {
    this.treeNodePointCount = 4;
    this.bound = bound;
    this.isDivided = false;
    this.points = new ArrayList<PVector>();
  }

  void add(PVector p) {
    if (this.points.size() < this.treeNodePointCount) {
      this.points.add(p);
    } else {
      if (!this.isDivided) {
        float cx = this.bound.cx;
        float cy = this.bound.cy;
        float hhw = this.bound.hw / 2;
        float hhh = this.bound.hh / 2;
        this.nw = new QuadTree(new Rect(cx - hhw, cy - hhh, hhw, hhh));
        this.ne = new QuadTree(new Rect(cx + hhw, cy - hhh, hhw, hhh));
        this.sw = new QuadTree(new Rect(cx - hhw, cy + hhh, hhw, hhh));
        this.se = new QuadTree(new Rect(cx + hhw, cy + hhh, hhw, hhh));
        this.isDivided = true;
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

  ArrayList<PVector> get(Circle c, ArrayList<PVector> array) {
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
      if (this.isDivided) {
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
    if (this.isDivided) {
      this.nw.show();
      this.ne.show();
      this.sw.show();
      this.se.show();
    }
  }
}
