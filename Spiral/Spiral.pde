import processing.opengl.*;


import toxi.physics.*;
import toxi.physics.constraints.*;
import toxi.physics.behaviors.*;

import toxi.geom.*;
import peasy.*;

PeasyCam cam;
VerletPhysics  physics;

Creator unit;
float spin = 0.0;

ArrayList <Creator> creators;
void setup() {
  size(600, 600, OPENGL);
  
 creators = new ArrayList <Creator>();
 
  cam = new PeasyCam(this, 100);

  physics = new VerletPhysics();
 
  
  Vec3D vel = new Vec3D(0, 0, 0);
  Vec3D cen = new Vec3D(0,0,0);
  unit = new Creator(cen,vel);
  creators.add(unit);
}


void draw () {

  background(0);
  

  stroke(255);
  strokeWeight(1);
  noFill();
  box(600);
  
  pushMatrix();
  translate(0, 0, -300);



  stroke(0,200,255);
  strokeWeight(1);
  noFill();
  box(500,500,2);
  popMatrix();
  
  unit.run();

  physics.update();
}



class Creator{

  
  Vec3D loc= new Vec3D();
  Vec3D cen;
  Vec3D vel = new Vec3D(0,0,5);
  
  float angle  = 0;
  float radius = 150;
  
  float z = 200;
  float speed = 0.01;
 
  
  Creator (Vec3D _cen, Vec3D _vel){
    cen = _cen;
    vel= _vel;
  }

  void run(){
    calcLoc();
    moveUpdate();
   dropParticle();
    drawParticles();

    display();
    
  }
  
  

 void dropParticle(){
  
  VerletParticle p = new VerletParticle(loc.x,loc.y,loc.z);
  
  if (z == 0) {
     p.lock();
  }
    physics.addParticle(p);
  }
  
  
  void moveUpdate (){
   cen.add(vel);
    
    angle += speed;
    
    
    if(angle >= TWO_PI){
      angle = 0;
      z++;
    }
  }
  void calcLoc(){

     for (int i = 0 ; i < 200; i++) {
    loc = new Vec3D(cos(angle)*radius,sin(angle)*radius,0);
    
  }
  }
  
  
  void drawParticles() {
  for (int i= 0; i <physics.particles.size(); i++) {
    VerletParticle vp = (VerletParticle) physics.particles.get(i);

   strokeWeight(5);
    if (vp.isLocked()) {
     stroke(255, 0, 0);
   }
    else {
      stroke(0, 255, 200);
    }

    point(vp.x, vp.y, vp.z);
  }
}
  void display (){
    
    strokeWeight(2);
    stroke(0,0,255);
    
    point(loc.x,loc.y,loc.z);
 
  }  
}