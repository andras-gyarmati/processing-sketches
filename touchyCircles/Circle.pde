class Circle {
  PVector pos;
  float radius;
  ArrayList<Circle> touchingWith;
  ArrayList<ArrayList<PVector>> intersections;
  ArrayList<PVector> overlapArcs, displayableArcs;
  PVector ref;

  Circle() {
    pos = new PVector(0, 0);
    radius = 200;
    touchingWith = new ArrayList<Circle>();
    overlapArcs = new ArrayList<PVector>();
    displayableArcs = new ArrayList<PVector>();
    intersections = new ArrayList<ArrayList<PVector>>();
    //arcs.add(new PVector(0, TWO_PI));
    ref = new PVector(radius, 0);
  }

  void setPos(float x, float y) {
    pos.set(x, y);
  }

  void display() {
    stroke(200);
    strokeWeight(10);
    noFill();
    if (touchingWith.size() > 0) {
      stroke(255, 0, 0);
    }
    flipArcs();
    pushMatrix();
    translate(pos.x, pos.y);
    for (PVector a : displayableArcs) {
      arc(0, 0, radius*2, radius*2, a.x, a.y);
    }
    popMatrix();
  }

  void flipArcs() {
    if (overlapArcs.size() == 0) return;
    displayableArcs = new ArrayList<PVector>();
    for (int i = 0; i < overlapArcs.size()-1; i++) {
      displayableArcs.add(new PVector(overlapArcs.get(i).y, overlapArcs.get(i+1).x));
    }
    displayableArcs.add(new PVector(overlapArcs.get(overlapArcs.size()-1).y, overlapArcs.get(0).x));
  }

  void displayIntersectionPoints() {
    noStroke();
    fill(100);
    for (ArrayList<PVector> i : intersections) {
      for (PVector p : i) {
        ellipse(p.x, p.y, 10, 10);
        stroke(250);
        line(0, 0, p.x, p.y);
      }
    }
  }

  void touch(Circle c) {
    if (!isTouching(c)) {
      this.touchingWith.add(c);
      ArrayList<PVector> is = findIntersectionOfCircle(c);
      intersections.add(is);
      if (is.size() == 2) {
        overlapArcs.add(calcNewNegativeArcs(is));
      }
    }
  }

  PVector calcNewNegativeArcs(ArrayList<PVector> is) {
    PVector p1 = is.get(0);
    PVector p2 = is.get(1);
    float a1 = PVector.angleBetween(p1, ref);
    if (p1.y < 0) a1 *= -1;
    float a2 = PVector.angleBetween(p2, ref);
    if (p2.y < 0) a2 *= -1;
    return new PVector(a1, a2);
  }

  void resetTouching() {
    this.touchingWith = new ArrayList<Circle>();
    this.intersections = new ArrayList<ArrayList<PVector>>();
    this.overlapArcs = new ArrayList<PVector>();
  }

  boolean isTouching(Circle c) {
    return this.touchingWith.contains(c);
  }

  //http://paulbourke.net/geometry/circlesphere/
  ArrayList<PVector> findIntersectionOfCircle(Circle c) {
    ArrayList<PVector> intersection = new ArrayList<PVector>();

    //Calculate distance between centres of circle
    float d = PVector.dist(pos, c.pos);
    float c1r = radius;
    float c2r = c.radius;
    float m = c1r + c2r;
    float n = c1r - c2r;

    if (n < 0)
      n *= -1;

    //No solns
    if ( d > m ) {
    }

    //Circle are contained within each other
    if ( d < n ) {
    }

    //Circles are the same
    if ( d == 0 && c1r == c2r ) {
    }

    //Solve for a
    float a = ( c1r * c1r - c2r * c2r + d * d ) / (2 * d);

    //Solve for h
    float h = sqrt( c1r * c1r - a * a );

    //Calculate point p, where the line through the circle intersection points crosses the line between the circle centers.  
    PVector p = new PVector();

    p.x = pos.x + ( a / d ) * ( c.pos.x -pos.x );
    p.y = pos.y + ( a / d ) * ( c.pos.y -pos.y );

    //1 soln , circles are touching
    if ( d == c1r + c2r ) {
      intersection.add(p);
    }

    //2solns  
    PVector p1 = new PVector();
    PVector p2 = new PVector();

    p1.x = p.x + ( h / d ) * ( c.pos.y - pos.y );
    p1.y = p.y - ( h / d ) * ( c.pos.x - pos.x );

    p2.x = p.x - ( h / d ) * ( c.pos.y - pos.y );
    p2.y = p.y + ( h / d ) * ( c.pos.x - pos.x );

    intersection.add(p1.sub(pos));
    intersection.add(p2.sub(pos));

    return intersection;
  }
}
