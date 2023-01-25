ArrayList<PVector> ps;
float d;
int cols, rows;

void setup() {
  size(800, 800);
  ps = new ArrayList<PVector>();
  d = 50;
  cols = 10;
  rows = 10;
  init();
}

void draw() {
  background(0);
  for (PVector p : ps) {
    fill(255);
    noStroke();
    float scale = 1.0;
    ellipse(p.x, p.y, d*map(abs(width/2-p.x), 0, width/2, scale, 0), d*map(abs(height/2-p.y), -height/2, height/2, -1, 1));
    //ellipse(p.x, p.y, d, d);
  }
  for (PVector p : ps) {
    fill(0);
    noStroke();
    ellipse(p.x, p.y, d-4, d-4);
  }
}

void init() {
  for (int y = 0; y <= cols; y++) {
    for (int x = 0; x <= rows; x++) {
      ps.add(new PVector(x*width/rows, y*height/cols));
    }
  }
}
