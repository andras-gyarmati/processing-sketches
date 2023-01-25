float x = 1;
float y = 1;
float z = 0;
float b = 0.1;

float dt = 0.005;
float dx = (sin(y)-b*x)*dt;
float dy = (sin(z)-b*y)*dt;
float dz = (sin(x)-b*z)*dt;

ArrayList<PVector> points = new ArrayList<PVector>();

void setup() {
  size(1000, 1000, P3D);
  surface.setLocation(10, 10);  
  colorMode(HSB);

  strokeWeight(0.5);
  smooth(8);
  noFill();

  x = 1.00;
  y = 1.00;
  z = 0.00;
  b = 0.1960463;
}

void draw() {
  background(0);
  //x = 1.00;
  //y = 1.00;
  //z = 0.00;
  //b = 0.1960463;
  //points = new ArrayList<PVector>();
  for (int i = 0; i < 80; i++) {
    update();
  }

  perspective(PI/6.8, (float)width/height, 3.3, 5000);

  translate(501.3, 500.0, 755.9);
  rotateX(18.47);
  rotateY(10.87);
  rotateZ(-0.22);
  scale(5.3);

  float hue = 0;
  beginShape();
  for (PVector v : points) {
    stroke(hue, 255, 255);
    curveVertex(v.x, v.y, v.z); 
    // todo only draw the last segment and do not draw background, and prev segments as it slows it down
    hue += 0.5;
    if (hue > 255) {
      hue = 0;
    }
  }
  endShape();

  saveFrame("c:/processing_outputs/thomas/#####.png");
}

void update() {
  dx = (sin(y)-b*x)*dt;
  dy = (sin(z)-b*y)*dt;
  dz = (sin(x)-b*z)*dt;

  x = x + dx;
  y = y + dy;
  z = z + dz;

  PVector newP = new PVector(x, y, z);
  if (points.size() == 0 ||
    //points.size() < 100000 &&
    PVector.dist(points.get(points.size() - 1), newP) > 0.05) {
    points.add(newP);
  }
}
