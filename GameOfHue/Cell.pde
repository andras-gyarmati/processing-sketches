class Cell {

  PVector pos;
  float w;
  float age;
  boolean state, previous;

  Cell(PVector pos, float w) {
    this.pos = pos;
    this.w = w;
    age = 0;
    state = false;
    previous = state;
  }

  void savePrevious() {
    previous = state;
  }

  void newState(boolean s) {
    if (state == s) return;
    state = s;
    age++;
    if (age > 255) {
      age = 0;
    }
  }

  void display() {
    stroke(0);
    if (state) {
      fill(age, 255, 255);
    } else {
      fill(age, 255, 40);
    }
    rect(pos.x, pos.y, w, w);
  }
}
