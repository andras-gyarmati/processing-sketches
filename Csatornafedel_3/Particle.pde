class Particle {
  PVector position;
  float rotation;

  Particle(PVector position) {
    this.position = position;
    update();
  }

  void update() {
    this.rotation = this.position.dist(center);
    
    float x1 = this.position.x;
    float y1 = this.position.y;
    float x2 = up.x;
    float y2 = up.y;
    this.rotation += atan2(x1*y2-y1*x2, x1*x2+y1*y2);
  }

  void display() {
    PVector halfLine = new PVector(0, circleDistance * lineLengthMultiplier / 2);
    halfLine.rotate(this.rotation);
    PVector lineStart = this.position.copy().sub(halfLine);
    PVector lineEnd = this.position.copy().add(halfLine);
    line(lineStart.x, lineStart.y, lineEnd.x, lineEnd.y);
  }
}
