class Player {
  private String name;
  private int life;
  private float size;
  private PVector pos;

  public Player(String name, int life, float size, PVector pos) {
    this.name = name;
    this.life = life;
    this.size = size;
    this.pos = pos;
  }
  
  public void move(PVector direction) {
    pos.add(direction.mult(size));
  }
  
  public void shoot() {
  }

  public void display() {
    fill(map(life, 0, 3, 50, 255));
    rect(pos.x, pos.y, size, size);
  }
}