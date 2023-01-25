Pickable[] ps;

void setup() {
  ps = new Pickable[7];
  for (int i = 0; i < ps.length; i++) {
    ps[i] = new Pickable(""+(char)(random(97, 123)), random(10));
  }
  noLoop();
} 

void draw() {
  for (int i = 0; i < 100000; i++) {
    Calculate();
  }
  for (Pickable p : ps) {
    print(p.name + ": ");
    print(p.prob + " ");
    print(p.relProb + " ");
    println(p.picked);
  }
}

void Calculate() {
  float[] relProbs = new float[ps.length];
  float sum = 0;
  for (Pickable p : ps) {
    sum += p.prob;
  }
  //for (Pickable p : ps) {
  //  p.relProb = p.prob / sum;
  //}
  for (int i = 0; i < ps.length; i++) {
    relProbs[i] = ps[i].prob / sum;
    ps[i].relProb = relProbs[i];
  }
  float picker = random(1);
  int i = 0;
  while (picker > 0 && i < ps.length) {
    //picker -= ps[i].relProb;
    picker -= relProbs[i];
    i++;
  }
  i--;
  if (picker < 0) {
    ps[i].picked++;
  }
}