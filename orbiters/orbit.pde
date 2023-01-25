class Orbit {
  PVector pos, kPos;
  float padding;

  Orbit(PVector pos) {
    this.pos = pos;
    padding = scaler*0.5;
    kPos = new PVector(0, -scaler);
  }

  void update() {
    kPos.rotate(0.3+PVector.dist(center, pos)/5000);
  }

  void display() {
    strokeWeight(1);
    stroke(0);
    noFill();
    pushMatrix();
    translate(pos.x, pos.y);
    //ellipse(0, 0, scaler*2, scaler*2);
    fill(0);
    ellipse(kPos.x, kPos.y, padding, padding);
    popMatrix();
  }
}
