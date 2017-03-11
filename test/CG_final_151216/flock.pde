class Flock {
  Boid boids[]; // An ArrayList for all the boids
  int boidCount = 0;
  Flock() {
    boids = new Boid[maxObjects]; // Initialize the ArrayList
  }

  void run() {
    for (Boid b : boids) {
      b.run(boids);  // Passing the entire list of boids to each boid individually
    }
  }
  
  void display(PGraphics pg){
    for (Boid b : boids) {
      b.display(pg);  // Passing the entire list of boids to each boid individually
    }
  }

  void addBoid(Boid b) {
    boids[boidCount] = b;
    boidCount++;
  }
}