float scale;
int cols;
int rows;
Grid grid;

void setup() {
  size(600, 600);
  scale = 20;
  cols = floor(width/scale);
  rows = floor(height/scale);
  grid = new Grid(cols, rows);
  frameRate(1);
}

void draw() {
  grid.update();
  grid.display();
}

class Cell {
  PVector pos;
  float size;
  boolean state;

  Cell(PVector pos, float size, boolean state) {
    this.pos = pos;
    this.size = size;
    this.state = state;//random(1) > 0.5 ? true : false;
  }

  void update() {
    //
  }

  void display() {
    //noStroke();
    fill(state ? 200 : 20);
    rect(pos.x, pos.y, size, size);
  }
}

class Grid {
  Cell[][] cells;
  Cell[][] nextCells;

  Grid(int cols, int rows) {
    cells = new Cell[cols][rows];
    nextCells = new Cell[cols][rows];
    init();
  }

  void init() {
    for (int i = 0; i < cells.length; i++) {
      for (int j = 0; j < cells[0].length; j++) {
        boolean state = false;
        cells[i][j] = new Cell(new PVector(scale * i, scale * j), scale, state);
      }
    }
    //cells[10][10].state = true;
    cells[11][10].state = true;
    cells[11][9].state = true;
    cells[11][11].state = true;
    //cells[12][9].state = true;
  }

  void update() {
    for (int i = 0; i < cells.length; i++) {
      for (int j = 0; j < cells[0].length; j++) {
        nextCells[i][j] = calcNext(i, j);
      }
    }
    cells = nextCells;
  }

  //Cell calcNext(int i, int j) {
  //  Cell c = new Cell(cells[i][j].pos, scale, false);
  //  Cell cc = cells[i][j];
  //  boolean state = cc.state;
  //  int window = 1;
  //  for (int x = -window; x <= window; x++) {
  //    for (int y = -window; y <= window; y++) {
  //      try {
  //        state ^= cells[i + x][j + y].state;
  //      } 
  //      catch (Exception e) {
  //      }
  //    }
  //  }
  //  c.state = state;
  //  return c;
  //}

  Cell calcNext(int i, int j) {
    Cell cc = cells[i][j];
    Cell c = new Cell(cc.pos, scale, cc.state);
    int neighbors = 0;
    int window = 1;
    for (int x = -window; x <= window; x++) {
      for (int y = -window; y <= window; y++) {
        try {
          if (!(0 == x && 0 == y)) {          
            neighbors += cells[i + x][j + y].state ? 1 : 0;
          }
        } 
        catch (Exception e) {
        }
      }
    }

    c.state = cc.state ? !(neighbors > 3 || neighbors < 2) : (neighbors == 3);
    return c;
  }

  void display() {
    for (Cell[] ca : cells) {
      for (Cell c : ca) {
        c.display();
      }
    }
  }
}
