class Ball {
  PVector pos;
  PVector vel;
  PVector acc;
  float mass, baseMass;
  int fractureCount;

  Ball(PVector pos, float mass) {
    this.pos = pos;
    this.mass = mass;
    this.baseMass = mass;
    fractureCount = 5;
    this.vel = new PVector(random(2)-1, random(2)-1);
    this.acc = new PVector(0, 0);
  }

  void update() {
    vel.add(acc);
    pos.add(vel);
    if (pos.x > width) pos.x -= width;
    if (pos.y > height) pos.y -= height;
    if (pos.x < 0) pos.x += width;
    if (pos.y < 0) pos.y += width;
    if (mass > baseMass*fractureCount) {
      blowUp();
    }
  }

  ArrayList<Ball> blowUp() {
    ArrayList<Ball> newBalls = new ArrayList<Ball>();
    PVector normalizedVel = vel.copy().setMag(1);
    for (int i = 0; i < fractureCount; i++) {
      Ball nb = new Ball(pos, baseMass);
      nb.vel = new PVector(0, 0).add(vel).add(normalizedVel.rotate(i*TWO_PI/fractureCount));
      newBalls.add(nb);
    }
    mass = 0;
    return newBalls;
  }


  void display() {
    noStroke();
    fill(255, 255, 255, 100);
    ellipse(pos.x, pos.y, mass, mass);
  }
}


//vannak a bogyok minden frameben a nagyobb elvesz egy sulyt a kisebbtol ha osszeernek ha elfogy a kisebb akkor kuka a nagyobb meg ha tul nagy lesz felrobban  es n iranyba szallnak ki a kisebbek a palya szelei ossze vannak kotve fank topologia
