// Coding Rainbow
// Daniel Shiffman
// http://patreon.com/codingtrain
// Code for: https://youtu.be/JcopTKXt8L8

import peasy.*;
PeasyCam cam;

ArrayList<Tree> trees = new ArrayList<Tree>();

void setup() {
  size(900, 900, P3D);
  cam = new PeasyCam(this, 10);
  colorMode(HSB);
  hint(ENABLE_DEPTH_SORT);
  trees.add(new Tree(new PVector(0, 0, 0), 200));
  trees.add(new Tree(new PVector(-100, -1000, 200), 100));
  trees.add(new Tree(new PVector(100, height/2, -100), 0));
}

void draw() {
  background(51);
  for (Tree tree : trees) {
    tree.show();
    tree.grow();
  }
}