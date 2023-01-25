class GOL { //<>//

  int w = 16;
  int columns, rows;
  boolean isTurnedOn;
  final boolean alive = true;
  final boolean dead = false;

  Cell[][] board;


  GOL() {
    columns = width / w;
    rows = height / w;
    isTurnedOn = false;
    board = new Cell[columns][rows];
    init();
  }

  void init() {
    for (int i = 0; i < columns; i++) {
      for (int j = 0; j < rows; j++) {
        board[i][j] = new Cell(new PVector(i * w, j * w), w);
      }
    }
    //addGosperGliderGun(0, 0);
  }

  void addGosperGliderGun(int x, int y) {
    int[][] array = { {0, 4}, {1, 4}, {0, 5}, {1, 5}, {10, 4}, {10, 5}, {10, 6}, 
      {11, 3}, {11, 7}, {12, 2}, {12, 8}, {13, 2}, {13, 8}, {14, 5}, {15, 3}, 
      {15, 7}, {16, 4}, {16, 5}, {16, 6}, {17, 5}, {20, 4}, {20, 3}, {20, 2}, 
      {21, 4}, {21, 3}, {21, 2}, {22, 1}, {22, 5}, {24, 0}, {24, 1}, {24, 5}, 
      {24, 6}, {34, 2}, {34, 3}, {35, 2}, {35, 3} };
    for (int[] pos : array) {
      board[pos[0] + x][pos[1] + y].newState(alive);
    }
  }

  void generate() {
    if (isTurnedOn) {
      for ( int i = 0; i < columns; i++) {
        for ( int j = 0; j < rows; j++) {
          board[i][j].savePrevious();
        }
      }

      for (int x = 0; x < columns; x++) {
        for (int y = 0; y < rows; y++) {

          int neighbors = 0;
          for (int i = -1; i <= 1; i++) {
            for (int j = -1; j <= 1; j++) {
              neighbors += board[(x+i+columns)%columns][(y+j+rows)%rows].previous ? 1 : 0;
            }
          }

          neighbors -= board[x][y].previous ? 1 : 0;

          //if      ((board[x][y].state == 1) && (neighbors <  2)) board[x][y].newState(0);          
          //else if ((board[x][y].state == 1) && (neighbors >  3)) board[x][y].newState(0);          
          //else if ((board[x][y].state == 0) && (neighbors == 3)) board[x][y].newState(1);

          boolean ns = board[x][y].state ? !(neighbors > 3 || neighbors < 2) : (neighbors == 3); //<>//
          board[x][y].newState(ns);
        }
      }
    }
  }

  void display() {
    for ( int i = 0; i < columns; i++) {
      for ( int j = 0; j < rows; j++) {
        board[i][j].display();
      }
    }
  }

  void kill() {
    isTurnedOn = false;
    int count = 0;
    for (int x = 0; x < columns; x++) {
      for (int y = 0; y < rows; y++) {
        if (board[x][y].state) {
          count++;
          board[x][y].state = dead;
        }
      }
    }
    if (count == 0) {
      for (int x = 0; x < columns; x++) {
        for (int y = 0; y < rows; y++) {
          board[x][y].age = 0 ;
        }
      }
    }
  }

  void mousePressed() {
    if (mouseButton == LEFT) {
      Cell c = board[mouseX / w][mouseY / w];
      c.newState(!c.state);
    } else if (mouseButton == RIGHT) {
      isTurnedOn = !isTurnedOn;
    } else {
      kill();
    }
  }
}
