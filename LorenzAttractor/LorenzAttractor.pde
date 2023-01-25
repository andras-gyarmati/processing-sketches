import queasycam.*;

float x = 0.01;
float y = 0;
float z = 0;
float a = 10;
float b = 28;
float c = 8.0/3.0;
ArrayList<PVector> points = new ArrayList<PVector>();
QueasyCam cam;

void setup() {
  size(1000, 1000, P3D);
  surface.setLocation(10, 10);  
  colorMode(HSB);
  cam = new QueasyCam(this);
  cam.speed = 1;
  cam.sensitivity = 0.5;

  setCamParams();

  strokeWeight(2);
  smooth(8);
  noFill();
}

void setCamParams() {
  cam.tilt = 0.3801326;
  cam.pan = 2.4567263;
  cam.position = new PVector(95.66582, -21.381348, -20.327667);
}

void draw() {
  background(0);
  setCamParams();

  float dt = 0.01;
  float dx = (a * (y - x))*dt;
  float dy = (x * (b - z) - y)*dt;
  float dz = (x * y - c * z)*dt;
  x = x + dx;
  y = y + dy;
  z = z + dz;
  points.add(new PVector(x, y, z));

  translate(0, 20, 0); //??
  scale(2); //??

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

  //println("cam tilt: " + cam.tilt);
  //println("cam pan: " + cam.pan);
  //println("cam pos: " + cam.position);
  //println("cam speed: " + cam.speed);
  //println();
  //saveFrame("c:/lorenz/out/#####.png");
}

void mousePressed() {
  if (mouseButton == LEFT) {
    cam.speed *= 0.1;
  } else if (mouseButton == RIGHT) {
    cam.speed *= 5;
  } else {
    cam.position = new PVector(points.get(0).x, points.get(0).y, points.get(0).z);
    cam.speed = 2;
  }
}

//void drawSpiral  ( int sides, float r1, float r2, float h)
//{
//  float angle = 360 / sides;
//  float halfHeight = h / 2;
//  beginShape();
//  for (int i = 0; i < sides; i++) {
//    float x = cos( radians( i * angle ) ) * r1;
//    float y = sin( radians( i * angle ) ) * r1;
//    vertex( x, y, -halfHeight);
//  }
//  endShape(CLOSE);
//}
