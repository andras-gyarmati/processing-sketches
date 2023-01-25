float speed, inc, roff, rscl;
int pcount, vcount;
PVector[] flowfield;
Particle[] particles;
boolean isRinning = false;

void setup() {
  size(900, 900);
  //fullScreen();

  speed = 4;
  inc = 0.002;
  rscl = 1;
  roff = random(TWO_PI);

  pcount = 10000;
  particles = new Particle[pcount];
  for (int i = 0; i < pcount; i++) {
    particles[i] = new Particle();
  }

  vcount = (width + 1) * (height + 1);
  flowfield = new PVector[vcount];
  updateField();
  stroke(0);
  strokeWeight(2);
  strokeCap(SQUARE);
  //smooth(8);
}

void draw() {
  if (!isRinning) return;
  blendMode(ADD);
  noStroke();
  fill(255, 2);
  rect(0, 0, width, height);
  stroke(0, 64);
  blendMode(BLEND);
  //background(255);

  for (Particle particle : particles) {
    particle.update();
    particle.edges();
    particle.show();
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      isRinning = !isRinning;
    }
  }
}

void updateField() {
  float yoff = 0;
  for (int y = 0; y <= height; y++) {
    float xoff = 0;
    for (int x = 0; x <= width; x++) {
      float angle = noise(xoff, yoff) * TWO_PI * rscl + roff;
      PVector v = PVector.fromAngle(angle);
      v.setMag(speed); // todo: where it points outward make it slow, where it points to eachother make it fast
      flowfield[x + y * width] = v;
      xoff += inc;
    }
    yoff += inc;
  }
}

class Particle {
  float x, y, vx, vy, px, py;
  Particle() {
    init();
  }

  void update() {
    int index = floor(this.x) + floor(this.y) * width;
    PVector v = flowfield[index];
    this.vx = v.x;
    this.vy = v.y;
    this.x += this.vx;
    this.y += this.vy;
  }

  void show() {
    line(this.x, this.y, this.px, this.py);
    updatePrev();
  }

  void updatePrev() {
    this.px = x;
    this.py = y;
  }

  void edges() {
    if (this.x > width || this.x < 0 || this.y > height || this.y < 0) {
      init();
    }
  }

  void init() {
    this.x = random(width);
    this.y = random(height);
    this.vx = 0;
    this.vy = 0;
    updatePrev();
  }
}
