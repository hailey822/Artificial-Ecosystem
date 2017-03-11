public float boxBase = 10;

public int x_size = 200;
public int y_size = 200;

public float sea_level = 10;
public float tree_line = 50;
public float detail_small = .04;
public float detail_big = .1;
public float scale_small = 200;
public float scale_big = 300;
public float max_height = scale_big + scale_small;
public float[][] height_map = new float[200][200];

PShape landscapeShape;

public void landscaping(PGraphics pg){
  pg.pushMatrix();
  pg.translate(0, 1200, 0);
  //pg.noStroke();
  //pg.rotateX(-PI);
  //pg.rotateZ(PI);
  pg.shape(landscapeShape);
  pg.popMatrix(); 
}

public void generate(){
  noiseSeed(millis());
  for (int x = 0; x < x_size; x++) {
    for (int y = 0; y < y_size; y++) {
      height_map[x][y] = scale_small * noise(detail_small * x, detail_small * y) +
                         scale_big   * noise(detail_big   * x, detail_big   * y);
    }
  }
  
  float xd = boxBase * x_size /3;
  float yd = boxBase * y_size /3 ;
  sea_level = 0.4 * max_height;
  tree_line = 0.75 * max_height;

  landscapeShape = createShape();
  //drawing landscape
  landscapeShape.beginShape(QUADS);
  for (int x = 0; x < x_size -1; x+= 1) {
    for (int y = 0; y < y_size -1; y+=1) {
      set_color(height_map[x][y], landscapeShape);
      landscapeShape.vertex(boxBase * (x + 0) -xd, -flatten( height_map[x+0][y+0]), boxBase * (y + 0) - yd); 
      //set_color(height_map[x][y+1]);
      landscapeShape.vertex(boxBase * (x + 0) -xd, -flatten( height_map[x+0][y+1]), boxBase * (y + 1) - yd); 
      //set_color(height_map[x+1][y+1]);
      landscapeShape.vertex(boxBase * (x + 1) -xd, -flatten( height_map[x+1][y+1]), boxBase * (y + 1) - yd); 
      //set_color(height_map[x+1][y]);
      landscapeShape.vertex(boxBase * (x + 1) -xd, -flatten( height_map[x+1][y+0]), boxBase * (y + 0) - yd);    
    }
  }
  landscapeShape.endShape();
  
  
}

float flatten(float h){
  if (h < sea_level) h = sea_level;
  return h;
}

void set_color(float h, PShape shp){
  float g = 255 * h/max_height;
  float r = g - (tree_line - h);
  
  if (h < sea_level) shp.fill(0, 255 * h / sea_level,255);
  else if (h < sea_level + 20) shp.fill (255,255,155);
  else shp.fill(r,g,r);
}
