class Ring {
  float radius;
  int detail;
  float diff;
  float ringColor;

  Ring(float ringColor, float radius, int detail) {
    this.radius = radius;
    this.detail = detail;
    this.ringColor = ringColor;
  }

  void display() {
    stroke(ringColor, 255, 255);
    beginShape();
    for (int i = 0; i < detail; i++) {
      float r = radius + sin(diff) * 10;
      float x = r * cos(radians(i * 360 / detail));
      float y = r * sin(radians(i * 360 / detail));
      curveVertex(x, y);
      diff += 0.34809; //0.34811
    }
    endShape(CLOSE);
  }
}
