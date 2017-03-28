class Agent {
  
  PVector position;
  ArrayList<Tree> trees = new ArrayList<Tree>();
  int radius;
    
  Agent (int _radius) {
    position = new PVector( random(-1000, 1000), random(-1000, 1000), random(-1000, 1000));
    radius = _radius;
    trees.add(new Tree(new PVector(0, 0, 0), 200));
    trees.add(new Tree(new PVector(-10, -10, 20), 100));
    trees.add(new Tree(new PVector(10, 15, -10), 0));
  }
  
  void show(){
    pushMatrix();
    translate(position.x, position.y, position.z);
    for (Tree tree : trees) {
      tree.show();
      tree.grow();
    }
    popMatrix();
  }
  
  
}