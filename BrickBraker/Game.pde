class Game {

  ArrayList<Brick> bricks;
  Ball ball;
  Slider slider;
  int life, score, offset;

  Game() {
    offset = 35;
    int cols = 6;
    int rows = 10;
    int w = width / cols;
    int h = height / 2 / rows;
    bricks = new ArrayList<Brick>();
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        bricks.add(new Brick(new PVector(x * (width / cols), y * (height / 2 / rows) + offset), w, h, 3));
      }
    }
    slider = new Slider();
    int size = 50;
    ball = new Ball(new PVector(width / 2, slider.pos.y - size / 2), size, offset);
    life = 3;
    score = 0;
  }

  void startBall() {
    ball.start();
  }

  void update() {
    ball.update(slider, bricks);
    if (ball.pos.y > slider.pos.y) {
      life -= 1;
      ball.reset(slider);
    }
  }

  void display() {
    for (Brick b : bricks) {
      b.display();
    }
    ball.display();
    slider.display();
    displayStatusbar();
  }

  private void displayStatusbar() {
    fill(0, 0, 0);
    textSize(20);
    text("life: " + life + " score: " + score, 10, 25);
  }
}