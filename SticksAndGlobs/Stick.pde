class Stick implements Displayable {
  PVector startPos, endPos;

  Stick(PVector startPos, PVector endPos) {
    this.startPos = startPos;
    this.endPos = endPos;
  }

  void update() {
  }
  
  void display() {
    fill(255);
    stroke(255);
    strokeWeight(2);
    line(startPos.x, startPos.y, endPos.x, endPos.y);
  }
}
