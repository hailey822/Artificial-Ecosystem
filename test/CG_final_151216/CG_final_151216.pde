import processing.net.*;
import java.nio.*;

float cam_x, cam_y, cam_z;
float cam_cx, cam_cy, cam_cz;
float cam_dx, cam_dy, cam_dz;

float pandeg, tiltdeg;
float pan, tilt;
int seed;

Flock flock;
Key keyboard;

int maxObjects = 800;

PGraphics mainSketch;
PImage sky;

boolean changeToFirstPerspective = false;

import processing.opengl.*;

int targetAirPlaneIndex = 0;

void setup() {
  //randomSeed(0);
  smooth();
  
  size(displayWidth, displayHeight, P3D );

  //first = createGraphics(width, height, P3D);
  mainSketch = createGraphics(width, height, P3D);

  sky = createImage(width, height, RGB);
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      sky.pixels[i + j * width] = lerpColor(#131A52,#FAA161, (float)j/height);
    }
  }

  flock = new Flock();
  keyboard = new Key();

  for (int i = 0; i < maxObjects; i++) {
    flock.addBoid( new Cell( random(-500, 500), random(-500, 500), random(-500, 500) ));    
  }
  
  //flock.boids[30] = new Boid( random(-500, 500), random(-500, 500), random(-500, 500), img);

  // init camera
  cam_x = 0 ;
  cam_y = 0;
  cam_z = 0;
  cam_dx = 0;
  cam_dy = 0;
  cam_dz = 1;
  cam_cx = cam_x + cam_dx;
  cam_cy = cam_y + cam_dy;
  cam_cz = cam_z + cam_dz;
  tiltdeg = 90; 
  pandeg = 0;
  tilt = radians(tiltdeg);
  pan = radians(pandeg);
  seed = second(); 

  noStroke();
  generate();  
  
}

void draw() {
  //println(frameRate);
  
  //first.beginDraw();
  //first.background(sky);
  //first.camera(target.location.x -10*target.velocity.x, target.location.y + -5 *target.velocity.y -10, target.location.z + -10*target.velocity.z, target.location.x, target.location.y-5, target.location.z, 0, 1, 0);
  //first.perspective( radians(30), width/height, 1, 100000);
  //flock.display(first);
  ////clouds(first, cloudNum);
  ////landscaping(first);
  //first.endDraw();

  //image(first, 0, 0);
    
  flock.run();
  keyboard.keyInput(mainSketch);  

  mainSketch.beginDraw();  
  mainSketch.background(sky);
  lights();
  mainSketch.pushMatrix();
  mainSketch.popMatrix(); 
  
  if (changeToFirstPerspective) {
    Cell target = flock.boids[targetAirPlaneIndex];
    mainSketch.camera(target.location.x -10*target.velocity.x, target.location.y + -5 *target.velocity.y -10, target.location.z + -10*target.velocity.z, target.location.x, target.location.y-5, target.location.z, 0, 1, 0);
  } else {
    mainSketch.camera(cam_x, cam_y, cam_z, cam_cx, cam_cy, cam_cz, 0, 1, 0);
  }
  
  //if (isFirst) {
    Boid target = flock.boids[50];
    first.beginDraw();
    first.background(sky);
    first.camera(target.location.x -10*target.velocity.x, target.location.y + -5 *target.velocity.y -10, target.location.z + -10*target.velocity.z, target.location.x, target.location.y-5, target.location.z, 0, 1, 0);
    first.perspective( radians(30), width/height, 1, 100000);
    flock.display(first);
    clouds(first, cloudNum);
    landscaping(first);
    first.endDraw();

  flock.display(mainSketch);
  landscaping(mainSketch);    

  mainSketch.endDraw();

  image(mainSketch, 0, 0);
  
}

void keyPressed(){
//    isFirst = !(key == CODED);
}