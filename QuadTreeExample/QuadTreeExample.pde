QuadTree qtree;

void setup() {
  size(400, 400);
  background(255);
  Rectangle boundary = new Rectangle(200, 200, 200, 200);
  qtree = new QuadTree(boundary, 4);
  for (int i = 0; i < 3000; i++) {
    Point p = new Point(random(width), random(height));
    qtree.insert(p);
  }
}

void draw() {
  background(0);
  qtree.show();
  stroke(0, 255, 0);
  rectMode(CENTER);
  Rectangle range = new Rectangle(mouseX, mouseY, 25, 25);
  rect(range.x, range.y, range.w * 2, range.h * 2);
  ArrayList<Point>points = qtree.query(range);
  for (Point p : points) {
    strokeWeight(4);
    point(p.x, p.y);
  }
}
