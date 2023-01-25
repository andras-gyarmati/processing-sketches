class Ball {

  PVector pos, vel;
  int radius;
  Vec2 v;
  boolean isMoving;
  Body body;

  Ball(PVector pos, int radius) {
    this.pos = pos;
    this.radius = radius;
    v = new Vec2();
    this.vel = new PVector(0, 400);
    isMoving = false;
    createBody(pos, radius);
  }

  void createBody(PVector pos, int radius) {
    BodyDef bd = new BodyDef();
    bd.fixedRotation = true;

    bd.position = box2d.coordPixelsToWorld(pos.x, pos.y);
    bd.type = BodyType.DYNAMIC;
    body = box2d.world.createBody(bd);

    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(radius);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;

    fd.density = 1;
    fd.friction = 1;
    fd.restitution = 1;
    body.createFixture(fd);
  }

  void start() {
    isMoving = true;
    v.set(vel.x, vel.y);
    body.applyLinearImpulse(v, v, true);
  }

  void reset(Slider s) {
    pos.x = s.pos.x + s.w / 2;
    pos.y = s.pos.y - radius;
    isMoving = false;
    this.vel.set(0, -30);
  }

  void update() {
    if (isMoving) {
    }
  }

  void calcVel(Slider s) {
    float mag = vel.mag();
    PVector diff = PVector.sub(new PVector(pos.x, 0), new PVector(s.pos.x + s.w / 2, 0));
    float diffMag = diff.mag();
    diff.setMag(diffMag * 0.05);
    vel.add(diff);
    vel.setMag(mag);
  }

  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    pushMatrix();
    translate(pos.x, pos.y);
    fill(255);
    ellipse(0, 0, radius * 2, radius * 2);
    popMatrix();
  }
}