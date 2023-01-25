class Game {

  ArrayList<Brick> bricks;
  Ball ball;
  Slider slider;
  int playerLife, padding;

  Game() {
    int cols = 7;
    int rows = 10;
    padding = 10;
    int w = width / cols;
    int h = height / 2 / rows;
    bricks = new ArrayList<Brick>();
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        bricks.add(new Brick(new PVector(x * (width / cols) + padding, y * (height / 2 / rows) + padding), w - padding, h - padding, 3));
      }
    }
    slider = new Slider();
    int radius = 25;
    ball = new Ball(new PVector(width/2, slider.pos.y - radius), radius);
    playerLife = 3;
  }

  void startBall() {
    ball.start();
  }

  void update() {
    ball.update();
        for (Brick b : bricks) {
          if (b.life == 0) {
            b.destroy();
          }
        }
    if (ball.pos.y > slider.pos.y) {
      playerLife -= 1;
      ball.reset(slider);
    }
  }

  void display() {
    for (Brick b : bricks) {
      b.display();
    }
    ball.display();
    slider.display();
    textSize(30);
    text(playerLife, width/2, height - 20);
  }
}