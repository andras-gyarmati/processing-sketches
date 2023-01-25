class Cube {
  SubCube[][][] structure;  
  int front, back, left, right, up, down;

  Cube() {
    structure = new SubCube[3][3][3];
    front = 1;
    back = 3;
    left = 0;
    right = 2;
    up = 5;
    down = 4;
    init();
  }

  void init() {
    for (int i = 0; i < structure.length; i++) {
      for (int j = 0; j < structure[0].length; j++) {
        for (int k = 0; k < structure[0][0].length; k++) {
          structure[i][j][k] = new SubCube();
        }
      }
    }
  }

  void display2D(float size) {
    int padding = 1;
    for (int i = 0; i < structure.length; i++) {
      for (int j = 0; j < structure[0].length; j++) {
        for (int k = 0; k < structure[0][0].length; k++) {
          if (i == 0) { 
            fill(map(structure[i][j][k].sides[up], 0, structure[0][0][k].sides.length - 1, 0, 255), 255, 255);
            rect((up + j) * size + padding, k * size + padding, size - padding * 2, size - padding * 2);
          } else if (i == 2) { 
            fill(map(structure[i][j][k].sides[down], 0, structure[0][0][k].sides.length - 1, 0, 255), 255, 255);
            rect((down + j) * size + padding, k * size + padding, size - padding * 2, size - padding * 2);
          } else if (j == 0) { 
            fill(map(structure[i][j][k].sides[left], 0, structure[0][0][k].sides.length - 1, 0, 255), 255, 255);
            rect((left + i) * size + padding, k * size + padding, size - padding * 2, size - padding * 2);
          } else if (j == 2) { 
            fill(map(structure[i][j][k].sides[right], 0, structure[0][0][k].sides.length - 1, 0, 255), 255, 255);
            rect((right + i) * size + padding, k * size + padding, size - padding * 2, size - padding * 2);
          } else if (k == 0) { 
            fill(map(structure[i][j][k].sides[back], 0, structure[0][0][k].sides.length - 1, 0, 255), 255, 255);
            rect((back + i) * size + padding, j * size + padding, size - padding * 2, size - padding * 2);
          } else if (k == 2) { 
            fill(map(structure[i][j][k].sides[front], 0, structure[0][0][k].sides.length - 1, 0, 255), 255, 255);
            rect((front + i) * size + padding, j * size + padding, size - padding * 2, size - padding * 2);
          }
        }
      }
    }
  }

  void frontCW() {
  }
}