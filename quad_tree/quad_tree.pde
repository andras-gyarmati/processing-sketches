// todo: add point class with custom data prop

QuadTree qt;
int treeNodePointCount = 4;

void setup() {
  size(1000, 1000);
  surface.setLocation(10, 10);
  qt = new QuadTree(new Rect(width / 2, height / 2, width / 2, height / 2));
  rectMode(CENTER);
}

void draw() {
  qt.show();
}

void mouseDragged() {
  qt.add(new PVector(mouseX, mouseY));
}
