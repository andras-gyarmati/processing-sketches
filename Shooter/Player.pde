abstract class Player extends Movable {

  protected int life;

  protected Player(float x, float y, float speed, float size) {
    super(x, y, new PVector(0, -1), speed, size);
    this.life = 3;
  }

  public void display() {
    noStroke();
    fill(255, map(life, 3, 0, 0, 255), 255);
    ellipse(pos.x, pos.y, size, size);
  }

  public void shoot(PVector facing) {
    PVector direction = PVector.sub(facing, pos).normalize();
    game.addBullet(new Bullet(pos.x + direction.x * size, pos.y + direction.y * size, direction.copy()));
  }

  public void checkIfHitByBullet(Bullet bullet) {
    if (size > PVector.dist(bullet.pos, pos)) {
      takeDamage(1);
      game.bullets.remove(bullet);
    }
  }
  
  private void takeDamage(int damage) {
    life -= damage;
  }
}