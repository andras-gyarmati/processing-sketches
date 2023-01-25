GOL gol;

void setup() {
  //size(800, 800);
  fullScreen();
  colorMode(HSB);
  gol = new GOL();
}

void draw() {
  background(0);
  gol.generate();
  gol.display();
}

void mousePressed() {
  gol.mousePressed();
}
