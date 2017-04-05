import processing.core.PApplet;
import processing.core.*;

import java.util.ArrayList;

/**
 * Created by donutt on 2017. 3. 28..
 */
public class Tree extends PApplet implements AgentDelegate {

    ArrayList<Branch> branches = new ArrayList<Branch>();
    ArrayList<Leaf> leaves = new ArrayList<Leaf>();
    PVector center;

    int hue;
    float min_dist = 5;
    float max_dist = 200;
    int radius = 50;

    Tree(PVector _center, int _hue) {
        this.center = _center;
        this.hue = _hue;
        SpaceColornizer3D.logMillis("add Leaves in Tree Class ", 3);
        for (int i = 0; i < 50; i++) {
            leaves.add(new Leaf(center, hue, radius));
        }

        SpaceColornizer3D.logMillis("add Branches in Tree Class ", 3);
        Branch root = new Branch(center, new PVector(0, 0, 0));
        branches.add(root);
        Branch current = new Branch(root);

        SpaceColornizer3D.logMillis("add closeEnough in Tree Class ", 3);
        while (!closeEnough(current)) {
            Branch trunk = new Branch(current);
            branches.add(trunk);
            current = trunk;
        }
        SpaceColornizer3D.logMillis("end Tree Class ", 3);
    }

    boolean closeEnough(Branch b) {

        for (Leaf l : leaves) {
            float d = PVector.dist(b.pos, l.pos);

            if (d < max_dist) {
                return true;
            }
        }
        return false;
    }

    void grow(PApplet pApplet) {
        SpaceColornizer3D.logMillis("start grow tree", 3);
        for (Leaf l : leaves) {
            Branch closest = null;
            PVector closestDir = null;
            float record = -1;

            for (Branch b : branches) {
                PVector dir = PVector.sub(l.pos, b.pos);
                float d = dir.mag();
                if (d < min_dist) {
                    l.reached();
                    closest = null;
                    break;
                } else if (d > max_dist) {
                } else if (closest == null || d < record) {
                    closest = b;
                    closestDir = dir;
                    record = d;
                }
            }
            if (closest != null) {
                closestDir.normalize();
                closest.dir.add(closestDir);
                closest.count++;
            }
        }

        for (int i = leaves.size()-1; i >= 0; i--) {
            if (leaves.get(i).reached) {
                leaves.remove(i);
            }
        }

        for (int i = branches.size()-1; i >= 0; i--) {
            Branch b = branches.get(i);
            if (b.count > 0) {
                b.dir.div(b.count);
                PVector rand = PVector.random2D();
                rand.setMag((float) 0.3);
                b.dir.add(rand);
                b.dir.normalize();
                Branch newB = new Branch(b);
                branches.add(newB);
                b.reset();
            }
        }
    }

    void show(PApplet pApplet) {
        SpaceColornizer3D.logMillis("start draw tree", 3);

        for (Leaf l : leaves) {
            l.show(pApplet);
        }

        SpaceColornizer3D.logMillis("start draw Branches :: " + branches.size(), 3);
        //for (Branch b : branches) {
        for (int i = 0; i < branches.size(); i++) {
            Branch b = branches.get(i);
            if (b.parent != null) {
                float sw = map(i, 0, branches.size(), 4, (float) 1.0);
                pApplet.strokeWeight(sw);
                pApplet.stroke(hue, 255, 255);
                pApplet.line(b.pos.x, b.pos.y, b.pos.z, b.parent.pos.x, b.parent.pos.y, b.parent.pos.z);
            }
        }
    }

    void addLeaves(){
        for (int i = 0; i < 100; i++) {
            leaves.add(new Leaf(center, hue, radius));
        }
    }

    @Override
    public void fetchMovement(PVector direction) {
        for (Branch b : branches)
            b.fetchMovement(direction);
        for (Leaf l : leaves)
            l.fetchMovement(direction);

        this.center.add(direction);
    }
}
