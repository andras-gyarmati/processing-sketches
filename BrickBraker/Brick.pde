class Brick {
  
  PVector pos;
  int life, maxLife;
  int w, h;
  
  Brick(PVector pos, int w, int h, int life) {
    this.pos = pos;
    this.w = w;
    this.h = h;
    this.life  = life;
    maxLife = life;
  }
  
  void display() {
    if (life > 0) {
      int brightness = floor(map(life, 0, maxLife, 0, 255));
      fill(brickColor, 255, brightness);
      rect(pos.x + 1, pos.y + 1, w - 2, h - 2, 5);
    }
  }
  
  void damage() {
    life -= 1;
  }
}