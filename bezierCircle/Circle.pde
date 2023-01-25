class Circle {
  ArrayList<ArrayList<PVector>> circleSegments = new ArrayList<ArrayList<PVector>>();
  float size;
  int handleSize;

  Circle(float size, int segments) {
    this.size = size;
    this.handleSize = 10;
    PVector initialPoint = new PVector(0, -size);
    for (int segmentNo = 0; segmentNo < max(min(segments, 360), 1); segmentNo++) {
      ArrayList<PVector> segment = new ArrayList<PVector>();
      PVector cp2 = initialPoint.copy().rotate(TWO_PI / (segments * 12) * ((segmentNo * 12) + 8.36)).mult(0.36);
      PVector cp1 = initialPoint.copy().rotate(TWO_PI / (segments * 12) * ((segmentNo * 12) + 3.64)).mult(0.36);
      PVector p = initialPoint.copy().rotate(TWO_PI / segments * segmentNo);
      segment.add(cp2);
      segment.add(cp1);
      segment.add(p);
      circleSegments.add(segment);
    }
  }

  void display() {
    stroke(255, 0, 0, 144);
    ArrayList<PVector> segment;
    ArrayList<PVector> next;
    for (int i = 0; i < circleSegments.size() - 1; i++) {
      segment = circleSegments.get(i);
      next = circleSegments.get(i + 1);
      ellipse(segment.get(0).x, segment.get(0).y, handleSize, handleSize);
      ellipse(segment.get(1).x, segment.get(1).y, handleSize, handleSize);
      line(next.get(2).x, next.get(2).y, segment.get(0).x, segment.get(0).y);
      line(segment.get(2).x, segment.get(2).y, segment.get(1).x, segment.get(1).y);
    }    

    segment = circleSegments.get(circleSegments.size() - 1);
    next = circleSegments.get(0);
    ellipse(segment.get(0).x, segment.get(0).y, handleSize, handleSize);
    ellipse(segment.get(1).x, segment.get(1).y, handleSize, handleSize);
    line(next.get(2).x, next.get(2).y, segment.get(0).x, segment.get(0).y);
    line(segment.get(2).x, segment.get(2).y, segment.get(1).x, segment.get(1).y);

    ellipse(0, 0, 2, 2); //debug
    stroke(255, 0, 0, 144); //debug
    ellipse(0, 0, size * 2, size * 2); //debug
    stroke(0);
    noFill();
    beginShape();
    vertex(circleSegments.get(circleSegments.size() - 1).get(2).x, circleSegments.get(circleSegments.size() - 1).get(2).y);
    for (ArrayList<PVector> s : circleSegments) {
      bezierVertex(b(s.get(0).x), b(s.get(0).y), b(s.get(1).x), b(s.get(1).y), s.get(2).x, s.get(2).y);
    }
    endShape();
  }

  float b(float scale) {
    return size * scale / 100f;
  }

  void mouseDragged_(float x, float y) {
    for (ArrayList<PVector> segment : circleSegments) {
      if (PVector.dist(segment.get(0), new PVector(x, y)) < 10) {
        segment.get(0).set(x, y);
        return;
      } else if (PVector.dist(segment.get(1), new PVector(x, y)) < 10) {
        segment.get(1).set(x, y);
        return;
      }
    }
  }
}
//IDEA: start the controllpoints from their anchorpoints?
//IDEA: create a segment class
