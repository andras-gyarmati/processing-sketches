public class ViewFinder {
  private PVector pos;
  private PVector size;
  private ArrayList<PGraphics> drawing;

  public ViewFinder(float x, float y, float w, float h) {
    this.pos = new PVector(x, y);
    this.size = new PVector(w, h);
  }

  public PVector getPos() {
    return pos;
  }

  public PVector getSize() {
    return size;
  }
  public void setPos(float x, float y) {
    pos.set(x, y);
  }

  public void setSize(float w, float h) {
    size.set(w, h);
  }

  void display() {
    stroke(127);
    strokeWeight(1);
    noFill();
    if (null != drawing) {
      for (PGraphics pg : drawing) {
        pg.smooth();
        image(pg, pos.x, pos.y, size.x, size.y);
      }
    }
    rect(pos.x, pos.y, size.x, size.y);
  }

  void update(ArrayList<PGraphics> drawing) {
    this.drawing = drawing;
  }
}
