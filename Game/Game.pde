Player player;
PVector startPos;
PVector endPos;

void setup() {
  size(540, 920);
  player = new Player("Andris", 3, 10, new PVector(width/2, height/2));
  startPos = new PVector();
  endPos = new PVector();
}

void draw() {
  background(51);
  player.display();
}

void mousePressed() {
  startPos.set(mouseX, mouseY);
}

void mouseReleased() {
  endPos.set(mouseX, mouseY);
  if (10 > startPos.dist(endPos)) {
    player.shoot();
  } else {
    player.move(endPos.copy().sub(startPos).setMag(1));
  }
}