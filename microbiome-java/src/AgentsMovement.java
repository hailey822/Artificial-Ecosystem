import processing.core.PVector;

import static java.sql.DriverManager.println;

/**
 * Created by donutt on 2017. 3. 31..
 */

public class AgentsMovement {
    double speed = 2;
    PVector direction;

    MoveFactor xFactor;
    MoveFactor yFactor;
    MoveFactor zFactor;

    PVector getChanged() {
        float _x = (float) xFactor.formula(direction.x);
        float _y = (float) yFactor.formula(direction.y);
        float _z = (float) zFactor.formula(direction.z);

        return new PVector(_x, _y, _z);
    }

    PVector tick() {
        return getChanged().mult((float) speed);
    }
}
