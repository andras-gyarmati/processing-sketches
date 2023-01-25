abstract class Movable implements GameElement {
  protected float speed, size;
  protected PVector pos, direction;

  Movable (float x, float y, PVector direction, float speed, float size) {
    pos = new PVector(x, y); 
    this.direction = direction;
    this.speed = speed;
    this.size = size;
  }

  public void move() {
    PVector vel = direction.copy().mult(speed);
    pos.set(min(width - size, max(0, pos.x + vel.x)), min(height - size, max(0, pos.y + vel.y)));
  }
}