import queasycam.*;

float radius;
int gridSize, detail;
QueasyCam  cam;
ArrayList<PVector> shape;
PVector xx, yy, zz;

void setup() {
  size(600, 600, P3D);
  cam = new QueasyCam(this);
  cam.speed = 0.005;
  cam.sensitivity = 0.5;
  gridSize = 600;
  shape = new ArrayList<PVector>();
  shape.add(new PVector(0, 100, 0));
  shape.add(new PVector(100, 100, 0));
  shape.add(new PVector(50, 100, 100));
  xx = new PVector(1, 0, 0); 
  yy = new PVector(0, 1, 0); 
  zz = new PVector(0, 0, 1);
  detail = 5;
}

void draw() {
  pushMatrix();
  translate(0, gridSize / 3, 0);
  background(80);
  stroke(200);
  for (int i = -gridSize; i <= gridSize; i+= gridSize / 20) {
    line(i, 0, gridSize, i, 0, -gridSize);
    line(-gridSize, 0, i, gridSize, 0, i);
  }
  popMatrix();

  float angle = 360 / detail;

  strokeWeight(5);
  stroke(255, 0, 0);
  line(0, 0, 0, xx.x * 10, xx.y, xx.z);
  stroke(0, 255, 0);
  line(0, 0, 0, yy.x, yy.y * 10, yy.z);
  stroke(0, 0, 255);
  line(0, 0, 0, zz.x, zz.y, zz.z * 10);
  
  stroke(255, 255, 0);
  strokeWeight(2);
  noFill();
  
  beginShape();
  for (int j = 0; j < shape.size() - 1; j++) {
    vertex(shape.get(j).x, shape.get(j).y, shape.get(j).z);
    
    PVector diff = shape.get(j + 1).sub(shape.get(j));
    //float angleX = PVector.angleBetween(xx, new PVector(diff.x, 0, 0));
    //float angleY = PVector.angleBetween(yy, new PVector(0, diff.y, 0));
    //float angleZ = PVector.angleBetween(zz, new PVector(0, 0, diff.z));
    diff.rotate(HALF_PI);
    diff.normalize();
    pushMatrix();
    
    translate(shape.get(j).x, shape.get(j).y, shape.get(j).z);
    //translate(diff.x, diff.y, diff.z);
    
    //rotateX(angleX);
    //rotateY(angleY);
    //rotateZ(angleZ);
    for (int i = 0; i < detail; i++) {
      float x = cos(radians(i * angle)) * radius;
      float y = sin(radians(i * angle)) * radius;
      float z = tan(radians(i * angle)) * radius;
      vertex(x, y, z);
      stroke(255, 0, 255);
      vertex(diff.x, diff.y, diff.z);
    }
    popMatrix();
  }
  endShape();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    cam.speed *= 0.1;
    //asd += asdasd;
  } else if (mouseButton == RIGHT) {
    //asd -= asdasd;
    cam.speed *= 5;
  } else {
    cam.position = new PVector(0, 0, 0);
    cam.speed = 2;
  }
}