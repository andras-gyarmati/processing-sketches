class Bubble {
  color color_;
  float size, speed;
  PVector vel, pos;
  boolean popped, popping;
  ArrayList<PVector> popInner, popOuter, popDirections;
  int lines, popRes;

  Bubble(float x, float y, color color_, float size, float speed) {
    pos = new PVector(x, y);
    this.color_ = color_;
    this.size = size;
    this.speed = speed;
    vel = new PVector(random(speed*2)-speed, -speed);
    popping = false;
    popped = false;
    popRes = 15;
    lines = 7;
  }

  void pop() {
    popInner = new ArrayList<PVector>();
    popOuter = new ArrayList<PVector>();
    popDirections = new ArrayList<PVector>();
    PVector popDirection = new PVector(0, size/2/popRes);
    PVector popCenter = pvcopy(pos);
    for (int i = 0; i < lines; i++) {
      popDirection.rotate(PI*2/lines);
      popDirections.add(pvcopy(popDirection));
      //popCenter.set(pos.x, pos.y);
      popCenter.add(popDirection);
      //PVector tmpPopInner = new PVector(popCenter.x + popDirection.x, popCenter.y + popDirection.y); 
      popInner.add(pvcopy(popCenter).add(pvcopy(popDirection).mult(3)));
      //PVector tmpPopOuter = new PVector(tmpPopInner.x + popDirection.x, tmpPopInner.y + popDirection.y); 
      popOuter.add(pvcopy(popCenter).add(pvcopy(popDirection).mult(3)));
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
    vel.set(random(speed*2)-speed, -speed);
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
    strokeWeight(10);
    stroke(color_, 255, 255, 220);
    fill(color_, 255, 255, 155);
    ellipse(pos.x, pos.y, size/2, size/2);
  }

  void displayPop() {
    strokeWeight(10);
    stroke(color_, 255, 255, 220);
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