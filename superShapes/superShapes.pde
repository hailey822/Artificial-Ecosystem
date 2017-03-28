import peasy.*;
//PeasyCam cam;

Shape basicShape;
Slider radius1, a1, b1, m1, n11, n21, n31;
Slider radius2, a2, b2, m2, n12, n22, n32;

//Slider(String s, int xp, int yp, float mi, float ma, color bc, color hc)

void setup(){
  size(600, 600, P3D);
  //cam = new PeasyCam(this, 1000);
  colorMode(RGB,1);
  hint(ENABLE_DEPTH_SORT);
  basicShape = new Shape(10);
  radius1 = new Slider("radius1", 10, 10, 10, 100, color(0.5), color(0, 1, 1));
  a1 = new Slider("a1", 10, 30, 0, 4,  color(0.5), color(0, 1, 1) );
  b1 = new Slider("b1", 10, 50, 0, 4,  color(0.5), color(0, 1, 1) );
  m1 = new Slider("m1", 10, 70, 0, 20, color(0.5), color(0, 1, 1) );
  n11 = new Slider("n11", 10, 90, 0, 60, color(0.5), color(0, 1, 1) );
  n21 = new Slider("n21", 10, 110, 0, 60, color(0.5), color(0, 1, 1) );
  n31 = new Slider("n31", 10, 130, 0, 60, color(0.5), color(0, 1, 1) );
  
  radius2 = new Slider("radius2", 10, 170, 10, 100, color(0.5), color(0, 1, 1));
  a2  = new Slider("a2", 10, 190, 0, 4,  color(0.5), color(0, 1, 1) );
  b2  = new Slider("b2", 10, 210, 0, 4,  color(0.5), color(0, 1, 1) );
  m2  = new Slider("m2", 10, 230, 0, 20, color(0.5), color(0, 1, 1) );
  n12 = new Slider("n12", 10, 250, 0, 60, color(0.5), color(0, 1, 1) );
  n22 = new Slider("n22", 10, 270, 0, 60, color(0.5), color(0, 1, 1) );
  n32 = new Slider("n32", 10, 290, 0, 60, color(0.5), color(0, 1, 1) );
}


void draw(){
  background(0);
  pushMatrix();
  translate(0, 0);
  radius1.display(); a1.display(); b1.display(); m1.display(); n11.display(); n21.display(); n31.display();
  radius2.display(); a2.display(); b2.display(); m2.display(); n12.display(); n22.display(); n32.display();
  translate(width/2, height/2, 0);
  ambientLight(0.5, 0.5, 0.5);
  directionalLight(1,0,0, cos(radians(100)), sin(radians(100)),0);
  basicShape.show();
  popMatrix();
  
}

void mouseDragged() {
  radius1.slide(); a1.slide(); b1.slide(); m1.slide(); n11.slide(); n21.slide(); n31.slide();
  radius2.slide(); a2.slide(); b2.slide(); m2.slide(); n12.slide(); n22.slide(); n32.slide();
}