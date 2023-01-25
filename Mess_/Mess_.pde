QuadTree qtree/*, nextQt*/;
Rectangle boundary;

void setup() {
  size(1000, 1000);
  boundary = new Rectangle(width/2, height/2, width/2, height/2);
  qtree = new QuadTree(boundary, 1);
  //nextQt = new QuadTree(boundary, 1);
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(new PVector(random(width), random(height)), 40);
    qtree.insert(b);
  }
}

void draw() {
  background(0);
  qtree.updateBalls();
  qtree.showBoundary();
  qtree.displayBalls();
  //mouseHighlight();
  updateQtree();
}

void mouseHighlight() {
  strokeWeight(1);
  noFill();
  stroke(0, 255, 0);
  rectMode(CENTER);
  Rectangle range = new Rectangle(mouseX, mouseY, 200, 200);
  rect(range.x, range.y, range.w * 2, range.h * 2);
  ArrayList<Ball> balls = qtree.query(range);
  for (Ball b : balls) {
    strokeWeight(8);
    point(b.pos.x, b.pos.y);
  }
}

void updateQtree() {
  ArrayList<Ball> balls = qtree.cutAllBalls();
  for (Ball b : balls) {
    qtree.insert(b);
  }
}
