public class Game {
  public User user;
  private ArrayList<Player> players;
  private ArrayList<Bullet> bullets;

  public Game() {
    players = new ArrayList<Player>();
    bullets = new ArrayList<Bullet>();
    user = new User(width / 2, height / 2, 20);
    players.add(user);
    players.add(new Ai(random(100, width / 2), random(100, width / 2)));
  }

  public void addBullet(Bullet bullet) {
    bullets.add(bullet);
  }

  void step() {
    for (Player p : players) {
      for (int i = bullets.size() - 1; i >= 0; i--) {
        Bullet b = bullets.get(i);
        p.checkIfHitByBullet(b);
      }
    }
    for (int i = bullets.size() - 1; i >= 0; i--) {
      Bullet b = bullets.get(i);
      b.move();
      if (b.pos.x < b.size || b.pos.x > width - b.size*2 || b.pos.y < b.size || b.pos.y > height - b.size*2) {
        bullets.remove(i);
      }
    }
  }

  void display() {
    for (Player p : players) {
      p.display();
    }
    for (Bullet b : bullets) {
      b.display();
    }
  }
}