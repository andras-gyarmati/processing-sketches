private class GUI {
  private ViewFinder vf;
  private int vfScale;
  private LayerPicker lp;
  private ColorPicker cp;

  public GUI() {
    vfScale = 10;
    vf = new ViewFinder(10, 10, width / vfScale, height / vfScale);
    lp = new LayerPicker();
  }

  public void updateVf(ArrayList<PGraphics> drawing) {
    vf.update(drawing);
  }

  public void display() {
    vf.display();
  }
}
