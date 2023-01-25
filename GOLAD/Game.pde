class GOL {

  int cellWidth = 60;
  int columns, rows;
  Team currentTeam;
  boolean ended;
  Team red;
  Team blue;
  int redSum;
  int blueSum;
  int redNeighbors;
  int blueNeighbors;
  Cell[][] board;

  GOL() {
    columns = height / cellWidth;
    rows = height / cellWidth;
    currentTeam = new Team(-1);
    board = new Cell[columns][rows];
    ended = false;
    red = new Team(248);
    blue = new Team(158);
    redSum = 0;
    blueSum = 0;
    redNeighbors = 0;
    blueNeighbors = 0;
    init();
  }

  void init() {
    for (int i = 0; i < columns; i++) {
      for (int j = 0; j < rows; j++) {
        board[i][j] = new Cell(i * cellWidth, j * cellWidth, cellWidth, currentTeam);
        if (i < columns / 2) {
          if (round(random(2)) == 1) {
            board[i][j].nextState = 1;
            board[i][j].team = round(random(2)) == 1 ? red : blue;
          }
        } else {
          board[i][j].nextState = board[board.length - 1 - i][board[0].length - 1 - j].nextState;
          board[i][j].team = board[board.length - 1 - i][board[0].length - 1 - j].team == blue ? red : blue;
        }
      }
    }
  }

  void generate() {
    loadNextState();
    countNeighbors();
    scoreBoard();
  }

  void loadNextState() {
    redSum = 0;
    blueSum = 0;
    for ( int i = 0; i < columns; i++) {
      for ( int j = 0; j < rows; j++) {
        board[i][j].loadNextState();
        if (board[i][j].team == red) { 
          redSum += board[i][j].state;
        } else if (board[i][j].team == blue) {
          blueSum += board[i][j].state;
        }
      }
    }
  }

  void countNeighbors() {
    for (int x = 0; x < columns; x++) {
      for (int y = 0; y < rows; y++) {
        redNeighbors = 0;
        blueNeighbors = 0;
        for (int i = max(0, x - 1); i <= min(board.length - 1, x + 1); i++) {
          for (int j = max(0, y - 1); j <= min(board[0].length - 1, y + 1); j++) {
            Cell neighbor = board[i][j];
            if (neighbor.state == 1) {
              if (neighbor.team == red) {
                redNeighbors++;
              } else if (neighbor.team == blue) {
                blueNeighbors++;
              }
            }
          }
        }
        calculateNextState(x, y);
      }
    }
  } 

  void calculateNextState(int x, int y) {
    if (board[x][y].team == red) { 
      redNeighbors -= board[x][y].state;
    } else if (board[x][y].team == blue) {
      blueNeighbors -= board[x][y].state;
    }
    int neighbors = redNeighbors + blueNeighbors;

    if ((board[x][y].nextState == 1) && (neighbors <  2)) { 
      board[x][y].newNextState(0);
    } else if ((board[x][y].nextState == 1) && (neighbors >  3)) { 
      board[x][y].newNextState(0);
    } else if ((board[x][y].nextState == 0) && (neighbors == 3)) { 
      board[x][y].newNextState(1);
      if (redNeighbors > blueNeighbors) {
        board[x][y].team = red;
      } else {
        board[x][y].team = blue;
      }
    }
  }

  void  scoreBoard() {
    textSize(20);
    noStroke();
    strokeWeight(1);
    if (redSum > blueSum) { 
      stroke(255);
    } else {
      noStroke();
    }
    fill(red.teamColor, 255, 255);
    text("red: " + redSum, 510, 40);
    if (blueSum == 0 && redSum > 0) { 
      text("red won", 510, 120);
      ended = true;
    }

    if (redSum < blueSum) { 
      stroke(255);
    } else {
      noStroke();
    }
    fill(blue.teamColor, 255, 255);
    text("blue: " + blueSum, 510, 80);

    if (redSum == 0 && blueSum > 0) { 
      text("blue won", 510, 120);
      ended = true;
    }

    if (redSum == 0 && blueSum == 0) { 
      fill(red.teamColor, 0, 255); 
      text("draw", 510, 120);
      ended = true;
    }
    fill(255);
    if (ended) {
      text("ended", 510, 160);
    }
  }

  void displayCells() {
    for ( int i = 0; i < columns; i++) {
      for ( int j = 0; j < rows; j++) {
        board[i][j].display();
      }
    }
  }

  void kill() {
    for (int x = 0; x < columns; x++) {
      for (int y = 0; y < rows; y++) {
        board[x][y].nextState = 0;
        board[x][y].state = 0;
      }
    }
  }

  void mousePressed() {
    int x = floor(mouseX / cellWidth);
    int y = floor(mouseY / cellWidth);
    if (mouseButton == LEFT) {
      if (board[x][y].state == 1) {
        if (currentTeam == board[x][y].team) {
          board[x][y].newNextState(board[x][y].nextState == 0 ? 1 : 0);
        } else {
        }
      } else {
        board[x][y].team = currentTeam;
      }
    } else if (mouseButton == RIGHT) {
    }
  }
}