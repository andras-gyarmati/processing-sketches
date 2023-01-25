
void setup() {
  size(512, 512);
  //fullScreen();
  //colorMode(HSB);
  //background(255);
  noLoop();
}

void draw() {
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      pixels[x + y * width] = color(abs(x - y));
    }
  }
  updatePixels();
}