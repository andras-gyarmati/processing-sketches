class Muscle {

  Knob k1;
  Knob k2;
  float frequencyHz; 
  float dampingRatio;
  DistanceJoint dj;
  float len;
  float moveScale;
  float timer;

  Muscle(Knob k1, Knob k2, float frequencyHz, float dampingRatio) {
    this.k1 = k1;
    this.k2 = k2;
    this.frequencyHz = frequencyHz; 
    this.dampingRatio = dampingRatio;
  }
  void create() {
    moveScale = 0.7;
    len = k1.body.getPosition().clone().subLocal(k2.body.getPosition()).length();

    DistanceJointDef djd = new DistanceJointDef();
    djd.bodyA = k1.body;
    djd.bodyB = k2.body;
    djd.length = len;
    djd.frequencyHz = frequencyHz;  
    djd.dampingRatio = dampingRatio;
    dj = (DistanceJoint) box2d.world.createJoint(djd);
    timer = random(1);
  }

  void destroy() {
    //??
  }

  void display() {
    Vec2 pos1 = box2d.getBodyPixelCoord(k1.body);
    Vec2 pos2 = box2d.getBodyPixelCoord(k2.body);
    stroke(0, map(dj.getDampingRatio(), 0, 1, 255, 10), 255, 180);
    strokeWeight(map(dj.getFrequency(), 0, 1, 10, 20));
    line(pos1.x, pos1.y, pos2.x, pos2.y);
  }

  void move() {
    dj.setLength(map(sin(timer), -1, 1, len * moveScale, len / moveScale));
    timer += 0.1;
  }
}