void setup() {
  size(200, 200);
  noFill();
  stroke(0);
  strokeWeight(2);
}

void draw() {
  background(255);
  beginShape();
  curveVertex(-48, 186); 
  curveVertex(58, 104); 
  curveVertex(136, 108);
  curveVertex(225, 220);
  endShape();
}
