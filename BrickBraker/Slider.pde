class Slider {

  PVector pos;
  int w, h;

  Slider() {
    w = width / 3;
    h = height / 50;
    pos = new PVector(width / 2 - w / 2, height / 1.1);
  }

  void update(float x) {
    pos.x = x - w / 2;
  }

  void display() {
    fill(sliderColor);
    rect(pos.x, pos.y, w, h, 5);
  }
}