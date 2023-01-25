Game game;
PVector movementStartPos;

void setup() {
  size(540, 960);
  colorMode(HSB);
  game = new Game();
}

void draw() {
  background(0);
  game.step();
  game.display();
}

void mousePressed() {
  movementStartPos = new PVector(mouseX, mouseY);
}

void mouseReleased() {
  PVector endPos = new PVector(mouseX, mouseY);
  if (PVector.dist(movementStartPos, endPos) > 150) {
    game.user.setDirection(endPos.sub(movementStartPos));
    game.user.move();
  } else {
    game.user.shoot(new PVector(mouseX, mouseY));
  }
}