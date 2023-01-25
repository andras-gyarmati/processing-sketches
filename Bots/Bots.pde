ArrayList<Bot> bots; //<>//

void setup() {
  size(1200, 1200);
  colorMode(HSB);
  strokeWeight(2);
  generate();
}

void draw() {
  background(200);
  for (Bot b : bots) {
    b.update();
    b.display();
  }
}

void generate() {
  bots = new ArrayList<Bot>();

  for (int i = 0; i < 10; i++) {
    bots.add(new Bot(new PVector(random(width), random(height))));
  }
}

PVector copyVector(PVector v) {
  return new PVector(v.x, v.y);
}

void mousePressed() {
}

class Bot {
  float rotation, r;
  int angles;
  PVector pos;
  PVector dir;

  Bot(PVector pos) {
    rotation = random(1);
    dir = new PVector(1, 1);
    r = 20;
    this.pos = pos;
    angles = 3;
  }

  void update() {
    Bot closest = findClosest();
    if (PVector.dist(pos, closest.pos) > r) {
      calcDir(closest.pos, pos);
    }
    dir.normalize();
    PVector ve = copyVector(dir);
    ve.rotate(rotation);
    pos.add(ve);
    if (pos.x > width) pos.x -= width;
    if (pos.y > height) pos.y -= height;
    if (pos.x < 0) pos.x += width;
    if (pos.y < 0) pos.y += height;

    if (rotation > TWO_PI) {
      rotation = 0;
    }
  }

  void calcDir(PVector to, PVector from) {
    dir = copyVector(to);
    dir.sub(from);
  }

  void display() {
    if (angles < 2) return;
    fill(0, 250, 255);
    pushMatrix();
    translate(pos.x - r, pos.y - r);
    rotate(rotation);
    beginShape();
    for (int i = 0; i < angles; i++) {
      PVector v1 = copyVector(dir);
      v1.mult(r);
      v1.rotate(TWO_PI/angles*i);
      vertex(v1.x, v1.y);
    }
    endShape(CLOSE);
    popMatrix();
  }

  Bot findClosest() {
    Bot closest = bots.get(0);

    while (closest == this) {
      closest = bots.get(floor(random(bots.size() - 1)));
    }

    for (Bot bot : bots) {
      float dist = PVector.dist(pos, bot.pos);
      if (dist > width / 2) dist -= width / 2;
      if (bot != this && dist < PVector.dist(pos, closest.pos) && dist > r) {
        closest = bot;
      }
    }
    return closest;
  }
}
