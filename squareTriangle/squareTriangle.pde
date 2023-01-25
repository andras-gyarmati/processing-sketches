Triangle t;
Square s;
Polygon p;

void setup() {
  size(1000, 1000);
  t = new Triangle();
  s = new Square();
}

void draw() {
  background(20);
  translate(width / 2, height / 2);
  p = new Polygon(2, 100);
  p.display();
  //t.display();
  //s.display();
}
