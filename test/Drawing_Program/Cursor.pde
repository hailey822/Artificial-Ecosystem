class Cursor {
  boolean clicked = false;
  void display() {
    if (mousePressed) {
      strokeCap(SQUARE);
      line(mouseX - 10, mouseY, mouseX, mouseY);
      line(mouseX, mouseY, mouseX + 10, mouseY);
      line(mouseX, mouseY - 10, mouseX, mouseY);
      line(mouseX, mouseY, mouseX, mouseY + 10);
      strokeCap(ROUND);
    } else {
      strokeCap(SQUARE);
      line(mouseX - 15, mouseY, mouseX - 5, mouseY);
      line(mouseX +5, mouseY, mouseX + 15, mouseY);
      line(mouseX, mouseY - 15, mouseX, mouseY - 5);
      line(mouseX, mouseY + 5, mouseX, mouseY + 15);
      strokeCap(ROUND);
    }
  }
}


void mousePressed() {
  if (mouseY <= 70) {
    for (int i = 1; i < buttons.length; i++) {
      buttons[i].checkStatus();
    }
    if (eraserBtn.checkStatus() == true) {
      eraser = true;
    } else {
      eraser = false;
    }

    if (submitBtn.checkStatus() == true) {
      submit = true;
      realGrb= get(0, 100, width, height-100);
      realGrb.save("texture01.jpg");
      realGrb.loadPixels();
      int[] data = realGrb.pixels;

      ByteBuffer byteBuffer = ByteBuffer.allocate(data.length * 4);
      IntBuffer intBuffer = byteBuffer.asIntBuffer();
      intBuffer.put(data);

      byte[] array = byteBuffer.array();
      c.write(array);
      c.write((byte)10);

      background(255);

      //      IntBuffer intBuf = ByteBuffer.wrap(array)
      //        .order(ByteOrder.BIG_ENDIAN)
      //          .asIntBuffer();
      //      int[] newData = new int[intBuf.remaining()];
      //      intBuf.get(newData);
      //
      //      int w=800, h=700;
      //      int ch = 3;
      //      PImage outImage = new PImage(w, h, RGB);
      //      outImage.loadPixels();
      //      for (int i = 0; i < w*h; i++) {
      //        outImage.pixels[i] = newData[i];
      //      }
      //
      //      outImage.updatePixels();
      //      image(outImage, 0, 0);
      //      noLoop();
    } else {
      submit = false;
    }
  }
}

