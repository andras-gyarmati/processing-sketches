private Drawing drawing;
private GUI gui;

void setup() {
  //fullScreen();
  size(1280, 720);
  colorMode(HSB);
  drawing = new Drawing();
  gui = new GUI();
}

void draw() {
  update();
  display();
}

private void update() {
  gui.updateVf(drawing.getDrawing());
}

private void display() {
  drawing.display();
  gui.display();
}

void mousePressed() {
  drawing.pencilDown();
  drawing.draw();
}

void mouseDragged() {
  drawing.draw();
}

void mouseReleased() {
  drawing.pencilUp();
}
