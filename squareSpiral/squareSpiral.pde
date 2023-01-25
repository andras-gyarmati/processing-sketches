int x, y, step; //<>//
boolean isVert = true;

void setup() {
  size(600, 600);
  surface.setLocation(10, 10);
  noFill();
  stroke(0);
  //frameRate(10);

  x = 0;
  y = 0;
  step = 10;
}

void draw() {
  update();
  translate(width / 2, height / 2);
  noFill();
  circle(x, y, 4);
  fill(255, 0, 0);
  circle(0, 0, 4);
}

void update() {
  if (isVert) { //<>//
    if (x <= 0) {
      y -= step;
    } else {
      y += step;
    }
  } else {
    if (y <= 0) {
      x += step;
    } else {
      x -= step;
    }
  }

  boolean topLeft = x <= 0 && y <= 0;
  boolean change = x - step == y;
  if (topLeft && change) {
    isVert = !isVert;
  }

  if (!topLeft && abs(x) == abs(y)) {
    isVert = !isVert;
  }
}
