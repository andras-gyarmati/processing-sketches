class Ball {

  PVector pos, vel;
  int size, offset;
  boolean isMoving;

  Ball(PVector pos, int size, int offset) {
    this.pos = pos;
    this.size = size;
    this.vel = new PVector(0, -15);
    isMoving = false;
    this.offset = offset;
  }

  void start() {
    isMoving = true;
  }

  void reset(Slider s) {
    pos.x = s.pos.x+s.w/2;
    pos.y = s.pos.y-size/2;
    isMoving = false;
    this.vel.set(0, -15);
  }

  void update(Slider s, ArrayList<Brick> bs) {
    if (isMoving) {
      bounce(s, bs);
      pos.add(vel);
    }
  }

  void bounce(Slider s, ArrayList<Brick> bs) {
    bounceOffScreenEdge();
    bounceOffSlider(s);
    bounceOffBricks(bs);
  }

  void bounceOffScreenEdge() {
    if (pos.x < size/2) {
      pos.x=size/2;
      vel.x *= -1;
    }
    if (pos.x > width-size/2) {
      pos.x=width-size/2;
      vel.x *= -1;
    }
    if (pos.y < size/2+offset) {
      pos.y=size/2+offset;
      vel.y *= -1;
    }
    if (pos.y > height-size/2) {
      pos.y=height-size/2;
      vel.y *= -1;
    }
  }

  void bounceOffSlider(Slider s) {
    if (pos.y + size/2 > s.pos.y && pos.y - size/2 < s.pos.y+s.h
      && pos.x > s.pos.x && pos.x < s.pos.x+s.w) {
      vel.y *= -1;
      //this.vel.set(0, -15);
      pos.y = s.pos.y - size/2;
      calcVelocityDirection(s);
    }
  }

  void bounceOffBricks(ArrayList<Brick> bs) {
    for (Brick b : bs) {
      if (b.life  != 0 && pos.y + size/2 > b.pos.y && pos.y - size/2 < b.pos.y+b.h && pos.x > b.pos.x && pos.x < b.pos.x+b.w) {
        if (pow(pos.x - b.pos.x, 2) > pow(pos.y - b.pos.y, 2) || pow(pos.x - b.pos.x + b.w, 2) > pow(pos.y - b.pos.y + b.h, 2)) {
          vel.y *= -1;
        } else {
          vel.x *= -1;
        }
        b.damage();
      }
    }
  }

  void calcVelocityDirection(Slider s) {
    float mag = vel.mag();
    PVector diff = PVector.sub(new PVector(pos.x, 0), new PVector(s.pos.x+s.w/2, 0));
    float diffMag = diff.mag();
    diff.setMag(diffMag*0.05);
    vel.add(diff);
    vel.setMag(mag);
  }

  void display() {
    fill(ballColor);
    ellipse(pos.x, pos.y, size, size);
  }
}