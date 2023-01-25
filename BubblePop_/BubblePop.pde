ArrayList<Bubble> bs;
float timer, bubbleSpeedSclae, spawnSpeed;

void setup() {
  fullScreen();
  //size(720, 960);
  colorMode(HSB);
  bs = new ArrayList<Bubble>();
  timer = 0;
  bubbleSpeedSclae = 1.2;
  spawnSpeed = 0.07;
}

void tick() {
  if (timer > 1/spawnSpeed) {
    timer = 0;
    float size = random(200)+150;
    color c = floor(random(255));
    bs.add(new Bubble(random(width-size/2)+size/2, height + size/2, c, size, bubbleSpeedSclae));
  }
  timer++;
  checkMerge();
}

Bubble merge(Bubble b1, Bubble b2) {
  float x = (b1.pos.x + b2.pos.x) / 2;
  float y = (b1.pos.y + b2.pos.y) / 2;
  color color_ = (b1.color_ + b2.color_) / 2;
  float size = (b1.size + b2.size) / 1.5;
  float speedScale = (b1.speedScale + b2.speedScale) / 2;
  Bubble merged = new Bubble(x, y, color_, size, speedScale);
  return merged;
}

void checkMerge() {
  for (int i = bs.size() - 1; i >= 0; i--) {
    Bubble b1 = bs.get(i);
    for (int j = i - 1; j >= 0; j--) {
      Bubble b2 = bs.get(j);
      if (b1.pos.dist(b2.pos) < b1.size/3 && !b1.popping && !b2.popping) {
        bs.add(merge(b1,b2));
        bs.remove(b1);
        bs.remove(b2);
      }
    }
  }
}

void mousePressed() {
  for (int i = bs.size() - 1; i >= 0; i--) {
    Bubble b = bs.get(i);
    if (PVector.dist(b.pos, new PVector(mouseX, mouseY)) < b.size/3 && !b.popping) {
      b.pop();
    }
  }
}

void draw() {
  background(0, 0, 51);
  tick();
  for (int i = bs.size() - 1; i >= 0; i--) {
    Bubble b = bs.get(i);
    if (b.pos.y + b.size < 0 || b.popped) {
      bs.remove(i);
    }
    b.update();
    b.display();
  }
}