ArrayList<Bubble> bs;
float time, bubbleSpeedSclae, spawnSpeed;

void setup() {
  //fullScreen();
  size(720, 960);
  colorMode(HSB);
  bs = new ArrayList<Bubble>();
  time = 0;
  bubbleSpeedSclae = 2;
  spawnSpeed = 1;
}

void tick() {
  if (time > 1/spawnSpeed) {
    time = 0;
    float size = random(20)+80;
    int hue = floor(random(255));
    bs.add(new Bubble(random(width-size/2)+size/2, 
    height + size/2 + random(130), hue, size, 
    bubbleSpeedSclae));
  }
  time++;
  checkMerge();
}

Bubble merge(Bubble b1, Bubble b2) {
  float x = (b1.pos.x + b2.pos.x) / 2;
  float y = (b1.pos.y + b2.pos.y) / 2;
  color hue = floor((b1.hue * b1.size + b2.hue * b2.size) / (b1.size + b2.size));
  float size = min(width, (float)Math.cbrt(pow(b1.size, 3) + pow(b2.size, 3)));
  float speedScale = (b1.speedScale + b2.speedScale) / 2;
  Bubble merged = new Bubble(x, y, hue, size, speedScale);
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
  touch();
}

void mouseDragged() {
  touch();
}

void touch() {
  for (int i = bs.size() - 1; i >= 0; i--) {
    Bubble b = bs.get(i);
    if (PVector.dist(b.pos, new PVector(mouseX, mouseY)) < b.size/3 && !b.popping) {
      b.pop();
    }
  }
}

void draw() {
  background(0, 0, 40);
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
