class Shape {
  Side[] sides;

  Shape(PVector p1, PVector p2, int sideCount) {
    this.sides = new Side[sideCount];
    PVector vec = PVector.sub(p2, p1);
    for (int i = 0; i < sideCount; i++) {
      sides[i] = new Side(copyVector(p1), copyVector(p2));
      p1.add(vec);
      vec.rotate(TWO_PI / sideCount);
      p2.add(vec);
    }
  }

  void display() {
    for (Side side : sides) {
      side.display();
    }
  }
}
