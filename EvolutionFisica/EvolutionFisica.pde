import fisica.*;

FWorld world;
Terrain terrain;
float mutationRate;
int populationSize;
float time;
Slider slider;

/*
save, load, knob es muscle eltunes es uj novesztese, tobb dolog is tudjon mutalodni rajtuk 
es minden egyes dolog kulon lehetoseggel mutalodjon, jobb kivalogatas kell
*/

void setup() {
  //size(1920, 1080, P2D);
  size(1280, 720, P2D);
  colorMode(HSB);
  Fisica.init(this);
  world = new FWorld();
  populationSize = 1000;
  mutationRate = 0.05;
  terrain = new Terrain(populationSize);
  time = 0;
  slider = new Slider(370, 120, 700, 20);
}

void draw() {
  background(156, 100, 150);
  for (int i = 0; i < slider.getValue(); i++) {
    world.step();
    time += 0.1;
    terrain.step();
  }
  terrain.display();
  world.draw();
  slider.display();
}

void mouseDragged() {
  slider.update(new PVector(mouseX, mouseY));
}