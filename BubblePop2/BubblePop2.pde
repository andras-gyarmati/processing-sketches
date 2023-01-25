ArrayList<Bubble> bs;
float timer;
float speed;

void setup() {
  //fullScreen();
  size(720, 960);
  colorMode(HSB);
  bs = new ArrayList<Bubble>();
  timer = 0;
  speed = 5;
}

void tick() {
  if (timer > 30) {
    timer = 0;
    float size = random(20)+260;
    color c = floor(random(255));
    bs.add(new Bubble(random(width-size/2)+size/2, height + size/2, c, size, speed));
  }
  timer++;
}

void mousePressed() {
  for (int i = bs.size() - 1; i >= 0; i--) {
    Bubble b = bs.get(i);
    if (PVector.dist(b.pos, new PVector(mouseX, mouseY)) < b.size/2 && !b.popping) {
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