PGraphics pg;
int w = 200;
int h = 200;

public void settings() {
  size(int(w), int(h));
}

void setup() {
  pg = createGraphics(w * 2, h * 2);
}

void draw() {
  pg.beginDraw();
  pg.background(102);
  pg.stroke(255);
  pg.line(pg.width*0.5, pg.height*0.5, mouseX, mouseY);
  pg.endDraw();
  pg.save("out/" + frameCount + ".png");
  image(pg, 0, 0, w, h);
}
