class Cell {

  float x, y;
  float cellWidth;
  Team team;
  int nextState;
  int state;

  Cell(float x_, float y_, float cellWidth_, Team team_) {
    x = x_;
    y = y_;
    cellWidth = cellWidth_;
    team = team_;
  }

  void loadNextState() {
    state = nextState;
  }

  void newNextState(int s) {
    nextState = s;
  }

  int indicatorShrinkRate = 10;
  void display() {
    if (state == 1) {
      fill(team.teamColor, 255, 255);
    } else {
      fill(team.teamColor, 0, 50);
    }
    stroke(0);
    strokeWeight(5);
    rect(x, y, cellWidth, cellWidth);

    if (nextState == 1) {
      fill(team.teamColor, 255, 255);
    } else {
      fill(team.teamColor, 0, 50);
    }
    noStroke();
    rect(x + (cellWidth - cellWidth / indicatorShrinkRate) / 2, 
    y + (cellWidth - cellWidth / indicatorShrinkRate) / 2, 
    cellWidth / indicatorShrinkRate, cellWidth / indicatorShrinkRate);
  }
}