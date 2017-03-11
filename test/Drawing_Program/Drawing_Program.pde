import processing.net.*;
import java.nio.*;

int colorIndex = 1;
int sizeIndex = 1;

boolean eraser = false;
float erPosX = 0;
float erPosY = 0;
float prevPosX = 0;
float prevPosY = 0;

boolean submit = false;
PImage scrGrb, realGrb;
int selColor = 255;
int selBrightness = 255;

Button[] buttons = new Button[21];
Cursor paintCur;
Button eraserBtn;
Button submitBtn;


Client c;

void setup() {
  size(800, 800, P3D);

  background(255);
  colorMode(HSB, 100, 255, 255);
  smooth();

  scrGrb = get();
  paintCur = new Cursor();
  eraserBtn = new Button(330, 20, 50, 50, 0, 0, false);
  submitBtn = new Button(680, 20, 100, 50, 0, 0, false);

  // Creates color Palette
  for (int i = 1; i < buttons.length; i++) {
    // starts the first color as selected on program start
    if (i == 1) {
      buttons[i] = new Button((((i-1)*30)-(300*((i)/11)))+20, ((i/11)*30)+20, 20, 20, i*(100/(buttons.length-1))-(10/(buttons.length-1)), 255, true);
    } else {
      buttons[i] = new Button((((i-1)*30)-(300*((i)/11)))+20, ((i/11)*30)+20, 20, 20, i*(100/(buttons.length-1))-(100/(buttons.length-1)), 255, false);
    }
  }

  c = new Client(this, "127.0.0.1", 12345); // Replace with your server's IP and port
}

void draw() {

  background(255);
  image(scrGrb, 0, 0, width, height);

  if (mousePressed) { 
    if (eraser == true) { 
      strokeWeight(40);
      stroke(0, 0, 255);
      erPosX = mouseX + random(-15, 15);
      erPosY = mouseY + random(-15, 15);
      line(prevPosX, prevPosY, erPosX, erPosY);
      prevPosX = erPosX;
      prevPosY = erPosY;
    } else {
      stroke(colorIndex, 255, 255);
      line(pmouseX, pmouseY, mouseX, mouseY);
      lineHistory[historyIndex][1] = mouseX;
      lineHistory[historyIndex][2] = mouseY;
      lineHistory[historyIndex][3] = pmouseX;
      lineHistory[historyIndex][4] = pmouseY;
      lineHistory[historyIndex][5] = colorIndex;
      lineHistory[historyIndex][6] = sizeIndex;
      lineHistory[historyIndex][7] = bleedTime;
      lineHistory[historyIndex][8] = selColor;     
      if (historyIndex == 50) {
        historyIndex = 1;
      } else {
        historyIndex ++;
      }
    }
  } else {
    prevPosX = mouseX;
    prevPosY = mouseY;
  }


  lineBleed();  
  toolBar();
  scrGrb = get();
  noCursor();
  strokeWeight(2);
  stroke(0);
  paintCur.display();
}

