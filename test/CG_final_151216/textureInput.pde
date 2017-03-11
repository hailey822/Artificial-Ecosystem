PImage byteArrayToImage(byte[] array, int w, int h, int cnt) {
  IntBuffer intBuf = ByteBuffer.wrap(array)
    .order(ByteOrder.BIG_ENDIAN)
      .asIntBuffer();
  int[] data = new int[intBuf.remaining()];
  intBuf.get(data);

  PImage outImage = new PImage(w, h, RGB);
  outImage.loadPixels();
  for (int i = 0; i < w*h; i++) {
    outImage.pixels[i] = data[i];
  }

  outImage.updatePixels();
  println("hahahahahahahahahahahah");
  return outImage;
}