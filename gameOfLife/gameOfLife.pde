int density;
int cols;
int rows;
int hue;
boolean canDecide;
Cell[][] grid;
Cell[][] next;

void setup() {
  size(640, 480);
  //fullScreen(1);
  background(0);
  colorMode(HSB);
  density = 20;
  cols = width / density;
  rows = height / density;
  hue = 0;
  canDecide = false;
  grid = new Cell[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j] = new Cell(i * density, j * density, density, density, 0, false);
    }
  }
}

void draw() {
  next = grid.clone();
  clear();
  for (int i = 1; i < cols - 1; i++) {
    for (int j = 1; j < rows - 1; j++) {
      if (canDecide) {
        decide(i, j);
      }
      next[i][j].display();
    }
  }
  //fill(hue, 255, 255);
  //ellipse(mouseX, mouseY, sqrt(max(mouseX, mouseY)), sqrt(max(mouseX, mouseY)));
  //hue++;
  //if (hue > 255) {
  //  hue = 0;
  //}
  delay(0);
  grid = next.clone();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    grid[mouseX / density][mouseY / density].changeState();
  } else if (mouseButton == RIGHT) {
    canDecide = !canDecide;
  }
}

void decide(int col, int row) {
  int neighboursCount= getNeighborsCount(col, row);
  if (grid[col][row].alive) {
    if (neighboursCount < 2 || neighboursCount > 3) {
      next[col][row].changeState();
    }
  } else if (neighboursCount == 3) {
    next[col][row].changeState();
  }
}

int getNeighborsCount(int col, int row) {
  int count = 0; //<>//
  for (int i = col - 1; i < col + 1; i++) {
    for (int j = row - 1; j < row + 1; j++) {
      if (i != col || j != row) {
        if (grid[i][j].alive) {
          count++;
        }
      }
    }
  }
  return count;
}