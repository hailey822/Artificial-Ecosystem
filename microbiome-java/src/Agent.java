import processing.core.*;

import java.util.ArrayList;

/**
 * Created by donutt on 2017. 3. 29..
 */
public class Agent extends PApplet implements AgentDelegate {

    AgentsMovement agentsMovement = new AgentsMovement();
    PVector position;
    ArrayList<Tree> trees = new ArrayList<Tree>();
    int radius;
    Shape shape;

    public Agent (int _radius) {
        position = new PVector( random(-1000, 1000), random(-1000, 1000), random(-1000, 1000));
        radius = _radius;

        agentsMovement.xFactor = factor -> factor*factor;
        agentsMovement.yFactor = factor -> factor*factor - 3;
        agentsMovement.zFactor = (double factor) -> {
            return Math.sqrt(Math.abs(agentsMovement.xFactor.formula(agentsMovement.direction.x) + agentsMovement.yFactor.formula(agentsMovement.direction.y)));
        };

        SpaceColornizer3D.logMillis("start add Trees in Agent Class", 2);
        trees.add(new Tree(new PVector(0, 0, 0), 200));
        trees.add(new Tree(new PVector(-10, -10, 20), 100));
        trees.add(new Tree(new PVector(10, 15, -10), 0));

        SpaceColornizer3D.logMillis("start init Shape in Agent Class", 2);
        shape = new Shape(_radius);

        SpaceColornizer3D.logMillis("end Agent", 2);
    }

    public void show(PApplet pApplet){
//        this.fetchMovement(agentsMovement.tick());

        SpaceColornizer3D.logMillis("start draw agents", 2);

        pApplet.pushMatrix();
        pApplet.translate(position.x, position.y, position.z);
        SpaceColornizer3D.logMillis("start draw Trees in agent", 2);
        for (Tree tree : trees) {
            tree.show(pApplet);
            tree.grow(pApplet);
        }

        SpaceColornizer3D.logMillis("start draw Shape in agent", 2);
        shape.show(pApplet);
        SpaceColornizer3D.logMillis("end draw", 2);

        pApplet.popMatrix();
    }

    @Override
    public void fetchMovement(PVector direction) {
        for (Tree t : trees) {
            t.fetchMovement(direction);
        }
        this.shape.fetchMovement(direction);
    }
}
