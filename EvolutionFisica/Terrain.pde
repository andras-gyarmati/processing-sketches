class Terrain {

  ArrayList<Boundary> boundaries;
  Population population;
  int popCount;
  //Population nextPopulation;

  Terrain(int populationSize) {
    boundaries = new ArrayList<Boundary>();
    boundaries.add(new Boundary(width/2, height-45, width * 10, 90));
    population = new Population(populationSize);
    popCount = 0;
    //nextPopulation = new Population(populationSize);
  }

  //void newPopulation() {
  //  nextPopulation = population.reproduce();
  //}

  void display() {
    for (Boundary b : boundaries) {
      b.display();
    }
    displayPopCount();
    population.display();
  }

  void displayPopCount() {
    textSize(30);
    fill(0);
    text("population: #" + popCount, 100, 200);
  }

  void step() { //<>// //<>//
    population.step();
    if (population.creatureCount == population.creatures.size()) {
      population = population.reproduce();
      popCount++;
    }
  }
}