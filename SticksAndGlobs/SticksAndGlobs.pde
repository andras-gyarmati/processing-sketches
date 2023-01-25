ArrayList<Displayable> stuff;
PVector start, end;

void setup() {
  size(1280, 720);
  stuff = new ArrayList<Displayable>();
}

void draw() {
  background(0);
  for (int i = 0; i < stuff.size(); i++) {
    stuff.get(i).update();
    stuff.get(i).display();
  }
}

void mousePressed() {
  start = new PVector(mouseX, mouseY);
  end = new PVector(mouseX, mouseY);
}

void mouseDragged() {
  end.set(mouseX, mouseY);
}

void mouseReleased() {
  end.set(mouseX, mouseY);
  if (PVector.dist(start, end) > 10) {
    stuff.add(new Stick(start, end));
  } else {
    stuff.add(new Glob(start));
  }
}
