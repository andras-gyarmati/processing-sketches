class Glob implements Displayable {
  PVector pos;
  float size;

  Glob(PVector pos) {
    this.pos = pos;
    size = 10;
  }
  
  void update() {
  }
  
  void display() {
    noStroke();
    fill(255);
    ellipse(pos.x, pos.y, size, size);
  }
}
