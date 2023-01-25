float speed, inc, roff, dirmult;
int len, margin, wpm, hpm, mcells, cols, rows;
ArrayList<PVector> flowfield;
ArrayList<Particle> particles;

void setup() {
  size(500, 500);
  len = 2;
  margin = 0;
  mcells = floor(margin / len);
  wpm = width + margin * 2;
  hpm = height + margin * 2;
  particles = new ArrayList<Particle>();
  speed = 3;
  inc = 0.005;
  dirmult = 1;
  roff = random(TWO_PI);
  cols = floor(wpm / len);
  rows = floor(hpm / len);
  flowfield = new ArrayList<PVector>(cols * rows);
  for (int i = 0; i < 5000; i++) {
    particles.add(new Particle());
  }
  updateField();
  stroke(0, 100);
  strokeWeight(2);
}

void draw() {
  blendMode(ADD);
  noStroke();
  fill(255, speed);
  rect(0, 0, width, height);
  stroke(0, 50);
  blendMode(BLEND);
  
  for (int i = 0; i < particles.size(); i++) {
    particles.get(i).update();
    particles.get(i).edges();
    particles.get(i).show();
  }
}

void updateField() {
  float yoff = 0;
  for (int y = 0; y < rows + mcells * 2; y++) {
    float xoff = 0;
    for (int x = 0; x < cols + mcells * 2; x++) {
      float angle = noise(xoff, yoff) * TWO_PI * dirmult + roff;
      PVector v = PVector.fromAngle(angle);
      v.setMag(speed);
      flowfield.add(new PVector(v.x, v.y));
      xoff += inc;
    }
    yoff += inc;
  }
}

PVector getRandomPos() {
  return new PVector(random(wpm) - margin, random(hpm) - margin);
}

class Particle {
  PVector pos, vel, prevPs;
  Particle() {
    this.pos = getRandomPos();
    this.vel = new PVector(0, 0);
    this.prevPs = this.pos.copy();
  }

  void update() {
    int x = floor(this.pos.x) / len;
    int y = floor(this.pos.y) / len;
    int index = x + y * cols;
    if (index >= flowfield.size()) return;
    PVector v = flowfield.get(index);
    this.vel.set(v.x, v.y);
    this.pos.add(this.vel);
  }

  void show() {
    line(this.pos.x, this.pos.y, this.prevPs.x, this.prevPs.y);
    updatePrev();
  }

  void updatePrev() {
    prevPs.set(this.pos.x, this.pos.y);
  }

  void edges() {
    if (this.pos.x > width + margin || this.pos.x < -margin ||
      this.pos.y > height + margin || this.pos.y < -margin) {
      this.pos = getRandomPos();
      this.vel.mult(0);
      this.updatePrev();
    }
  }
}
