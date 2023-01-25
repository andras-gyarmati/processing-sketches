

void setup() {
  size(500, 500, P3D);
  smooth(8);
  noStroke();
}

void draw() {
  background(255);
  
  beginShape();
  
  fill(255, 0, 0);
  //strokeWeight(2);
  //stroke(255, 0, 0);
  vertex(50, 50);
  
  fill(0, 255, 0);
  //strokeWeight(10);
  //stroke(0, 255, 0);
  vertex(360, 180);
  
  fill(0, 0, 255);
  //strokeWeight(3);
  //stroke(0, 0, 255);
  vertex(380, 460);
  
  fill(255, 0, 0);
  //strokeWeight(25);
  //stroke(255, 0, 0);
  vertex(50, 50);
  
  endShape();
}
