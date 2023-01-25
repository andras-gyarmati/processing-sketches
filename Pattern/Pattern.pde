ArrayList<Shape> shapes;

void setup() {
  size(1000, 800);
  smooth(8);
  shapes = new ArrayList<Shape>();
  shapes.add(new Shape(new PVector(254, 254), new PVector(248, 248), 2));
  //frameRate(15);
}

void draw() {
  background(220);
  
  Shape last = shapes.get(shapes.size() - 1);
  //int sideIndex = floor(last.sides.length / 2f + random(1));
  int sideIndex = floor(random(last.sides.length));
  Side side = last.sides[sideIndex];
  
  shapes.add(new Shape(side.end, side.start, floor(random(5) + 3)));
  
  for (Shape shape : shapes) {
    shape.display();
  }
}

PVector copyVector(PVector v) {
  return new PVector(v.x, v.y);
}
