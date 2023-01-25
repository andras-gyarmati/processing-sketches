GOL gol; //<>// //<>//
boolean run;

void setup() {
  size(640, 481);
  colorMode(HSB);
  gol = new GOL();
  run = true;
  gol.init();
  noLoop();
}

void draw() {
  if (run) {
    background(0);
    gol.generate();
  }
  gol.displayCells();
  run = false;
}

void mousePressed() {
  if (mouseButton == LEFT || mouseButton == RIGHT) {
    gol.mousePressed();
    gol.displayCells();
    redraw();
  } else {
    run = !run;
    redraw();
  }
}