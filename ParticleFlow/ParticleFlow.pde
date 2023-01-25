//particle_flow //<>//

PVector[][] grid;
Particle[] particles;
int gridSize, particleCount;

void setup() {
  size(500, 500);
  //colorMode(HSB);
  gridSize = 10;
  particleCount = 500;
  grid = new PVector[gridSize][];
  init();
}

void draw() {
  //background(0, 10);
  fill(0, 10);
  noStroke();
  rect(0, 0, width, height);
  //debugDispGrid();
  for (Particle p : particles) {
    p.update();
    p.display();
  }
}

void debugDispGrid() {
  stroke(255);
  for (int x = 0; x < gridSize; x++) {
    for (int y = 0; y < gridSize; y++) {
      float xx = x * width / gridSize;
      float yy = y * width / gridSize;
      line(xx, yy, xx + grid[x][y].x, yy + grid[x][y].y);
    }
  }
}

void init() {
  grid = new PVector[gridSize][];
  for (int x = 0; x < gridSize; x++) {
    grid[x] = new PVector[gridSize];
    for (int y = 0; y < gridSize; y++) {
      grid[x][y] = new PVector(random(10) - 5, random(10) - 5);
    }
  }

  particles = new Particle[particleCount];
  for (int i = 0; i < particleCount; i++) {
    particles[i] = new Particle(new PVector(random(width), random(height)));
  }
}

PVector copyVector(PVector v) {
  return new PVector(v.x, v.y); //<>//
} //<>//
 //<>//
PVector getDir(PVector pos) {
  int x = floor(pos.x / (width / gridSize));
  int y = floor(pos.y / (height / gridSize));
  x = constrain(x, 0, gridSize - 1);  
  y = constrain(y, 0, gridSize - 1);  
  PVector v = grid[x][y];
  return v;
}

class Particle {
  float r, mv, ma;
  PVector pos, vel, acc;

  Particle(PVector pos) {
    this.pos = pos;
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    r = 5;
    ma = 0.5;
    mv = 5;
  }

  void update() {
    PVector dir = calcDir();
    //dir.normalize();
    acc.add(dir);
    acc.limit(ma);
    vel.add(acc);
    vel.limit(mv);
    pos.add(vel);

    if (pos.x > width) pos.x -= width;
    if (pos.y > height) pos.y -= height;
    if (pos.x < 0) pos.x += width;
    if (pos.y < 0) pos.y += height;
  }

  PVector calcDir() {
    return getDir(pos);
  }

  void display() {
    fill(255);
    //pushMatrix();
    //translate(pos.x, pos.y);
    ellipse(pos.x, pos.y, r, r);
    //popMatrix();
  }
}
