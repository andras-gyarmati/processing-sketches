float a, count, w, h;
PVector v;
boolean c;

void setup() {
  size(600, 600);
  c = true;
  a = 0;
  count = 15;
  w = width / count;
  h = height / count;
  v = new PVector(0, -1);
  rectMode(CENTER);
}

void draw() {
  setLooks();
  display();
  if (a > HALF_PI) switchColors();
  a += 0.01;
  //saveFrame("gif/####.png");
}

void switchColors() {
  a = 0;
  c = !c;
  v.setMag(1);
}

void setLooks() {
  background(c ? 255 : 0);
  fill(c ? 0 : 255);
  noStroke();
}

void display() {
  for (int i = 0; i < count; i++) {
    for (int j = 0; j < count; j++) {
      if (isTheSquareVisibleOnThisPosition(i, j)) {
        pushMatrix();
        translate(i * w + w / 2, j * h + h / 2);
        rotate(a);
        triangle(-w/2+v.x, -h/2+v.y, w/2+v.x, -h/2+v.y, 0+v.x, 0+v.y);
        v.rotate(HALF_PI);
        triangle(w/2+v.x, -h/2+v.y, w/2+v.x, h/2+v.y, 0+v.x, 0+v.y);
        v.rotate(HALF_PI);
        triangle(w/2+v.x, h/2+v.y, -w/2+v.x, h/2+v.y, 0+v.x, 0+v.y);
        v.rotate(HALF_PI);
        triangle(-w/2+v.x, h/2+v.y, -w/2+v.x, -h/2+v.y, 0+v.x, 0+v.y);
        v.rotate(HALF_PI);
        v.add(v.copy().setMag(w/PI/100000));
        //rect(0, 0, w, h/*, -a*30*/);
        popMatrix();
      }
    }
  }
}

boolean isTheSquareVisibleOnThisPosition(int i, int j) {
  if (c) {
    return i % 2 == j % 2;
  } else {
    return i % 2 != j % 2;
  }
}
