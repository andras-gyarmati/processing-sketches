private Sphere[][][] grid;
private int size;
PVector tileSize;

public void setup() {
  size(512, 512, P3D);
  size = 10;
  tileSize = new PVector((float)width/size, (float)height/size, (float)height/size);
  grid = new Sphere[size][][];
  for (int i = 0; i < size; i++) {
    grid[i] = new Sphere[size][];
    for (int j = 0; j < size; j++) {
      grid[i][j] = new Sphere[size];
      for (int k = 0; k < size; k++) {
        grid[i][j][k] = new Sphere(new PVector((float)i*tileSize.x, (float)j*tileSize.y, (float)k*tileSize.z));
      }
    }
  }
} //<>//

public void draw() {
  background(220);
  for (Sphere[][] plane : grid) {
    for (Sphere[] array : plane) {
      for (Sphere sphere : array) {
        sphere.display();
      }
    }
  }
}

public class Sphere {
  private PVector pos;
  private PVector rotation;
  private float rotationSpeed;

  public Sphere(PVector pos) {
    this.pos = pos;
    rotation = new PVector(0, 0, 0);
    rotationSpeed = 0.006;
  }

  public void display() {
    stroke(0);
    strokeWeight(6);
    noFill();
    pushMatrix();
    translate(pos.x + tileSize.x/2, pos.y + tileSize.y/2, pos.z + tileSize.z/2);
    rotateX(rotation.x);
    rotateY(rotation.y);
    rotateZ(rotation.z);
    line(0, 0, 0, tileSize.x, tileSize.y, tileSize.z);     
    //ellipse(0, 0, tileSize.x, tileSize.y);
    popMatrix();
    rotation.x += rotationSpeed;
    rotation.y += rotationSpeed*2;
    rotation.z += rotationSpeed*0.5;
  }
}
