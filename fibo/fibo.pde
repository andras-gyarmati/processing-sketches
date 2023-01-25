int x, y;
void setup() {
  size(400, 400);
  x = 1;
  y = 1;
}
void draw() {
  background(200);
  translate(200, 200);
  stroke(0);
  ellipse(x, y, 2, 2);
  int tmp = y;
  y = x + y;
  x = tmp;
}
