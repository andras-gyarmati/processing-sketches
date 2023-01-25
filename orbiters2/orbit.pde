class Orbit {
  PVector pos, kPos;
  float kSize;

  Orbit(PVector pos) {
    this.pos = pos;
    kSize = 30;
    kPos = new PVector(0, -scaler);
    kPos.rotate((pos.x + pos.y)*0.292);
  }

  void update() {
    kPos.rotate(-0.07);
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    noStroke();
    fill(23, 43, 231, 40);
    ellipse(kPos.x, kPos.y, kSize, kSize);
    popMatrix();
  }
}
