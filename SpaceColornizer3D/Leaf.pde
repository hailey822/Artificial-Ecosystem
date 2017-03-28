// Coding Rainbow
// Daniel Shiffman
// http://patreon.com/codingtrain
// Code for: https://youtu.be/JcopTKXt8L8


class Leaf {
  PVector pos;
  boolean reached = false;
  int hue;

  Leaf(PVector center, int hue, int size) {
    this.hue = hue;
    PVector randomPoint = new PVector(0, 0, 0);
    randomPoint.x = random(center.x-size, center.x+size);
    randomPoint.y = random(center.y-size, center.y+size);
    randomPoint.z = random(center.z-size, center.z+size);
    pos = randomPoint;
  }

  void reached() {
    reached = true;
  }

  void show() {
    fill(hue, 255, 255);
    noStroke();
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    //sphere(4);
    ellipse(0,0, 1, 1);
    popMatrix();
  }
}