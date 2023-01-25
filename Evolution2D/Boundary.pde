// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2012
// Box2DProcessing example

// A fixed boundary class

class Boundary {

  // A boundary is a simple rectangle with x,y,width,and height
  float x;
  float y;
  float w;
  float h;

  // But we also have to make a body for box2d to know about it
  Body b;

  Boundary(float x_, float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;

    // Define the polygon
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    // We're just a box
    sd.setAsBox(box2dW, box2dH);


    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    b = box2d.createBody(bd);

    // Attached the shape to the body using a Fixture
    b.createFixture(sd, 1);
  }

  // Draw the boundary, if it were at an angle we'd have to do something fancier
  void display() {
    fill(0);
    stroke(0);
    rectMode(CENTER);
    rect(x, y, w, h);
  }
}


//class Boundary {

//  float x;
//  float y;
//  float w;
//  float h;
//  Body body;

//  Boundary(float x, float y, float w, float h) {
//    this.x = x;
//    this.y = y;
//    this.w = w;
//    this.h = h;
//    create();
//  }

//  private void create() {
//    PolygonShape sd = new PolygonShape();
//    float box2dW = box2d.scalarPixelsToWorld(w/2);
//    float box2dH = box2d.scalarPixelsToWorld(h/2);
//    sd.setAsBox(box2dW, box2dH);
//    BodyDef bd = new BodyDef();
//    bd.type = BodyType.STATIC;
//    bd.position.set(box2d.coordPixelsToWorld(x, y));
//    body = box2d.createBody(bd);
//    FixtureDef fd = new FixtureDef();
//    fd.shape = sd;
//    fd.density = 1;
//    fd.friction = 1;
//    fd.restitution = 0;
//    body.createFixture(fd);
//  }

//  void display_() {
//    Vec2 pos = box2d.getBodyPixelCoord(body);
//    fill(100, 0, 50);
//    noStroke();
//    rectMode(CENTER);
//    rect(pos.x, pos.y, w, h);
//  }

//  void display() {
//    Vec2 pos = box2d.getBodyPixelCoord(body);
//    pushMatrix();
//    translate(pos.x, pos.y);
//    fill(100, 0, 50);
//    noStroke();
//    rectMode(CENTER);
//    rect(0, 0, w, h);
//    popMatrix();
//  }
//}
