class Pickable {

  String name;
  float prob;
  float relProb;
  int picked;

  Pickable(String name, float prob) {
    this.name = name;
    this.prob = prob;
    //relProb = 0;
    picked = 0;
  }
  
}