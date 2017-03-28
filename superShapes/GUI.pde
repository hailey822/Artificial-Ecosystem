class CheckBox {
  String name;
  int x, y;
  int size;
  color baseCol;
  boolean checked = false;

  boolean isChecked() { 
    return checked;
  }

  CheckBox(String s, int xp, int yp, int sz, color b) {
    name = s;
    x=xp;
    y=yp;
    size = sz;
    baseCol = b;
  }

  void press() {
    if ((mouseX >=x ) && (mouseX <= x+size) && 
      (mouseY >= y) && (mouseY <= y+size)) {
      checked = !checked;
      if (checked) println(name + " checked");
      else println(name + " unchecked");
    }
  }

  void display() {
    fill(baseCol);
    stroke(0);
    rect(x,y, size, size);
    if (checked) {
      line(x, y, x+size, y+size);
      line(x+size, y, x, y+size);
    } 
    fill(baseCol);
    textSize(size);
    text(name, x+size+10, y+size);
  }
}

class Slider {
  String name;
  int x, y; // position
  int w, h; // width and height
  float min, max;
  float pos; // current value
  color baseCol; 
  color highlightCol;

  float pos() { 
    return pos;
  }

  void setPos(float p) {
    pos = p;
  }

  Slider(String s, int xp, int yp, float mi, float ma, color bc, color hc) {
    name = s; // name
    x=xp; // x position 
    y=yp; // y position
    w = 100; // slide width
    h = 15; // slide height
    min = mi; // min
    max = ma; // max
    baseCol = bc; // base color
    highlightCol = hc; // highlight color
    pos = (int)(min+max)/2; // default position
  }

  void slide() {
    if ((mouseX >=x ) && (mouseX <= x+w) && 
      (mouseY >= y) && (mouseY <= y+h) ) {
      pos = map(mouseX, x, x+w, min, max);
    }
  }

  void display() {
    fill(baseCol);
    noStroke();
    rect(x, y, w, h); 
    fill(highlightCol);
    rect(x, y, map(pos, min, max, 0, w), h);

    textSize(11);
    fill(baseCol);
    text(name, x + w + 3, y+h-3);
    text(nf(pos, 0, 0), x + 5, y + h -3);
  }
}