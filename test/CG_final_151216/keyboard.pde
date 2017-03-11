void updateDegree() {
  tilt = radians(tiltdeg);
  pan = radians(pandeg);
}

void updateCamCenter(PGraphics pg) {
  cam_cx = cam_x + cam_dx;
  cam_cy = cam_y + cam_dy;
  cam_cz = cam_z + cam_dz;
  pg.camera(cam_x, cam_y, cam_z, cam_cx, cam_cy, cam_cz, 0, 1, 0);
}

class Key {

  void keyInput(PGraphics pg) {
    if (keyPressed) { 
      switch(keyCode) {
      case UP: 
        tiltdeg  += 1;
        if (tiltdeg >= 180) {
          tiltdeg = 180;
        }
        updateDegree();
        cam_dx = cos(0);
        cam_dz = sin(0);
        cam_dy = cos(tilt);
        cam_dz = sin(tilt);
        cam_dx = cos(pan);
        cam_dz = sin(pan);
        updateCamCenter(pg);
        break;
      case DOWN:
        tiltdeg  -= 1;
        if (tiltdeg <= 0) {
          tiltdeg = 0;
        }
        updateDegree();
        cam_dx = cos(0);
        cam_dz = sin(0);
        cam_dy = cos(tilt);
        cam_dz = sin(tilt);
        cam_dx = cos(pan);
        cam_dz = sin(pan);  
        updateCamCenter(pg);
        break;
      case LEFT:
        pandeg  -= 1;
        updateDegree();
        cam_dx = cos(pan);
        cam_dz = sin(pan);
        updateCamCenter(pg);
        break;
      case RIGHT:
        pandeg  += 1;
        updateDegree();
        cam_dx = cos(pan);
        cam_dz = sin(pan);
        updateCamCenter(pg);
        break;
      }
    }
  }
}