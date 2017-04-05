import processing.core.*;

/**
 * Created by donutt on 2017. 3. 29..
 */
public class Shape extends PApplet implements AgentDelegate {

    PVector[][] globe;
    int total = 20;
    float radius;


    public Shape(int _radius){
        globe = new PVector[total+1][total+1];
        this.radius = _radius;
        calculation();
    }

    // Supershapes (Superformula) :  Written by Paul Bourke
    // http://paulbourke.net/geometry/supershape/
    // m : rotational symmetry (TWO_PI/m);
    // n : pinches (values under 1 : very sharp) (Polygons : big values but same for n1, n2, n3)
    public float supershape(float theta, float a, float b, float m, float n1, float n2, float n3){
        float t1 = abs ( (1/a) * cos(m * theta / 4) );
        t1 = pow(t1, n2);
        float t2 = abs ( (1/b) * sin(m * theta / 4) );
        t2 = pow(t2, n3);
        float t3 = t1 + t2;
        float r = pow (t3, -1/n1);
        return r;
    }

    public void calculation(){
        // (r, lattitude, longtitude) -> (x, y, z)
        // Save points on Sphere to save the calculations
        for (int i = 0; i < total+1; i++){
            float lat = map (i, 0, total, -HALF_PI, HALF_PI);
            float r2 = supershape(lat, 1, 1, 10, 10, 10, 10);
            for (int j = 0; j < total+1; j++){
                float lon = map (j, 0, total, -PI, PI);
                float r1 = supershape(lon, 1, 1, 10, 10, 10, 10);
                float x = radius * r1 * cos(lon) * r2 * cos (lat);
                float y = radius * r1 * sin(lon) * r2 * cos (lat);
                float z = radius * r2 * sin(lat) ;
                globe[i][j] = new PVector(x, y, z);
            }
        }
    }

    public void show(PApplet pApplet) {
        SpaceColornizer3D.logMillis("start draw shape", 3);

        pApplet.noStroke();
        for (int i = 0; i < total; i++){
//            float hu = map(i, 0, total, 0, 255*6);
            pApplet.fill(255, 100);
            pApplet.beginShape(TRIANGLE_STRIP);

            for (int j=0; j<total+1; j++){
                PVector v1 = globe[i][j];
                pApplet.vertex(v1.x, v1.y, v1.z);
                PVector v2 = globe[i+1][j];
                pApplet.vertex(v2.x, v2.y, v2.z);
            }

            pApplet.endShape();
        }
    }

    @Override
    public void fetchMovement(PVector direction) {
        for (int i = 0; i < total+1; i++){
            for (int j=0; j<total+1; j++){
                this.globe[i][j].add(direction);
            }
        }
    }
}
