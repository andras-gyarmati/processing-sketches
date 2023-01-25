float a, count, w, h, switchAngle;
boolean c;
color fg, bg;

void setup() {
  size(600, 600);
  //fullScreen();
  c = true;
  a = 0;
  count = 15;
  fg = color(40);
  bg = color(150);
  w = width / count;
  h = height / count;
  rectMode(CENTER);
  switchAngle = width == height ? HALF_PI : PI;
}

void draw() {
  setLooks();
  display();
  a += 0.03;
  if (a > switchAngle) switchColors();
  if (a > switchAngle) a = 0;
  //saveFrame("gif/####.png");
}

void switchColors() {
  c = !c;
}

void setLooks() {
  background(c ? fg : bg);
  fill(c ? bg : fg);
  noStroke();
}

void display() {
  for (int i = 0; i < count; i++) {
    for (int j = 0; j < count; j++) {
      if (isTheSquareVisibleOnThisPosition(i, j)) {
        pushMatrix();
        translate(i * w + w / 2, j * h + h / 2);
        rotate(a);
        float d = (sqrt(pow((switchAngle / 2 - a), 2)) - switchAngle / 2) * 30;
        rect(0, 0, w+d, h+d/*, -a*30*/);
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
