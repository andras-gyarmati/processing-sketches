Cell[][] grid;
ArrayList<Cell> cells;
int cellSize, cols, rows, centerX, centerY, index, dirIndex, knightX, knightY, stepSizeX, stepSizeY, cellCount;
Cell currentCell;
int[] dir;
int[][] dirs, knightDirs;
ArrayList<PVector> vertices;
boolean isCurved;

void setup() {
  size(1000, 1000);
  surface.setLocation(0, 10);
  strokeWeight(1);
  strokeJoin(ROUND);
  stroke(0);
  noFill();
  //noLoop();
  //frameRate(3);
  cellSize = 10;
  init();
}

void init() {
  stepSizeX = 1;
  stepSizeY = 2;
  cols = width / cellSize;
  rows = height / cellSize;
  cellCount = cols * rows;
  centerX = round(cols / 2.0) - 1;
  centerY = rows / 2;
  knightX = centerX;
  knightY = centerY;
  isCurved = false;
  index = 0;
  dirs = new int[][] {
    new int[]{0, -1}, 
    new int[]{1, 0}, 
    new int[]{0, 1}, 
    new int[]{-1, 0}
  };
  dirIndex = 0;
  dir = dirs[dirIndex];
  knightDirs = new int[][] {
    new int[]{stepSizeX, -stepSizeY}, 
    new int[]{stepSizeY, stepSizeX}, 
    new int[]{-stepSizeX, stepSizeY}, 
    new int[]{-stepSizeY, -stepSizeX}, 
    new int[]{stepSizeX, stepSizeY}, 
    new int[]{stepSizeY, -stepSizeX}, 
    new int[]{-stepSizeX, -stepSizeY}, 
    new int[]{-stepSizeY, stepSizeX}
  };
  vertices = new ArrayList<PVector>();
  grid = new Cell[cols][];
  cells = new ArrayList<Cell>();

  for (int x = 0; x < cols; x++) {
    grid[x] = new Cell[rows];
    for (int y = 0; y < rows; y++) {
      Cell cell = new Cell(x, y);
      if (x == centerX && y == centerY) {
        cell.index = index;
        currentCell = cell;
      }
      cells.add(cell);
      grid[x][y] = cell;
    }
  }

  for (int i = 1; i < cellCount; i++) calcIndices();

  //for (int i = 0; i < 2016; i++) update();
}

void mouseClicked() {
  isCurved = !isCurved;
  redraw();
}

void draw() {
  background(255);
  translate(cellSize / 2, cellSize / 2);
  //translate(width / 2 - mouseX, height / 2 - mouseY);

  beginShape();
  if (isCurved) {
    PVector first = vertices.get(0);
    vertex(first.x, first.y);
  }
  for (int index = 0; index < vertices.size(); index++) {
    PVector v = vertices.get(index);
    if (isCurved)
      curveVertex(v.x + cellSize / 2, v.y + cellSize / 2);
    else
      vertex(v.x + cellSize / 2, v.y + cellSize / 2);
  }
  if (isCurved) {
    PVector last = vertices.get(vertices.size() - 1);
    vertex(last.x, last.y);
  }
  endShape();

  //calcIndices();
  for (Cell cell : cells) cell.debug();
  noFill();

  for (int i = 0; i < 5; i++) update();
}

void update() {
  if (knightX < grid.length && knightX >= 0 && knightY < grid[knightX].length && knightY >= 0) {
    grid[knightX][knightY].isUsed = true;
    vertices.add(new PVector(knightX * cellSize, knightY * cellSize));
    int nextKnightX = 0;
    int nextKnightY = 0;
    int nextX, nextY;
    int smallest = cellCount;
    for (int[] kdir : knightDirs) {
      nextX = knightX + kdir[0];
      nextY = knightY + kdir[1];
      if (nextX < grid.length && nextX >= 0 && nextY < grid[nextX].length && nextY >= 0) {
        Cell step = grid[nextX][nextY];
        if (step != null && step.index < smallest && !step.isUsed) {
          nextKnightX = nextX;
          nextKnightY = nextY;
          smallest = step.index;
        }
      }
    }
    knightX = nextKnightX;
    knightY = nextKnightY;
  }
}

void calcIndices() {
  int nextX = currentCell.x + dir[0];
  int nextY = currentCell.y + dir[1];
  if (nextX < grid.length && nextX >= 0 && nextY < grid[nextX].length && nextY >= 0) {
    currentCell = grid[nextX][nextY];
    index++;
    currentCell.index = index;
    int neighborCount = 0;
    for (int x = -1; x <= 1; x++) {
      for (int y = -1; y <= 1; y++) {
        int neighborX = nextX + x;
        int neighborY = nextY + y;
        if (neighborX >= grid.length || neighborX < 0 || neighborY >= grid[neighborX].length || neighborY < 0) {
          neighborCount++;
        } else {
          Cell neighborCell = grid[neighborX][neighborY];
          if (!(x == 0 && y == 0) && neighborCell.index < 0) {
            neighborCount++;
          }
        }
      }
    }
    if (neighborCount > 5) {
      dirIndex++;
      if (dirIndex > 3) dirIndex = 0;
      dir = dirs[dirIndex];
    }
  }
}

class Cell {
  int x, y;
  int index;
  boolean isUsed;

  Cell(int x, int y) {
    this.x = x;
    this.y = y;
    this.index = -1;
    this.isUsed = false;
  }

  void debug() {
    fill(0);
    textSize(cellSize / 3);
    text(index, this.x * cellSize, this.y * cellSize);
    //ellipse(this.x * cellSize, this.y * cellSize, 3, 3);
  }
}
