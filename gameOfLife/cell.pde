class Cell {

  int x; 
  int y;
  int w; 
  int h; 
  int age;
  boolean alive;

  Cell(int x, int y, int w, int h, int age, boolean alive) {  
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.age = age;
    this.alive = alive;
  }

  void display() {
    stroke(0);
    strokeWeight(2);
    if (age > 255) {
      age = 0;
    }
    if (alive) {
      fill(age, 255, 255);
    } else {
      fill(age, 255, 40);
    }
    rect(x, y, w, h);
  }

  void changeState() {
    alive = !alive;
    if (alive) {
      age++;
      if (age > 255) {
        age = 0;
      }
    }
  }

}