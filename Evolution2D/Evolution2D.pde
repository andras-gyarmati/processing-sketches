import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;
Terrain terrain;
float mutationRate;
int populationSize;
float time;
Slider slider;

/*
save, load, knob es muscle eltunes es uj novesztese, tobb dolog is tudjon mutalodni rajtuk 
 es minden egyes dolog kulon lehetoseggel mutalodjon, jobb kivalogatas kell
 */

void setup() {
  size(1280, 720, P2D);
  colorMode(HSB);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -20);
  populationSize = 500;
  mutationRate = 0.05;
  terrain = new Terrain(populationSize);
  time = 0;
  slider = new Slider(370, 120, width - 420, 20, 1, 1000);
}

void draw() {
  background(156, 100, 150);
  for (int i = 0; i < slider.getValue(); i++) {
    box2d.step();
    time += 0.1;
    terrain.step();
  }
  terrain.display();
  slider.display();
}

void mouseDragged() {
  slider.update(new PVector(mouseX, mouseY));
}
