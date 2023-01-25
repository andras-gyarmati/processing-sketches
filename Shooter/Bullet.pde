public class Bullet extends Movable {

  public Bullet(float x, float y, PVector direction) {
    super(x, y, direction, 5, 3);
  }

  public void display() {
    noStroke();
    fill(50, 255, 255);
    ellipse(pos.x, pos.y, size, size);
  }
}