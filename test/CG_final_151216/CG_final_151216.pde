import processing.net.*;
import java.nio.*;

Server s;
Client c;
int data[];
byte[] bytes;
PImage img;


float cam_x, cam_y, cam_z;
float cam_cx, cam_cy, cam_cz;
float cam_dx, cam_dy, cam_dz;

float pandeg, tiltdeg;
float pan, tilt;
int seed;

Flock flock;
Key keyboard;

int maxObjects = 800;

PGraphics first;
PGraphics third;
PImage sky;

boolean isFirst = true;

import processing.opengl.*;


void setup() {
  //randomSeed(0);
  smooth();
  
  size(displayWidth, displayHeight, P3D );

  first = createGraphics(width, height, P3D);
  third = createGraphics(width, height, P3D);

  sky = createImage(width, height, RGB);
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      sky.pixels[i + j * width] = lerpColor(#131A52,#FAA161, (float)j/height);
    }
  }

  flock = new Flock();
  keyboard = new Key();

  for (int i = 0; i < maxObjects; i++) {
    flock.addBoid( new Boid( random(-500, 500), random(-500, 500), random(-500, 500) ));
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

  for (int i=0; i<cloudNum; i ++) {
    pox[i] = random(-2000, 2000);
    poy[i] = random(-2000, 2000);
    w[i] = random(100, 500);
    h[i] = random(100, 500);
  }
  
  
  s = new Server(this, 12345); // Start a simple server on a port
  bytes = new byte[100000000];
  
}

void draw() {
  //println(frameRate);
  
  flock.run();
  
  c = s.available();
  if (c != null) {
    int byteCount = c.readBytesUntil((byte)10, bytes);
    //println(byteCount);
    //if (byteCount > 0) {
    //  img = byteArrayToImage(bytes, 800, 700, byteCount);
    //  flock.boids[30] = new Boid( random(-500, 500), random(-500, 500), random(-500, 500), img);
    //}
  }
  
  //if (isFirst) {
    Boid target = flock.boids[50];
    first.beginDraw();
    first.background(sky);
    first.camera(target.location.x -10*target.velocity.x, target.location.y + -5 *target.velocity.y -10, target.location.z + -10*target.velocity.z, target.location.x, target.location.y-5, target.location.z, 0, 1, 0);
    first.perspective( radians(30), width/height, 1, 100000);
    flock.display(first);
    //clouds(first, cloudNum);
    //landscaping(first);
    first.endDraw();

    image(first, 0, 0);
  //}

  //if (!isFirst) {
  //  third.beginDraw();
  //  keyboard.keyInput(third); 
  //  third.background(sky);
  //  lights();
  //  third.pushMatrix();
  //  third.popMatrix();
  //  third.camera(cam_x, cam_y, cam_z, cam_cx, cam_cy, cam_cz, 0, 1, 0);
  //  third.perspective( radians(60), width/height, 1, 10000000);
  //  flock.display(third);
  //  clouds(third, cloudNum);
  //  landscaping(third);
  //  third.endDraw();

  //  image(third, 0, 0);
  //}
}

void keyPressed(){
//    isFirst = !(key == CODED);
}