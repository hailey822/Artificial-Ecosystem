import processing.core.PApplet;
import processing.core.*;

/**
 * Created by donutt on 2017. 3. 28..
 */
public class Branch extends PApplet implements AgentDelegate {
    Branch parent;
    PVector pos;
    PVector dir;
    int count = 0;
    PVector saveDir;
    float len = (float) 1;

    Branch(PVector v, PVector d) {
        parent = null;
        pos = v.copy();
        dir = d.copy();
        saveDir = dir.copy();
    }

    Branch(Branch p) {
        parent = p;
        pos = parent.next();
        dir = parent.dir.copy();
        saveDir = dir.copy();
    }

    void reset() {
        count = 0;
        dir = saveDir.copy();
    }

    PVector next() {
        PVector v = PVector.mult(dir, len);
        PVector next = PVector.add(pos, v);
        return next;
    }

    @Override
    public void fetchMovement(PVector direction) {
        this.pos.add(direction);
    }
}
