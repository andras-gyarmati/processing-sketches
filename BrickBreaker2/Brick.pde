class Brick {

  PVector pos;
  int life, maxLife;
  int w, h;
  Body body;

  Brick(PVector pos, int w, int h, int life) {
    this.pos = pos;
    this.w = w;
    this.h = h;
    this.life = life;
    maxLife = life;
  }

  void createBody(PVector pos, int w, int h) {
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    sd.setAsBox(box2dW, box2dH);

    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(pos.x, pos.y));
    body = box2d.createBody(bd);

    FixtureDef fd = new FixtureDef();
    fd.shape = sd;

    fd.density = 1;
    fd.friction = 1;
    fd.restitution = 0.1;

    body.createFixture(fd);
  }

  void destroy() {
    box2d.destroyBody(body);
  }

  void display() {
    if (life > 0) {
      int brightness = floor(map(life, 0, maxLife, 0, 255));
      fill(40, 200, brightness);
      rect(pos.x, pos.y, w, h);
    }
  }

  void damage() {
    life -= 1;
  }
}