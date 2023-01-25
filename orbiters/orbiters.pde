import com.hamoid.*; //<>//

VideoExport videoExport;
Orbit[][] grid;
int cols, rows, scaler;
PVector center;

void setup() {
  size(200, 200, P2D);
  videoExport = new VideoExport(this);
  videoExport.setFrameRate(60);
  videoExport.startMovie();
  ellipseMode(CENTER);
  scaler = 10;
  cols = width / scaler;
  rows = height / scaler;
  grid = new Orbit[cols][rows];
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      grid[x][y] = 
        new Orbit(new PVector((x+1)*scaler-scaler/2, 
        (y+1)*scaler-scaler/2));
    }
  }
  center = new PVector(width/2, height/2);
}

void draw() {
  background(200);
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      grid[x][y].display();
      grid[x][y].update();
    }
  }
  //videoExport.saveFrame();
  //saveFrame("output/frame####.png");
}

void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}
