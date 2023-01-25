class Ball {
  PVector pos, vel, acc;
  float radius, baseRadius, startVelRange;
  int fractureCount;

  Ball(PVector pos, float radius) {
    this.pos = pos;
    this.radius = radius;
    this.baseRadius = radius;
    fractureCount = 5;
    startVelRange = 4;
    this.vel = new PVector(random(startVelRange)-startVelRange/2, random(startVelRange)-startVelRange/2);
    this.acc = new PVector(0, 0);
  }

  ArrayList<Ball> update() {
    radius += 1;
    vel.add(acc);
    pos.add(vel);
    edgeTeleport();
    //absorb(getNearbyBalls(radius*2));
    if (radius > baseRadius*fractureCount) {
      return blowUp();
    }
    return null;
  }

  void edgeTeleport() {
    if (pos.x > width) pos.x -= width;
    if (pos.y > height) pos.y -= height;
    if (pos.x < 0) pos.x += width;
    if (pos.y < 0) pos.y += width;
  }

  ArrayList<Ball> getNearbyBalls(float distance) {
    Rectangle range = new Rectangle(pos.x, pos.y, distance, distance);
    return qtree.query(range);
  }

  void absorb(ArrayList<Ball> balls) {
    for (Ball b : balls) {
      float edgeDist = PVector.dist(b.pos, this.pos) - b.radius - this.radius;
      if (b.radius < this.radius && edgeDist < 0) {
        float diff = min(b.radius, -edgeDist);
        this.radius += diff;
        b.radius -= diff;
      }
    }
  }

  ArrayList<Ball> blowUp() {
    ArrayList<Ball> newBalls = new ArrayList<Ball>();
    PVector normalizedVel = vel.copy();
    normalizedVel.setMag(3);
    for (int i = 0; i < fractureCount; i++) {
      Ball nb = new Ball(pos, baseRadius);
      nb.vel = new PVector(random(startVelRange)-startVelRange/2, random(startVelRange)-startVelRange/2);
      //nb.vel.add(vel);
      //normalizedVel.rotate(i*TWO_PI/fractureCount);
      //nb.vel.add(normalizedVel);
      newBalls.add(nb);
    }
    this.radius = 0;
    return newBalls;
  }


  void display() {
    noStroke();
    fill(255, 255, 255, 10);
    ellipse(pos.x, pos.y, radius, radius);
  }
}
