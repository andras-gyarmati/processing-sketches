class Arrow {
  PVector pos, vel, acc;
  float size;
  double colour;
  float friction_coefficient = 0.998;

  Arrow(PVector pos, PVector vel, PVector acc, float size) {
    this.pos = pos.copy();
    this.vel = vel.copy();
    this.acc = acc.copy();
    this.size = size;
    colour = sigmoid(vel.mag());
  }

  void update() {
    pos.add(vel);
    vel.add(acc);
    if (pos.x-size/2 < 0) {
      pos.x = 0  + size/2;
      vel.x *= -1;
      vel.mult(friction_coefficient);
    } else if (pos.x+size/2 > width) {
      pos.x = width  - size/2;
      vel.x *= -1;
      vel.mult(friction_coefficient);
    }
    if (pos.y-size/2 < 0) {
      pos.y = 0 + size/2;
      vel.y *= -1;
      vel.mult(friction_coefficient);
    } else if (pos.y+size/2 > height) {
      pos.y = height - size/2;
      vel.y *= -1;
      vel.mult(friction_coefficient);
    }
    vel.mult(friction_coefficient);
  }

  void bumpInto(Arrow other) {
    PVector tmp = vel.copy();
    vel.set(other.vel.copy());
    other.vel = tmp;
  }

  void display() {
    noStroke();
    this.colour = sigmoid(vel.mag());
    fill((float)colour*255, 255, 255);
    ellipse(pos.x, pos.y, size, size);
  }
}
