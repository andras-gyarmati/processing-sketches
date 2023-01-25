Space space;

void setup () {
  size(800, 800);
  space = new Space();
  //frameRate(3);
}

void draw () {
  background(255);
  space.update();
  space.show();
  //saveFrame("gif/osmosis-######.png");
}

void mouseReleased() {
  space.spawnNewOrbAtMousePos();
}
