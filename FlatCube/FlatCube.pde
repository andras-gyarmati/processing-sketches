Cube cube;

void setup() {
  size(1280, 720);
  colorMode(HSB);
  cube = new Cube();
  noLoop();
}

void draw() {
  translate(width / 6, height / 3);
  //cube.display3D();
  cube.display2D(50);
}