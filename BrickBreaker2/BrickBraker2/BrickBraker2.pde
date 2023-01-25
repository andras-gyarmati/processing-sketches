import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;
Game game;

void setup() {
  fullScreen(P2D);
  colorMode(HSB);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  game = new Game();
  noStroke();
}

void draw() {
  background(51);
  game.update();
  game.display();
}

void mousePressed() {
  game.startBall();
}

void mouseDragged() {
  game.slider.update(mouseX);
}