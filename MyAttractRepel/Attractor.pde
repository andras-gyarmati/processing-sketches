// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Attractor extends VerletParticle2D {

  float r;

  Attractor (Vec2D loc) {
    super (loc);
    r = 24;
    physics.addParticle(this);
    physics.addBehavior(new AttractionBehavior2D(this, r*50, 0.5));
    //physics.addBehavior(new AttractionBehavior2D(this, r, -5));
  }

  void display () {
    fill(0);
    ellipse (x, y, r*2, r*2);
  }
}