
Circle c;

void setup() {
  size(1000, 1000);
  strokeWeight(1);
  c = new Circle(200, 3);
}

void draw() {
  background(243);
  translate(width / 2, height / 2);
  //c = new Circle(200, 3);
  c.display();
}

void mouseDragged() {
  c.mouseDragged_(mouseX - width / 2, mouseY - height / 2);
}
