
int bleedDistance = 1;
int bleedTime = 30;
int bleedColor;


int[][] lineHistory = new int[51][9];
int historyIndex = 1;

//Controls the ink bleed effect
void lineBleed() {
  int rotationIndex = historyIndex + 1;
  if (rotationIndex > 50) {
    rotationIndex = 1;
  }

  for (int x = 1; x <= 50; x++) {
    if (lineHistory[rotationIndex][7] > 0) { 
      //draws the expanding lines
      lineHistory[rotationIndex][6] += bleedDistance;  
      strokeWeight(lineHistory[rotationIndex][6]);
      stroke(lineHistory[rotationIndex][8], 255, 255);
      line(lineHistory[rotationIndex][1], lineHistory[rotationIndex][2], lineHistory[rotationIndex][3], lineHistory[rotationIndex][4]);
      //Keeps track of ammount of bleed (or the ammount of times the line segment strokeWeight is increased)
      lineHistory[rotationIndex][7]--;
    }

    if (rotationIndex == 50) {
      rotationIndex = 1;
    } else {
      rotationIndex++;
    }
  }
}

