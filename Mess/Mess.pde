QuadTree qtree;
Rectangle boundary;
int subtreeElementLimit;

void setup() {
  size(1000, 1000);
  subtreeElementLimit = 100;
  boundary = new Rectangle(width/2, height/2, width/2, height/2);
  qtree = new QuadTree(boundary, subtreeElementLimit);
  for (int i = 0; i < 1; i++) {
    Ball b = new Ball(new PVector(random(width), random(height)), 40);
    qtree.insert(b);
  }
}

void draw() {
  background(0);
  ArrayList<Ball> newBalls = qtree.updateBalls();
  for (Ball b : newBalls) {
    qtree.insert(b);
  }
  qtree.showBoundary();
  qtree.displayBalls();
  updateQtree();
}

void updateQtree() {
  ArrayList<Ball> balls = qtree.cutAllBalls();
  qtree = new QuadTree(boundary, subtreeElementLimit);
  for (Ball b : balls) {
    qtree.insert(b);
  }
}
