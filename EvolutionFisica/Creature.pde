class Creature {

  ArrayList<Knob> knobs;
  ArrayList<Muscle> muscles;
  String name;
  float fitness;
  float relProb;
  float startPosition;
  float finishPosition;
  float mutationAmount;

  private Creature() {
    fitness = 0;
    relProb = 0;
    mutationAmount = 0.3;
  }

  //Creature(boolean debug) {
  //  this();
  //  knobs = new ArrayList<Knob>();
  //  muscles = new ArrayList<Muscle>();

  //  knobs.add(new Knob(350, 420, /*density*/ 1, /*friction*/ 0, /*restitution*/ 0, /*radius*/ 6));
  //  knobs.add(new Knob(220, 550, /*density*/ 1, /*friction*/ 1, /*restitution*/ 0, /*radius*/ 6));
  //  knobs.add(new Knob(390, 550, /*density*/ 1, /*friction*/ 0, /*restitution*/ 0, /*radius*/ 6));

  //  muscles.add(new Muscle(knobs.get(0), knobs.get(1), /*Hz*/ 1, /*damping*/ 1));
  //  knobs.get(0).addPair(knobs.get(1));

  //  muscles.add(new Muscle(knobs.get(1), knobs.get(2), /*Hz*/ 1, /*damping*/ 1));
  //  knobs.get(1).addPair(knobs.get(2));

  //  muscles.add(new Muscle(knobs.get(2), knobs.get(0), /*Hz*/ 1, /*damping*/ 1));
  //  knobs.get(2).addPair(knobs.get(0));
  //}
  
  Creature(boolean debug) {
    this();
    knobs = new ArrayList<Knob>();
    muscles = new ArrayList<Muscle>();

    knobs.add(new Knob(350, 420, /*density*/ 10, /*friction*/ 10, /*restitution*/ 0, /*radius*/ 6));
    knobs.add(new Knob(220, 550, /*density*/ 10, /*friction*/ 0, /*restitution*/ 0, /*radius*/ 6));
    knobs.add(new Knob(390, 550, /*density*/ 10, /*friction*/ 10, /*restitution*/ 0, /*radius*/ 6));

    muscles.add(new Muscle(knobs.get(0), knobs.get(1), /*Hz*/ 1, /*damping*/ 1));
    knobs.get(0).addPair(knobs.get(1));

    muscles.add(new Muscle(knobs.get(1), knobs.get(2), /*Hz*/ 1, /*damping*/ 1));
    knobs.get(1).addPair(knobs.get(2));

    muscles.add(new Muscle(knobs.get(2), knobs.get(0), /*Hz*/ 0, /*damping*/ 0));
    knobs.get(2).addPair(knobs.get(0));
  }  

  Creature(ArrayList<Knob> knobs, ArrayList<Muscle> muscles) {
    this();
    this.knobs = knobs;
    this.muscles = muscles;
  }

  Creature(int knobCount, int muscleCount) {
    this();
    knobs = new ArrayList<Knob>();
    muscles = new ArrayList<Muscle>();
    for (int i = 0; i < knobCount; i++) {
      knobs.add(new Knob(random(210, 400), random(410, 640), random(1), random(1), random(1), random(12, 17)));
    }
    for (int i = 0; i < min(max(knobCount, muscleCount), (knobCount * (knobCount - 1)) / 2); i++) {
      Knob k1 = null;
      Knob k2 = null;
      while (k2 == null) {
        k1 = pickRandomKnobWithLeastConnections();
        Knob knob = pickRandomKnobWithLeastConnections();
        if (k1 != knob && !k1.pairs.contains(knob)) {
          k2 = knob;
        }
      }
      muscles.add(new Muscle(k1, k2, random(1), random(1)));
      k1.addPair(k2);
    }
  }

  Knob pickRandomKnobWithLeastConnections() {
    float[] relProbs = new float[knobs.size()];
    Knob knob = null;
    boolean found = false;
    while (!found) {
      float sum = 0;
      for (Knob k : knobs) {
        sum += subFromHundred(k.pairs.size());
      }
      for (int i = 0; i < knobs.size(); i++) {
        relProbs[i] = subFromHundred(knobs.get(i).pairs.size()) / sum;
      }
      float picker = random(1);
      int i = 0;
      while (picker > 0 && i < knobs.size()) {
        picker -= relProbs[i];
        i++;
      }
      i--;
      if (picker < 0) {
        knob = knobs.get(i);
        found = true;
      }
    }
    return knob;
  }

  private float subFromHundred(float num) {
    return 100 - num;
  }

  void destroy() {
    for (Knob k : knobs) {
      k.destroy();
    }
    for (Muscle m : muscles) {
      m.destroy();
    }
  }

  void create() {
    for (Knob k : knobs) {
      k.create();
    }
    for (Muscle m : muscles) {
      m.create();
    }
  }

  void display() {
    for (Knob k : knobs) {
      k.display();
    }
    for (Muscle m : muscles) {
      m.move();
      m.display();
    }
    calcFitness();
  }

  Creature newOffspring() {
    Creature offspring = new Creature((ArrayList<Knob>)this.knobs.clone(), (ArrayList<Muscle>)this.muscles.clone());
    mutate(offspring);
    return offspring;
  }

  Creature newOffspring(Creature creature) {
    Creature offspring = new Creature((ArrayList<Knob>)this.knobs.clone(), (ArrayList<Muscle>)this.muscles.clone());
    //TODO add mixing the genes
    mutate(offspring);
    return offspring;
  }

  void mutate(Creature offspring) { //knob hozzaadas elvetel, muscle hozzaadas elvetel
    for (Knob k : offspring.knobs) {
      if (random(1) < mutationRate) {
        k.density = randomMutationAmount(k.density);
      }
      if (random(1) < mutationRate) {
        k.friction = randomMutationAmount(k.friction);
      }
      if (random(1) < mutationRate) {
        k.restitution = randomMutationAmount(k.restitution);
      }
    }
    for (Muscle m : offspring.muscles) {
      if (random(1) < mutationRate) {
        m.frequencyHz = randomMutationAmount(m.frequencyHz);
      }
      if (random(1) < mutationRate) {
        m.dampingRatio = randomMutationAmount(m.dampingRatio);
      }
    }
  }

  private float randomMutationAmount(float currentAmount) {
    return max(0, min(1, currentAmount + random(-mutationAmount, mutationAmount)));
  }

  void calcFitness() {
    for (Knob k : knobs) {
      if (k.getPos().x > fitness) {
        fitness = k.getPos().x;
      }
    }
    float sumY = 0;
    for (Knob k : knobs) {
      sumY += k.getPos().y;
    }
    if (sumY / knobs.size() > 610) { //TODO y avg magassagara atirni
      fitness = 0;
      println("knob Y avg: " + sumY / knobs.size());
    }
    println("fitness: " + fitness);
  }
}