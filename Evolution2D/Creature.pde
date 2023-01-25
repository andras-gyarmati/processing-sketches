class Creature {

  ArrayList<Knob> knobs;
  ArrayList<Muscle> muscles;
  String name;
  float fitness;
  float startFitness;
  float relProb;
  float startPosition;
  float finishPosition;
  float mutationAmount;
  float maxPhysicsValue;
  float minKnobRadius;
  float maxKnobRadius;
  //float displayOffset;

  private Creature() {
    fitness = 0;
    relProb = 0;
    mutationAmount = 0.3;
    minKnobRadius = 12;
    maxKnobRadius = 17;
    maxPhysicsValue = 1;
    //displayOffset = width/2;
  }

  Creature(ArrayList<Knob> knobs, ArrayList<Muscle> muscles) {
    this();
    this.knobs = knobs;
    this.muscles = muscles;
  }

  Creature(int knobCount, PVector minSpawnPos, PVector maxSpawnPos) {
    this();
    knobs = new ArrayList<Knob>();
    muscles = new ArrayList<Muscle>();
    for (int i = 0; i < knobCount; i++) {
      knobs.add(new Knob(random(minSpawnPos.x, minSpawnPos.y), random(maxSpawnPos.x, maxSpawnPos.y), random(maxPhysicsValue), random(maxPhysicsValue), random(maxPhysicsValue), random(minKnobRadius, maxKnobRadius)));
    }
    for (int i = 0; i < random(knobCount, (knobCount * (knobCount - 1)) / 2); i++) {
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
    line(minSpawnPos.x, minSpawnPos.y, maxSpawnPos.x-minSpawnPos.x, maxSpawnPos.y-minSpawnPos.y);
  }

  Knob pickRandomKnobWithLeastConnections() {
    float[] relProbs = new float[knobs.size()];
    Knob knob = null;
    boolean found = false;
    while (!found) {
      float sum = 0;
      for (Knob k : knobs) {
        sum += helperFunction(k.pairs.size());
      }
      for (int i = 0; i < knobs.size(); i++) {
        relProbs[i] = helperFunction(knobs.get(i).pairs.size()) / sum;
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

  private float helperFunction(float num) {
    return pow(2, -num);
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
    startFitness = avgX();
  }

  void display() {

    for (Knob k : knobs) {
      k.display();
    }
    for (Muscle m : muscles) {
      m.display();
    }

    displayFitness();

    noStroke();
    fill(0);
  }

  void move() {
    for (Muscle m : muscles) {
      m.move();
    }
    calcFitness();
  }

  void displayFitness() {
    noStroke();
    fill(0);
    text(fitness, 0, 300);
  }

  Creature newOffspring() {
    Creature offspring = new Creature((ArrayList<Knob>)this.knobs.clone(), (ArrayList<Muscle>)this.muscles.clone());
    mutate(offspring);
    return offspring;
  }

  //TODO knob hozzaadas elvetel, muscle hozzaadas elvetel
  void mutate(Creature offspring) { 
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
    float highestKnobHeight = 0;
    float lowestKnobHeight = height;
    float midKnobHeight;
    for (Knob k : knobs) {
      if (k.getPos().y > highestKnobHeight) {
        highestKnobHeight = k.getPos().y;
      }
      if (k.getPos().y < lowestKnobHeight) {
        lowestKnobHeight = k.getPos().y;
      }
    }
    midKnobHeight = highestKnobHeight - lowestKnobHeight;
    if (midKnobHeight > maxKnobRadius - minKnobRadius) {
      println("avgY: " + midKnobHeight);
      fitness = avgX() - startFitness;
    } /*else {
     fitness = 0;
     }*/
    println("f: " + fitness);
  }

  private float avgX() {
    float sumX = 0;
    for (Knob k : knobs) {
      sumX += k.getPos().x;
    }
    return fitness = sumX / knobs.size();
  }
}
