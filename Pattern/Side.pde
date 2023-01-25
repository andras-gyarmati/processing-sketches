class Side {
  PVector start;
  PVector end;
  boolean isConnected;

  Side(PVector start, PVector end) {
    this.start = start;
    this.end = end;
    this.isConnected = false;
  }

  void display() {
    line(start.x, start.y, end.x, end.y);
  }
}
