class Muscle {

  Knob k1, k2;
  PVector pos1, pos2;
  float frequencyHz; 
  float dampingRatio;
  FDistanceJoint dj;
  float len;
  float moveScale;
  float timer;

  Muscle(Knob k1, Knob k2, float frequencyHz, float dampingRatio) {
    this.k1 = k1;
    this.k2 = k2;
    this.frequencyHz = frequencyHz; 
    this.dampingRatio = dampingRatio;
    pos1 = new PVector();
    pos2 = new PVector();
  }

  void create() {
    moveScale = 0.7;
    dj = new FDistanceJoint(k1.body, k2.body);
    dj.setFrequency(frequencyHz);
    dj.setDamping(dampingRatio);
    world.add(dj);
    timer = random(1);
    updatePos();
    len = PVector.dist(pos1, pos2);
  }

  void destroy() {
    //??
  }

  private void updatePos() {
    pos1.set(k1.body.getX(), k1.body.getY());
    pos2.set(k2.body.getX(), k2.body.getY());
  }

  void display() {
    updatePos();
    stroke(0, map(dampingRatio, 0, 1, 255, 10), 255, 180);
    strokeWeight(map(frequencyHz, 0, 1, 10, 20));
    line(pos1.x, pos1.y, pos2.x, pos2.y);
  }

  void move() {
    dj.setLength(map(sin(timer), -1, 1, len * moveScale, len / moveScale));
    //dj.setLength((sin(timer) + 1 )* 100);
    timer += 0.1;
  }
}