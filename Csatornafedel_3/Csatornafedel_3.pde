ArrayList<Particle> particles;
float pointsPerCircleMultiplier = 6;
float circleDistance = 15;
PVector center = new PVector(0, 0);
int circleCount = 30;
float lineLengthMultiplier = 1.1;
float circleGrowAmount = 0.004;
PVector up = new PVector(0, 1);

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
  translate(width / 2, height / 2);
  for (Particle particle : particles) {
    particle.display();
  }
  displayCenterPoint();
}

void displayCenterPoint() {
  fill(255, 0, 0);
  ellipse(0, 0, 10, 10);
}

void createPoints() {
  particles = new ArrayList<Particle>();
  PVector position = new PVector(0, circleDistance);
  for (int i = 1; i <= circleCount; i++) {
    float particlesPerCircle = i * pointsPerCircleMultiplier;
    for (int j = 0; j < particlesPerCircle; j++) {
      particles.add(new Particle(position.copy()));
      position.rotate(TWO_PI / particlesPerCircle);
    }
    position.setMag(position.mag() + circleDistance);
  }
}
