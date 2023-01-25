class Slider {

  PVector pos, vel;
  int w, h;
  Body body;

  Slider() {
    w = 250;
    h = 30;
    pos = new PVector(width / 2 - w / 2, height - 200);
    vel = new PVector();
    createBody(pos, w, h);
  }

  void createBody(PVector pos, int w, int h) {
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w / 2);
    float box2dH = box2d.scalarPixelsToWorld(h / 2);
    sd.setAsBox(box2dW, box2dH);

    BodyDef bd = new BodyDef();
    bd.type = BodyType.KINEMATIC;
    bd.position.set(box2d.coordPixelsToWorld(pos.x, pos.y));
    body = box2d.createBody(bd);

    FixtureDef fd = new FixtureDef();
    fd.shape = sd;

    fd.density = 1;
    fd.friction = 1;
    fd.restitution = 0.1;

    body.createFixture(fd);
  }


  void update(float x) {
    pos.x = x - w / 2;
  }

  void display() {
    fill(150, 255, 255);
    rect(pos.x, pos.y, w, h);
  }
}