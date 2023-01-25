class Boundary {

  float x;
  float y;
  float w;
  float h;
  FBox body;

  Boundary(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    create();
  }

  private void create() {
    body = new FBox(w, h);
    body.setPosition(x, y);
    body.setStatic(true);
    body.setDensity(10);
    body.setFriction(1000);
    body.setRestitution(0);
    world.add(body);
  }

  void display() {
    fill(100, 0, 50);
    noStroke();
    rectMode(CENTER);
    rect(x, y, w, h);
  }
}