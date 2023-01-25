class Slider {

  PVector startPos;
  PVector endPos;
  PVector knobPos;
  int knobSize;

  Slider (int posX, int posY, int sLength, int knobSize) {
    startPos = new PVector(posX, posY);
    endPos = new PVector(posX + sLength, posY);
    knobPos = new PVector(posX, posY);
    this.knobSize = knobSize;
  }

  void display() {
    stroke(0);
    strokeWeight(5);
    line(startPos.x, startPos.y, endPos.x, endPos.y);
    fill(0);
    noStroke();
    ellipse(knobPos.x, knobPos.y, knobSize, knobSize);
    text(map(knobPos.x, startPos.x, endPos.x, 1, 1500), knobPos.x - 30, startPos.y - 20);
  }

  float getValue() {
    return map(knobPos.x, startPos.x, endPos.x, 1, 1500);
  }

  void update(PVector pos) {
    if (pos.x >= startPos.x && pos.x <= endPos.x && isPointInknob(pos)) {
      knobPos.x = pos.x;
    }
  }

  boolean isPointInknob(PVector p) {
    return p.dist(knobPos) <= knobSize * 3;
  }
}