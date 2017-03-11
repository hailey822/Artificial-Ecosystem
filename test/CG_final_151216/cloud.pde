int cloudNum =1000;

float[] pox = new float[cloudNum];
float[] poy = new float[cloudNum];
float [] w = new float[cloudNum];
float [] h = new float[cloudNum]; 

void clouds(PGraphics pg, int num) {
  pg.pushMatrix();
  pg.translate(0, -800, 0);
  pg.noStroke();
  randomSeed(10);
  for (int i =0; i <num; i+=1) {
    pg.pushMatrix();
    pg.fill(255, 50);
    pg.translate(pox[i]*10+(1000/num)-1000, 0, poy[i]*10 +(1000/num)-1000);
    pg.box(w[i]*2, 100, h[i]*2);
    
//    int x = int(pox[i]/10);
//    int y = int(poy[i]/10);
//    color c = sky.pixels[x + y * width];
//    int size;
//    pg.pushMatrix();
//    pg.translate(-100, 0, -100);
//    pg.fill(c);
//    pg.translate(random(200), 0, random(200));
//    size = int(random(100));
//    pg.box(size, 100, size);
//    pg.translate(random(200), 0, random(200));  
//    size = int(random(100));
//    pg.box(size, 100, size);
//    pg.translate(random(200), 0, random(200)); 
//    size = int(random(100));
//    pg.box(size, 100, size);
//    pg.popMatrix();
//    
    pg.popMatrix();
  }
  pg.popMatrix(  );
}
