Orbit[][] grid; //<>//
int cols, rows, scaler;
PVector center;

void setup() {
  size(700, 700, P2D);
  ellipseMode(CENTER);
  scaler = 20;
  cols = width / scaler;
  rows = height / scaler;
  grid = new Orbit[cols][rows];
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      grid[x][y] = 
        new Orbit(new PVector((x+1)*scaler-scaler/2, (y+1)*scaler-scaler/2));
    }
  }
}

void draw() {
  background(0);
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      grid[x][y].display();
      grid[x][y].update();
    }
  }
  //videoExport.saveFrame();
  //saveFrame("output/frame####.png");
}
