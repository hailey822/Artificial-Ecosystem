import processing.core.PApplet;
import processing.core.*;

/**
 * Created by donutt on 2017. 3. 28..
 */
public class Leaf extends PApplet implements AgentDelegate {
    PVector pos;
    boolean reached = false;
    int hue;

    Leaf(PVector center, int hue, int size) {
        this.hue = hue;
        PVector randomPoint = new PVector(0, 0, 0);
        randomPoint.x = random(center.x-size, center.x+size);
        randomPoint.y = random(center.y-size, center.y+size);
        randomPoint.z = random(center.z-size, center.z+size);
        pos = randomPoint;
    }

    void reached() {
        reached = true;
    }

    void show(PApplet pApplet) {
        SpaceColornizer3D.logMillis("start draw leaf", 4);
        pApplet.fill(hue, 255, 255);
        pApplet.noStroke();
        pApplet.pushMatrix();
        pApplet.translate(pos.x, pos.y, pos.z);
        //sphere(4);
//        pApplet.ellipse(0,0, 2, 2);
        pApplet.popMatrix();
    }

    @Override
    public void fetchMovement(PVector direction) {
        pos.add(direction);
    }
}
