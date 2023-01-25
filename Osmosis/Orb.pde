class Orb {
  PVector pos, vel, acc;
  float radius;
  ArrayList<PVector> forces;

  Orb () {
    this(new PVector(random(width), random(width)), 50);
  }

  Orb (PVector pos) {
    this(pos, 10);
  }

  Orb (PVector pos, float radius) {
    this.pos = pos;
    this.radius = radius;
    this.vel = new PVector(0, 0);
    this.acc = new PVector(0, 0);
    forces = new ArrayList<PVector>();
  }

  void resetAcc() {
    acc.set(0, 0);
  }

  void move() {
    vel.add(acc);
    pos.add(vel);
    edgeTeleport();
  }

  void absorb(Orb orb) {
    float dist = PVector.dist(this.pos, orb.pos);
    float edgeDist = dist - this.radius - orb.radius;
    if (orb.radius <= this.radius && edgeDist < 0) {
      this.addArea(orb.changeRadiusByValueAndReturnAreaSizeChange(edgeDist));
    }
  }

  void deflate() {
    if (radius > 0) {
      radius -= 0.01;
    }
  }

  float changeRadiusByValueAndReturnAreaSizeChange(float radiusChange) {
    float previousArea = getThisArea();
    radius += radiusChange;
    return previousArea - getThisArea();
  }

  float getThisArea() {
    return calcAreaFromRadius(this.radius);
  }

  float calcAreaFromRadius(float r) {
    return PI * pow(r, 2);
  }

  float calcRadiusfromArea(float area) {
    return sqrt(area/PI);
  }

  void addArea(float area) {
    this.radius = sqrt((getThisArea() + area) / PI);
  }

  void edgeTeleport() {
    if (pos.x > width) pos.x -= width;
    if (pos.y > height) pos.y -= height;
    if (pos.x < 0) pos.x += width;
    if (pos.y < 0) pos.y += width;
  }

  PVector calculateGravitationalForceFrom(Orb orb) {
    float gravitationalForceMagnitude = (this.radius * orb.radius) / pow(max(PVector.dist(this.pos, orb.pos), this.radius + orb.radius), 2);
    PVector gravitationalForce = new PVector(orb.pos.x, orb.pos.y);
    gravitationalForce.sub(this.pos);
    gravitationalForce.setMag(gravitationalForceMagnitude);
    return gravitationalForce;
  }

  void soreAndApplyForces(ArrayList<PVector> forces) {
    this.forces = forces;
    for (PVector force : forces) {
      acc.add(force);
    }
  }

  ArrayList<Orb> blowUp() { //ide komolyabb fizika kell, erokkel, osszetarto ero es szetfeszito ero stb
    ArrayList<Orb> newOrbs = new ArrayList<Orb>();
    PVector normalizedVel = vel.copy();
    normalizedVel.normalize();
    int fractureCount = 5; //TODO more scientific number based on calculation
    for (int i = 0; i < fractureCount; i++) {
      Orb nb = new Orb(pos, calcRadiusfromArea(getThisArea()/fractureCount));
      nb.vel.add(vel);
      normalizedVel.rotate(i*TWO_PI/fractureCount);
      nb.vel.add(normalizedVel);
      newOrbs.add(nb);
    }
    this.radius = 0;
    return newOrbs;
  }

  void show() {
    stroke(0);
    strokeWeight(2);
    noFill();
    ellipse(pos.x, pos.y, radius*2, radius*2);
    showForces(forces);
  }

  void showForces(ArrayList<PVector> forces) {
    for (PVector force : forces) {
      force.mult(1000);
      stroke(255, 0, 0);
      line(pos.x, pos.y, pos.x + force.x, pos.y + force.y);
    }
  }
}
