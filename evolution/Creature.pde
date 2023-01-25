class Creature {
  String name;
  float fitness;
  float startFitness;
  float relProb;
  float startPosition;
  float finishPosition;
  float mutationAmount;

  private Creature() {
    fitness = 0;
    relProb = 0;
    mutationAmount = 0.3;
  }

  void destroy() {
    // do we need this?
  }

  void create() {
    
    startFitness = 0;
  }

  void display() {

  }

  void move() {
    
    calcFitness(); // todo: move this from here
  }

  Creature newOffspring() {
    Creature offspring = new Creature();
    mutate(offspring);
    return offspring;
  }

  void mutate(Creature offspring) { 
    
  }

  private float randomMutationAmount(float currentAmount) {
    return max(0, min(1, currentAmount + random(-mutationAmount, mutationAmount)));
  }

  void calcFitness() {
    
  }
}
