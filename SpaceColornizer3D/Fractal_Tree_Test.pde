import peasy.*;
PeasyCam cam;

ArrayList<Agent> agents = new ArrayList<Agent>();

void setup() {
  size(1000, 900, P3D);
  cam = new PeasyCam(this, 1000);
  colorMode(HSB);
  hint(ENABLE_DEPTH_SORT);
  
  agents.add( new Agent(100) );
  agents.add( new Agent(110) );
  agents.add( new Agent(120) );
  agents.add( new Agent(105) );
}

void draw() {
  background(0);
  for (Agent agent : agents) {
    agent.show();
  }

}

void keyPressed() {
}