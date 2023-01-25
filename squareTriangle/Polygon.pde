class Polygon {
  ArrayList<PVector> ps;
  PVector pos;
  float rotation;

  Polygon(int angleCount, float diameter) {
    ps = new ArrayList<PVector>();
    ps.add(new PVector(0, diameter / 2));
    for (int i = 0; i < angleCount - 1; i++) {
          ps.add(ps.get(ps.size() - 1).copy().rotate(TWO_PI / angleCount));
    }
    pos = new PVector(0, 0);
    rotation = 0;
  }

  void display() {
    stroke(200);
    noFill();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rotation);
    beginShape();
    for (PVector p : ps) {
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
    popMatrix();
  }
}
