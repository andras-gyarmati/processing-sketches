float speed, inc, roff, rscl;
int pcount, vcount;
PVector[] flowfield;
Particle[] particles;
int exportRes = 2000;
PGraphics newg, saveg;

void setup() {
  newg = createGraphics(exportRes, exportRes);
  saveg = createGraphics(exportRes, exportRes);

  saveg.beginDraw();
  saveg.background(255);
  saveg.endDraw();

  speed = 4;
  inc = 0.002;
  rscl = 1;
  roff = random(TWO_PI);

  pcount = 10000;
  particles = new Particle[pcount];
  for (int i = 0; i < pcount; i++) {
    particles[i] = new Particle();
  }

  vcount = (exportRes + 1) * (exportRes + 1);
  flowfield = new PVector[vcount];
  updateField(); //<>//
  //smooth(8);
}

void draw() {
  newg.beginDraw();
  newg.stroke(0);
  newg.strokeWeight(2);
  newg.strokeCap(SQUARE);
  newg.blendMode(ADD);
  newg.noStroke();
  newg.fill(255, 2);
  newg.rect(0, 0, exportRes, exportRes);
  newg.stroke(0, 64);
  newg.blendMode(BLEND);
  for (Particle particle : particles) {
    particle.update();
    particle.edges();
    particle.show();
  }
  newg.endDraw();
  PImage image = new PImage(newg.image);
  saveg.beginDraw();
  saveg.blend(image, 0, 0, exportRes, exportRes, 0, 0, exportRes, exportRes, BLEND);
  saveg.endDraw();
  saveg.save("out/" + frameCount + ".png");
}

void updateField() {
  float yoff = 0;
  for (int y = 0; y <= exportRes; y++) {
    float xoff = 0;
    for (int x = 0; x <= exportRes; x++) {
      float angle = noise(xoff, yoff) * TWO_PI * rscl + roff;
      PVector v = PVector.fromAngle(angle);
      v.setMag(speed); // todo: where it points outward make it slow, where it points to eachother make it fast
      flowfield[x + y * exportRes] = v;
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
    int index = floor(this.x) + floor(this.y) * exportRes;
    PVector v = flowfield[index];
    this.vx = v.x;
    this.vy = v.y;
    this.x += this.vx;
    this.y += this.vy;
  }

  void show() {
    newg.line(this.x, this.y, this.px, this.py);
    updatePrev();
  }

  void updatePrev() {
    this.px = x;
    this.py = y;
  }

  void edges() {
    if (this.x > exportRes || this.x < 0 || this.y > exportRes || this.y < 0) {
      init();
    }
  }

  void init() {
    this.x = random(exportRes);
    this.y = random(exportRes);
    this.vx = 0;
    this.vy = 0;
    updatePrev();
  }
}
