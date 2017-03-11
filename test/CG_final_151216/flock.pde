class Flock {
  Cell boids[]; // An ArrayList for all the boids
  int boidCount = 0;
  Flock() {
    boids = new Cell[maxObjects]; // Initialize the ArrayList
  }

  void run() {
    for (Cell b : boids) {
      b.run(boids);  // Passing the entire list of boids to each boid individually
    }
  }
  
  void display(PGraphics pg){
    for (Cell b : boids) {
      b.display(pg);  // Passing the entire list of boids to each boid individually
    }
  }

  void addBoid(Cell b) {
    boids[boidCount] = b;
    boidCount++;
  }
}