// Coding Rainbow
// Daniel Shiffman
// http://patreon.com/codingtrain
// Code for: https://youtu.be/JcopTKXt8L8

import peasy.*;
PeasyCam cam;

ArrayList<Tree> trees = new ArrayList<Tree>();

void setup() {
  size(1000, 1000, P3D);
  colorMode(HSB);
  cam = new PeasyCam(this, 1000);
  hint(ENABLE_DEPTH_SORT);
  trees.add(new Tree(new PVector(0, 0, 0), 100));
  trees.add(new Tree(new PVector(100, 140, 140), 200));
  trees.add(new Tree(new PVector(-10, 0, 0), 0));
}

void draw() {
  background(0);  
  noStroke();
  for (Tree tree : trees) {
    tree.show();
    tree.grow();
  }
}

void keyPressed(){
  if (key == '1'){
    Tree tree = trees.get(0);
    tree.addLeaves();
  }
  
  else if (key == '2'){
  Tree tree = trees.get(1);
    tree.addLeaves();
  }
  
  else if (key == '3'){
  Tree tree = trees.get(2);
    tree.addLeaves(); 
  }
  
}