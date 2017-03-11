void toolBar() {
  strokeWeight(1);
  stroke(0, 0, 0);

  // Toolbar Box
  fill(100);
  rect(0, 0, width, 90);
  fill(colorIndex, 255, 255);

  for (int i = 1; i< buttons.length; i++) {
    buttons[i].display();
  }
  eraserBtn.display();
  submitBtn.display();
  textSize(20);
  fill(0, 0, 0);
  text("SUBMIT", 695, 35, 740, 50);
}

