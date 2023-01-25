Game game;
color bgColor, ballColor, sliderColor, brickColor;

void setup() {
  size(540, 920);
  colorMode(HSB);
  noStroke();
  game = new Game();
  bgColor = color(220, 0, 255);
  ballColor = color(0, 0, 0);
  sliderColor = color(150, 255, 0);
  brickColor = color(20, 255, 255);
}

void draw() {
  background(bgColor);
  game.update();
  game.display();
}

void mousePressed() {
  game.startBall();
}

void mouseDragged() {
  game.slider.update(mouseX);
}