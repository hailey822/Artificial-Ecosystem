
class Cell {
  PVector location;
  PVector velocity;
  PVector acceleration;  
  
  float size;
  float theta;  
  
  color col;
  float swt = 250.0;     //sep.mult(25.0f);
  float awt = 1.0;      //ali.mult(4.0f);
  float cwt = 100.0;      //coh.mult(5.0f);
  float maxspeed = 6;
  float maxforce = 0.5;
  boolean isDisplayed = false;
  
  Cell(float x, float y, float z) {
    location = new PVector(x, y, z); 
    velocity = new PVector(random(-10, 10), random(-10, 10), random(-10, 10));       
    acceleration = new PVector(0, 0, 0);
    
    size = random(5, 10);    
           
    col = color(random(20,255), random(20,255), random(20,255));    
  }

  void display(PGraphics pg) {   
    //float x = atan2( velocity.y, -velocity.z );
    //float y = atan2( velocity.x * cos(x), -velocity.z );
    //if (velocity.z>=0)
    //  y = -atan2( velocity.x * cos(x), -velocity.z );
    //else
    //  y = atan2( velocity.x * cos(x), velocity.z );
    //float z  = atan2( cos(x), sin(x) * sin(y) );
    
    pg.fill(175); 
    pg.pushMatrix();
    pg.translate ( location.x, location.y, location.z );
    //pg.rotateX(x);
    //pg.rotateY(y);
    //pg.rotateZ(z);
    //pg.rotateZ(radians(90));
    pg.stroke(0);
    //shp.setFill(col);
    pg.sphere(this.size);
    pg.popMatrix();
  }


  void run(Cell boids[]) {
    //flock(boids);
    update();
    boundaries();
  }

  void applyForce (PVector force) {
    //PVector f = PVector.div(force, mass/2);
    acceleration.add(force);
  }


  void flock(Cell boids[]) {
    PVector sep = separate(boids);   // Separation
    PVector ali = align(boids);      // Alignment
    PVector coh = cohesion(boids);   // Cohesion
    // Arbitrarily weight these forces
    sep.mult(swt);
    ali.mult(awt);
    coh.mult(cwt);
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    //location.add(velocity);
    acceleration.mult(0);
  }

  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, location);  // A vector pointing from the location to the target
    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force

      return steer;
  }

  void boundaries() {
    if (location.x+size > 500) {
      velocity.x = abs(velocity.x) * -1;
      acceleration.x = abs(acceleration.x) * -1;
    } else if (location.x-size <= -500) {
      velocity.x = abs ( velocity.x );
      acceleration.x = abs(acceleration.x);
    }

    if (location.y+size > 500) {
      velocity.y = abs ( velocity.y ) * -1;
      acceleration.y = abs(acceleration.y) * -1;
    } else if (location.y-size < -500) {
      velocity.y = abs ( velocity.y );
      acceleration.y = abs(acceleration.y);
    }

    if (location.z-size >500) {
      velocity.z = abs ( velocity.z )* -1 ;
      acceleration.z = abs(acceleration.z) * -1;
    } else if (location.z+size < -500) {
      velocity.z = abs ( velocity.z );
      acceleration.z = abs(acceleration.z);
    }
  }



  // Separation
  // Method checks for nearby boids and steers away
  PVector separate (Cell boids[]) {
    float desiredseparation = 5.0;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Cell other : boids) {
      float d = PVector.dist(location, other.location);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  PVector align (Cell boids[]) {
    float neighbordist = 50.0;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    for (Cell other : boids) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        steer.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      steer.div((float)count);
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Cohesion
  // For the average location (i.e. center) of all nearby boids, calculate steering vector towards that location
  PVector cohesion (Cell boids[]) {
    float neighbordist = 5.0;
    PVector sum = new PVector(0, 0, 0);   // Start with empty vector to accumulate all locations
    int count = 0;
    for (Cell other : boids) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.location); // Add location
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      return seek(sum);  // Steer towards the location
    }
    return sum;
  }
}