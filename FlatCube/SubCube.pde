class SubCube {
  int[] sides;

  SubCube() {
    sides = new int[6];
  }

  void init() {
    for (int i = 0; i < sides.length; i++) {
      sides[i]  = i;
    }
  }

  void rotateX() {
    int tmp = sides[1];
    sides[1] = sides[4];
    sides[4] = sides[3];
    sides[3] = sides[5];
    sides[5] = tmp;
  }
  
  void rotateY() {
    int tmp = sides[3];
    for (int i = 3; i > 0; i++) {
      sides[i] = sides[i - 1];
    }
    sides[0] = tmp;
  }
  
  void rotateZ() {
    int tmp = sides[5];
    sides[5] = sides[0];
    sides[0] = sides[4];
    sides[4] = sides[2];
    sides[2] = tmp;
  }
}