// differential growth cellular automata //<>//

int cellSize, cols, rows;
Cell[][] grid;
ArrayList<Cell> cells;

void setup() {
  size(1000, 1000);
  surface.setLocation(10, 10);
  fill(0);
  noStroke();
  frameRate(2);
  noLoop();

  cellSize = 5;
  cols = width / cellSize;
  rows = height / cellSize;
  grid = new Cell[cols][rows];
  cells = new ArrayList<Cell>();
  init();
}

void mouseClicked() {
  redraw();
}

void init() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j] = new Cell(i, j);
      // the general equation for a circle is (x - h)^2 + (y - k)^2 = r^2
      // where (h, k) is the center and r is the radius
      float x = i * cellSize;
      float y = j * cellSize;
      float h = width / 2f;
      float k = height / 2f;
      float r = 100;
      float epsilon = 500; // something is wrong, this is too big(?)
      if (abs(pow(r, 2) - (pow(x - h, 2) + pow(y - k, 2))) < epsilon) {
        grid[i][j].isAlive = true;
        cells.add(grid[i][j]);
      }
    }
  }
}

void draw() {
  background(255);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (grid[i][j].isAlive) {
        rect(i * cellSize, j * cellSize, cellSize, cellSize);
      }
    }
  }
  update();
}

// mindegyik elo cellara megkeresni a legkozelebbi szomszedot ha nincs a kozvetlen kozeleben
// akkor addig menni arrafele fel vagy jobbra eppen amelyikkel messzebb vagyunk hogy
// mindegyiknek ket szomszedja legyen 

Cell findClosest(Cell c) {
  int x = 0;
  int y = 0;
  boolean isVert = true;
  Cell n = null;
  while (n == null || !n.isAlive) {
    if (isVert) {
      if (x <= 0) {
        y -= 1;
      } else {
        y += 1;
      }
    } else {
      if (y <= 0) {
        x += 1;
      } else {
        x -= 1;
      }
    }

    boolean topLeft = x <= 0 && y <= 0;
    boolean change = x - 1 == y;
    if (topLeft && change) {
      isVert = !isVert;
    }

    if (!topLeft && abs(x) == abs(y)) {
      isVert = !isVert;
    }

    n = grid[c.x + x][c.y + y];
  }

  return n;
}

void update() {
  //for (int k = cells.size() - 1; k >= 0; k--) {
  //  Cell c = cells.get(k);
  //  Cell cl = findClosest(c);
  //  //bridge the gap
  //  ;
  //}

  Cell[][] prev = new Cell[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      Cell n = new Cell(i, j);
      prev[i][j] = n;
      n.isAlive = grid[i][j].isAlive;
    }
  }

  for (int k = cells.size() - 1; k >= 0; k--) {
    Cell c = cells.get(k);
    int x = 0;
    int y = 0;
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        if (prev[c.x + i][c.y + j].isAlive) {
          x -= i;
          y -= j;
        }
      }
    }

    x = x < 0 ? -1 : x > 0 ? 1 : 0;
    y = y < 0 ? -1 : y > 0 ? 1 : 0;

    if (x != 0 || y != 0) {
      c.isAlive = false;
      cells.remove(c);
      Cell n = grid[c.x + x][c.y + y];
      n.isAlive = true;
      cells.add(n);
    }
  }
}

class Cell {
  int x, y;
  boolean isAlive;

  Cell(int x, int y) {
    this.x = x;
    this.y = y;
    this.isAlive = false;
  }
}
