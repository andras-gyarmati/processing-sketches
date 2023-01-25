class Bubble {
  int hue;
  float size, speedScale, speed;
  PVector vel, pos;
  boolean popped, popping;
  ArrayList<PVector> popInner, popOuter, popDirections;
  int lines, popRes;
  float a = 0.01;
  float treshold = 0.8;

  Bubble(float x, float y, int hue, float size, float speedScale) {
    pos = new PVector(x, y);
    this.hue = hue;
    this.size = size;
    this.speedScale = speedScale;
    speed = speedScale * size / 100;
    vel = new PVector(0, -speed);
    popping = false;
    popped = false;
    popRes = 10;
    lines = 7;
  }

  void pop() {
    popInner = new ArrayList<PVector>();
    popOuter = new ArrayList<PVector>();
    popDirections = new ArrayList<PVector>();
    PVector popDirection = new PVector(0, (float)size/2/popRes);
    PVector popCenter = pvcopy(pos);
    for (int i = 0; i < lines; i++) {
      popDirection.rotate(PI*2/lines);
      popDirections.add(pvcopy(popDirection));
      popCenter.add(popDirection);
      PVector tmp = pvcopy(popCenter);
      PVector dirMult = pvcopy(popDirection);
      dirMult.mult(3);
      tmp.add(dirMult);
      popInner.add(tmp);
      popOuter.add(pvcopy(tmp));
    }
    popping = true;
  }

  void update() {
    if (popping) {
      updatePop();
    } else {
      updateBubble();
    }
  }

  void updateBubble() {
    vel.rotate(a);
    if (vel.x > treshold || vel.x < -1*treshold) {
      a *= -1;
    }
    pos.add(vel);
  }

  void updatePop() {
    if (PVector.dist(popOuter.get(popOuter.size() - 1), pos) < size/4) {
      for (int i = 0; i < popOuter.size(); i++) {
        popOuter.get(i).add(popDirections.get(i));
      }
    } else {
      for (int i = 0; i < popInner.size(); i++) {
        popInner.get(i).add(popDirections.get(i));
      }
    }
    if (PVector.dist(popInner.get(popInner.size() - 1), pos) > size/4) {
      popped = true;
    }
  }

  void display() {
    if (popping) {
      displayPop();
    } else {
      displayBubble();
    }
  }

  void displayBubble() {
    strokeWeight(4);
    stroke(hue, 255, 255, 200);
    fill(hue, 255, 255, 140);
    ellipse(pos.x, pos.y, size/2, size/2);
  }

  void displayPop() {
    strokeWeight(size/25);
    stroke(hue, 155, 255, 220);
    for (int i = 0; i < popOuter.size(); i++) {
      PVector po = popOuter.get(i);
      PVector pi = popInner.get(i);
      line(po.x, po.y, pi.x, pi.y);
    }
  }
}

PVector pvcopy(PVector p) {
  return new PVector(p.x, p.y);
}
