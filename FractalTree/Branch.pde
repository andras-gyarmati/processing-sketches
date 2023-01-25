class Branch {
  PVector start, end;
  float thickness;
  ArrayList<Branch> subBranches;
  int level;

  Branch(PVector start, PVector end, float thickness, int level) {
    this.start = start;
    this.end = end;
    this.thickness = thickness;
    this.level = level + 1;
    subBranches = new ArrayList<Branch>();
  }

  void grow() {
    if (level <= maxLevels) {
      for (int i = 0; i < random(maxBranches); i++) {
        subBranches.add(new Branch(this.end, PVector.add(PVector.fromAngle(radians(i*(60/maxBranches)+240)).mult(1/(level+3)+70), this.end), thickness /*- thickness / maxLevels*/, level+1));
      }
      for (Branch b : subBranches) {
        b.grow();
      }
    }
  }

  void display() {
    strokeWeight(thickness);
    line(start.x, start.y, end.x, end.y);
    for (Branch b : subBranches) {
      b.display();
    }
  }
}