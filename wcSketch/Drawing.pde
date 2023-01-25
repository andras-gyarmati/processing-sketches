public class Drawing {
  private ArrayList<PGraphics> drawing;
  private ArrayList<PVector> trace;
  private ArrayList<ArrayList<PVector>> layer;
  private PGraphics current;

  public Drawing() {
    drawing = new ArrayList<PGraphics>();
    current = createGraphics(width, height);
    current.beginDraw();
    current.background(255);
    current.endDraw();
    drawing.add(current);
    addLayer();
  }

  public void addLayer() {
    current = createGraphics(width, height);
    layer = new ArrayList<ArrayList<PVector>>();
    drawing.add(current);
    //current.smooth(8);
  }

  public PGraphics getCurrentLayer() {
    return current;
  }

  public ArrayList<PGraphics> getDrawing() {
    return drawing;
  }

  public void display() {
    for (PGraphics pg : drawing) {
      image(pg, 0, 0);
    }
    image(current, 0, 0);
  }

  public void pencilDown() {
    trace = new ArrayList<PVector>();
    layer.add(trace);
  }

  public void draw() {
    trace.add(new PVector(mouseX, mouseY));
    current.beginDraw();
    current.clear();
    current.strokeWeight(5);
    for (ArrayList<PVector> tr : layer) {
      if (tr.size() == 1) {
        current.line(tr.get(0).x, tr.get(0).y, tr.get(0).x + 1, tr.get(0).y + 1);
      } else {
        for (int i = 0; i < tr.size() - 1; i++) {
          current.line(tr.get(i).x, tr.get(i).y, tr.get(i + 1).x, tr.get(i + 1).y);
        }
      }
    }
    current.endDraw();
  }

  public void pencilUp() {
    
  }
}
