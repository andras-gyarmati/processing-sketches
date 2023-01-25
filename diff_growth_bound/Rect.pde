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
