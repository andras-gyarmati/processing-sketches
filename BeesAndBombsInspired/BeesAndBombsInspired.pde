PVector shaft;
ArrayList<PVector> dots;
float a;
int freq, gap;

void setup() {
  size(640, 640);
  shaft = new PVector(0, 250);
  dots = new ArrayList<PVector>();
  a = 0.05;
  freq = 0;
  gap = 3;
}

void draw() {
  background(255);
  pushMatrix();
  translate(width / 2, height / 2);
  shaft.rotate(a);
  shaft.setMag(sin(PVector.angleBetween(shaft, new PVector(1, 1))) * 300);
  dots.add(new PVector(shaft.x, shaft.y));
  if (dots.size() > 121) {
    for (int i = 0; i < gap; i++) {
      dots.remove(0);
    }
  }
  if (dots.size() > freq) {
    for (int i = 0; i < dots.size() - freq; i++) {
      if (i % gap == 0) {
        PVector a = dots.get(i);
        PVector b = dots.get(i + freq);
        strokeWeight(3);
        stroke(map(i, 0, dots.size() - freq, 255, 0));
        line(a.x, a.y, b.x, b.y);
      }
    }
  }
  if (dots.size() > 1) {
    for (int i = 0; i < dots.size() - 1; i++) {
      PVector a = dots.get(i);
      PVector b = dots.get(i + 1);
      strokeWeight(3);
      stroke(map(i, 0, dots.size() - 1, 255, 0));
      line(a.x, a.y, b.x, b.y);
    }
  }
  popMatrix();
}
