import peasy.PeasyCam;

import processing.core.*;
import java.util.ArrayList;

/**
 * Created by donutt on 2017. 3. 12..
 */
public class SpaceColornizer3D extends PApplet {
    PeasyCam cam;

    ArrayList<Agent> agents = new ArrayList<Agent>();

    static long startTime;

    public static void logMillis(String info, int tabIndex) {
        if (tabIndex >= 0)
            return;

        String prefix = "";
        for (int i=0; i<tabIndex; i++) {
            prefix += "  ";
        }
        prefix += "=> ";
        float t = ((float)(System.currentTimeMillis() - startTime) / 1000);
        System.out.printf("[time passed: %.4f] %s \n", t, prefix+info);
    }

    public static void main(String... args) {
        startTime = System.currentTimeMillis();
        logMillis("start showing pane", 0);
        PApplet.main("SpaceColornizer3D");
    }

    public void settings(){
        size(1000, 1000, P3D);
    }

    public void setup() {
//        frameRate(10);

        SpaceColornizer3D.logMillis("setup start", 1);

        colorMode(HSB);
        cam = new PeasyCam(this, 1500);
        cam.setWheelScale(0.5);
        cam.setMinimumDistance(1500);
//        cam.setMaximumDistance(1000);

        hint(ENABLE_DEPTH_SORT);
        SpaceColornizer3D.logMillis("start agents adding", 1);
        agents.add( new Agent(110) );
        agents.add( new Agent(120) );
        agents.add( new Agent(105) );
        agents.add( new Agent(100   ) );
        SpaceColornizer3D.logMillis("end agents adding", 1);
        SpaceColornizer3D.logMillis("end setup", 1);
    }

    public void draw() {
        background(0);
        SpaceColornizer3D.logMillis("--------------------------------------------", 1);

        SpaceColornizer3D.logMillis("start draw", 1);
        for (Agent agent : agents) {
            agent.show(this);
        }
    }

    public void keyPressed(){
    }
}
