Terrain terrain;
float mutationRate;
int populationSize;
float time;

void setup() {
  size(1000, 1000);
  populationSize = 100;
  mutationRate = 0.05;
  terrain = new Terrain(populationSize);
  time = 0;
}

void draw() {
  background(200);
  time += 0.1;
  terrain.step();
  terrain.display();
}
