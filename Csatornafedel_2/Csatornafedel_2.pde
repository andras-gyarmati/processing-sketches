ArrayList<PVector> particles;
float pointsPerCircleMultiplier = 1;
float circleDistance = 15;
PVector center = new PVector(0, 0);
int circleCount = 30;
float lineLengthMultiplier = 2;
float circleGrowAmount = 0.004;

void setup() {
  size(1000, 1000);
  surface.setLocation(10, 10);
  strokeCap(SQUARE);
  strokeWeight(3);
  fill(0);
  createPoints();
}

void draw() {
  background(255);
  update();
  display();
  // saveFrame("out2/#####.png");
}

void update() {
  circleDistance += circleGrowAmount;
  // pointsPerCircleMultiplier += 0.001;
  createPoints();
}

void display() {
  PVector lineBase = new PVector(0, circleDistance * lineLengthMultiplier / 2);
  translate(width / 2, height / 2);
  for (int i = 0; i < particles.size(); i++) {
    PVector lineStart = particles.get(i);
    PVector lineVector = lineBase.copy().rotate(lineStart.dist(center));
    PVector lineEnd = lineStart.copy().add(lineVector);
    lineStart = lineStart.copy().sub(lineVector);
    line(lineStart.x, lineStart.y, lineEnd.x, lineEnd.y);
  }
  displayCenterPoint();
}

void displayCenterPoint() {
  fill(255, 0, 0);
  ellipse(0, 0, 10, 10);
}

void createPoints() {
  particles = new ArrayList<PVector>();
  PVector pos = new PVector(0, circleDistance);
  for (int i = 0; i < circleCount; i++) {
    float particlesPerCircle = (i + 1) * pointsPerCircleMultiplier;
    for (int j = 0; j < particlesPerCircle; j++) {
      particles.add(pos.copy());
      pos.rotate(TWO_PI / particlesPerCircle);
    }
    pos.setMag(pos.mag() + circleDistance);
  }
}
