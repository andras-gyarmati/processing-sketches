class Knob {

  FCircle body;
  float x; 
  float y; 
  float density; 
  float friction; 
  float restitution;
  float radius;
  ArrayList<Knob> pairs;

  Knob(float x, float y, float density, float friction, float restitution, float radius) {
    this.x = x; 
    this.y = y; 
    this.density = density; 
    this.friction = friction; 
    this.restitution = restitution;
    this.radius = radius;
    pairs = new ArrayList<Knob>();
  }

  void create() {
    body = new FCircle(radius*2);
    body.setPosition(x, y);
    body.setDensity(density);
    body.setFriction(friction);
    body.setRestitution(restitution);
    world.add(body);
  }

  void destroy() {
    world.remove(body);
  }

  void addPair(Knob k2) {
    this.pairs.add(k2);
    k2.pairs.add(this);
  }

  void display() {
    PVector pos = new PVector(body.getX(), body.getY());
    float a = body.getRotation();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    //fill(map(body.getFixtureList().getDensity(), 0, 1, 0, 255));
    //stroke(map(body.getFixtureList().getFriction(), 0, 1, 255, 0));
    //strokeWeight(map(body.getFixtureList().getRestitution(), 0, 1, 1, 3));
    ellipse(0, 0, radius * 2, radius * 2);
    //line(0, 0, radius, 0);
    popMatrix();
  }

  PVector getPos() {
    PVector pos = new PVector(body.getX(), body.getY());
    return new PVector(pos.x, pos.y);
  }
}