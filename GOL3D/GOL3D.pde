/*
Game of Life (in 3d!)
Based on Mike Davis' Conway sketch.
Press a key to regenerate, control cam with mouse.
*/
import processing.opengl.*;
import peasy.*;
PeasyCam cam;
PFont font;
int generations;
ArrayList lives;
void setup(){
  size(1000, 800, OPENGL);
  frameRate(12);
  generations = 0;
  font = loadFont("Monaco-12.vlw");
  textFont(font, 12);
  cam = new PeasyCam(this, 400);
 
  lives = new ArrayList();
  lives.add(new Life(80, 80, 80, 0.135, 5, 0));
}
void draw(){
  background(0);
 
  generations++;
  rotateX(radians(45));
  rotateZ(radians(45));
 
  fill(255);
  cam.beginHUD();
  text("Generations: "+generations, width-150, height-20);
  cam.endHUD();
 
  noFill();
  for(int i=lives.size()-1; i>=0; i--){
    Life life = (Life)lives.get(i);
    life.render();
    if(keyPressed == true){
      generations = 0;
      lives.remove(i);
      lives.add(new Life(80, 80, 80, 0.135, 5, 0));
    }
  }
}
class Life{
  int w, h;
  int depth;
  float density = 0.8;
  int sz = 3;
  int[][][][] world;
  color layer;
  Life(int _w, int _h, int _d, float _density, int _sz, color _layer){
    w = _w;
    h = _h;
    depth = _d;
    density = _density;
    sz = _sz;
    color layer = _layer;
    world = new int[w][h][depth][2];
    for(int i=0; i<density*w*h*depth; i+=sz){
      world[(int)random(w)][(int)random(h)][(int)random(depth)][0]=1;
    }
  }
  void render(){
    fill(0, 100);
    for(int i=0; i<w; i+=sz){
      for(int j=0; j<h; j+=sz){
        for(int k=0; k<depth; k+=sz){
          if((world[i][j][k][1] == 1) || (world[i][j][k][1] == 0 && world[i][j][k][0] == 1)){
            world[i][j][k][0]=1;
            stroke(255-i*2.5, j*2.5, k*2.5);
            pushMatrix();
            translate(i, j, k);
            box(sz);
            popMatrix();
          }
          if(world[i][j][k][1] == -1){
            world[i][j][k][0] = 0;
          }
          world[i][j][k][1] = 0;
        }
      }
    }
    for(int i=0; i<w; i+=sz){
      for(int j=0; j<h; j+=sz){
        for(int k=0; k<depth; k+=sz){
          int count = neighbours(i, j, k);
          if(count == 4 && world[i][j][k][0] == 0){
            world[i][j][k][1] = 1;
          }
          if((count < 3 || count > 4) && world[i][j][k][0] == 1){
            world[i][j][k][1] = -1;
          }
        }
      }
    }
  }
  int neighbours(int x, int y, int z){
    return world[(x+sz) % w][y][z][0] +
      world[x][(y+sz) % h][z][0] +
      world[(x+w-sz) % w][y][z][0] +
      world[x][(y+h-sz) % h][z][0] +
      world[(x+sz) % w][(y+sz) % h][z][0] +
      world[(x+w-sz) % w][(y+sz) % h][z][0] +
      world[(x+sz) % w][(y+h-sz) % h][z][0] +
      world[(x+w-sz) % w][(y+h-sz) % h][z][0] +
      world[(x+sz) % w][y][(z+sz) % depth][0] +
      world[x][(y+sz) % h][(z+sz) % depth][0] +
      world[(x+w-sz) % w][y][(z+sz) % depth][0] +
      world[x][(y+h-sz) % h][(z+sz) % depth][0] +
      world[(x+sz) % w][(y+sz) % h][(z+sz) % depth][0] +
      world[(x+w-sz) % w][(y+sz) % h][(z+sz) % depth][0] +
      world[(x+sz) % w][(y+h-sz) % h][(z+sz) % depth][0] +
      world[(x+w-sz) % w][(y+h-sz) % h][(z+sz) % depth][0] +
      world[(x+sz) % w][y][(z+depth-sz) % depth][0] +
      world[x][(y+sz) % h][(z+depth-sz) % depth][0] +
      world[(x+w-sz) % w][y][(z+depth-sz) % depth][0] +
      world[x][(y+h-sz) % h][(z+depth-sz) % depth][0] +
      world[(x+sz) % w][(y+sz) % h][(z+depth-sz) % depth][0] +
      world[(x+w-sz) % w][(y+sz) % h][(z+depth-sz) % depth][0] +
      world[(x+sz) % w][(y+h-sz) % h][(z+depth-sz) % depth][0] +
      world[(x+w-sz) % w][(y+h-sz) % h][(z+depth-sz) % depth][0];
  }
}