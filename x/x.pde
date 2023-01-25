void setup() {
  size(1000, 1000);
  surface.setLocation(10, 10);
  noFill();
  rectMode(CENTER);
}

void draw() {
  background(200);
  for (int x = 0; x < 100; x++) {
    for (int y = 0; y < 100; y++) {
      float a = noise(x, y) * 10;
      rect(x * 10 + 5, y * 10 + 5, a, a);
    }
  }
}
