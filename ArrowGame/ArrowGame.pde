PVector startPos, endPos, aid;
ArrayList<Arrow> arrows;
float size;


// todo
// if they collide they gain speed
// calc proper circle collision and bounce direction
// tweak resistance and speed gain values
void setup() {
  size(640, 480, P2D);
  colorMode(HSB);
  arrows = new ArrayList<Arrow>();
  startPos = new PVector(-100, -100);
  endPos = new PVector(-100, -100);
  aid = new PVector(0, 0);
  size = 10;
}

public static double sigmoid(double x) {
  return (1/( 1 + Math.pow(Math.E, (-1*x))));
}

void draw() {
  background(51);
  for (Arrow a : arrows) {
    for (Arrow b : arrows) {
      float dist = a.pos.copy().sub(b.pos).mag();
      if (dist > 0 && dist <= size) {
        a.bumpInto(b);
      }
    }
    a.update();
    a.display();
  }
  showAid();
}

void showAid() {
  strokeWeight(5);
  stroke(255, 0, 255);
  line(startPos.x, startPos.y, startPos.x-aid.x, startPos.y-aid.y);
  fill(255, 255, 255); //??
  noStroke();
  ellipse(startPos.x, startPos.y, size, size);
}

void mousePressed() {
  startPos.set(mouseX, mouseY);
  endPos.set(mouseX, mouseY);
  aid.set(PVector.sub(endPos, startPos));
}

void mouseDragged() {
  endPos.set(mouseX, mouseY);
  aid.set(PVector.sub(endPos, startPos));
}

void mouseReleased() {
  endPos.set(mouseX, mouseY);
  PVector vel = new PVector(startPos.x, startPos.y);
  vel.sub(endPos);
  vel.mult(0.1);
  arrows.add(new Arrow(startPos, vel, new PVector(0, 0), size));
  startPos.set(-100, -100);
  endPos.set(-100, -100);
}
