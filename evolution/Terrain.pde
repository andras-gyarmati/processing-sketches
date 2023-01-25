class Terrain {

  Population population;
  int popCount;

  Terrain(int populationSize) {
    population = new Population(populationSize);
    popCount = 0;
  }

  void display() {
    pushMatrix();
    translate(width / 2 - population.currentCreature.fitness, 0);
    population.display();
    popMatrix();
    displayPopCount();
  }

  void displayPopCount() {
    textSize(30);
    fill(0);
    text("population: #" + popCount, 100, 200);
  }

  void step() {
    population.step();
    if (population.creatureCount == population.creatures.size()) {
      population = population.reproduce();
      popCount++;
    }
  }
}
