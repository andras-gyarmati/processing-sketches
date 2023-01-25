int maxBranches, maxLevels;
Branch base;

void setup() {
  size(480, 640);
  maxBranches = 3;
  maxLevels = 15;
  base = new Branch(new PVector(width/2, height), new PVector(width/2, height - 100), 1, 1);
  noLoop();
}

void draw() {
  base.grow();
  base.display();
}
