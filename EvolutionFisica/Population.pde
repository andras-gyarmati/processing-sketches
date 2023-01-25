class Population {

  ArrayList<Creature> creatures;
  Creature currentCreature;
  int lifeLength;
  int creatureCount;

  private Population() {
    lifeLength = 100;
    creatureCount = 0;
  }

  Population(ArrayList<Creature> creatures) {
    this();
    this.creatures = creatures;
    currentCreature = creatures.get(0); //<>//
    currentCreature.create();
  }

  Population(int size) {
    this();
    creatures = new ArrayList<Creature>();
    for (int i = 0; i < size; i++) {
      //creatures.add(new Creature(floor(random(3, 3)), floor(random(3, 36))));
      creatures.add(new Creature(true));
    }
    currentCreature = creatures.get(0);
    currentCreature.create();
  }

  //Population reproduce() { //fitness alapján random kiválasztani a felét, a többit pótolni örökítéssel.
  //  Population nextPopulation;
  //  ArrayList<Creature> nextCreatures = new ArrayList<Creature>();
  //  for (int i = 0; i < this.creatures.size(); i++) {
  //    nextCreatures.add(this.creatures.get(i).newOffspring());
  //  }
  //  nextPopulation = new Population(nextCreatures);
  //  return nextPopulation;
  //}

  Population reproduce() {
    return new Population(pickByFitness());
  }

  ArrayList<Creature> pickByFitness() {
    ArrayList<Creature> picked = new ArrayList<Creature>(); //<>// //<>//
    for (int j = 0; j < creatures.size(); j++) {
      float sum = 0;
      for (Creature c : creatures) {
        sum += c.fitness;
      }
      for (Creature c : creatures) {
        c.relProb = c.fitness / sum;
      }
      float picker = random(1);
      int i = 0;
      while (picker > 0 && i < creatures.size()) {
        picker -= creatures.get(i).relProb;
        i++;
      }
      i--;
      if (picker < 0) {
        Creature c = creatures.get(i);
        picked.add(c.newOffspring());
      }
    }
    return picked; //<>// //<>//
  }

  void display() {
    displayCurrent();
    displayTime();
    displayCreatureCount();
  }

  void displayCurrent() {
    currentCreature.display();
  }

  void displayTime() {
    textSize(30);
    fill(0);
    text("time: " + floor(time), 100, 100);
  }

  void displayCreatureCount() {
    textSize(30);
    fill(0);
    text("creature: #" + creatureCount, 100, 150);
  }

  void step() {
    if (time > lifeLength) {
      time = 0;
      creatureCount ++;
      currentCreature.destroy();
      if (creatureCount < creatures.size()) {
        currentCreature = creatures.get(creatureCount);
        currentCreature.create();
      }
    }
  }
}