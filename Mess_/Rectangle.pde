class Rectangle {
  float x, y, w, h;
  Rectangle(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  boolean contains(Ball ball) {
    return (ball.pos.x >= this.x - this.w &&
      ball.pos.x <= this.x + this.w &&
      ball.pos.y >= this.y - this.h &&
      ball.pos.y <= this.y + this.h);
  }

  boolean intersects(Rectangle range) {
    return !(range.x - range.w > this.x + this.w ||
      range.x + range.w < this.x - this.w ||
      range.y - range.h > this.y + this.h ||
      range.y + range.h < this.y - this.h);
  }
}
