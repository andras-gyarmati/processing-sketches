ArrayList<Shape> shapes;
float size;
int margin;
PVector center;

void setup() {
  size(1000, 1000);
  surface.setLocation(10, 10);
  smooth(8);
  size = 8;
  margin = 200;
  shapes = new ArrayList<Shape>();
  center = new PVector(width / 2, height / 3);
  shapes.add(new Shape(new PVector(width / 2 - size, height / 2 - size), 
    new PVector(width / 2 + size, height / 2 + size), 3));
  strokeWeight(size / 2);
  // frameRate(30);
  background(255);
}

void draw() {
  //background(250);
  stroke(255, 50, 50);
  Shape last = shapes.get(shapes.size() - 1);
  last.display();

  int sideIndex = floor(last.sides.length / 2f + random(1));
  PVector pos = last.sides[0].start;

  if (last.sides.length == 3 && (pos.x < margin || pos.y < margin
    || pos.x > width - margin || pos.y > height - margin)) {
    for (int i = 1; i < last.sides.length; i++) {
      if (centerDist(last.sides[i]) < centerDist(last.sides[sideIndex])
        && !last.sides[i].isConnected) {
        sideIndex = i;
      }
    }
  }

  Side side = last.sides[sideIndex];
  side.isConnected = true;

  Shape next = new Shape(side.end, side.start, last.sides.length % 2 + 3);

  shapes.add(next);
  stroke(220);
  next.display();
}

PVector copyVector(PVector v) {
  return new PVector(v.x, v.y);
}

float centerDist(Side side) {
  return (PVector.dist(center, side.start) 
    + PVector.dist(center, side.end)) / 2;
}

class Shape {
  Side[] sides;

  Shape(PVector p1, PVector p2, int sideCount) {
    this.sides = new Side[sideCount];
    PVector vec = PVector.sub(p2, p1);
    for (int i = 0; i < sideCount; i++) {
      sides[i] = new Side(copyVector(p1), copyVector(p2));
      p1.add(vec);
      vec.rotate(TWO_PI / sideCount);
      p2.add(vec);
    }
  }

  void display() {
    for (Side side : sides) {
      side.display();
    }
  }
}

class Side {
  PVector start;
  PVector end;
  boolean isConnected;

  Side(PVector start, PVector end) {
    this.start = start;
    this.end = end;
    this.isConnected = false;
  }

  void display() {
    line(start.x, start.y, end.x, end.y);
  }
}
