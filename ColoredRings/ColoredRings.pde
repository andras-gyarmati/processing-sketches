ArrayList<Ring> rings;

void setup() {
  size(1000, 1000);
  surface.setLocation(10, 10);
  //frameRate(14);
  colorMode(HSB);
  blendMode(ADD);
  rings = new ArrayList<Ring>();
  rings.add(new Ring(0, 200, 360));  
  rings.add(new Ring(45, 280, 180));  
  rings.add(new Ring(180, 360, 90));
  strokeWeight(40);    
  noFill();
}
//todo refactor calculation and make it smoother
void draw() {
  background(0);
  translate(width/2, height/2);
  for (Ring r : rings) {
    r.display();
  }
}

void mouseClicked() {
  saveFrame("######.png");
}
