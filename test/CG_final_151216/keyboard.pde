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

boolean keyPushedF = false;

class Key {

  void keyInput(PGraphics pg) {    
    if (keyPressed) {
      if (key == 'f') {        
        keyPushedF = true;
      } 
    } else if (keyPushedF) {
      changeToFirstPerspective = !changeToFirstPerspective;
      keyPushedF = false;
    }
    
    
    if (keyPressed) { 
      if (changeToFirstPerspective) {
        keyInputOnFirstPerspective();
      } else {
        keyInputOnThirdPerspective(pg);
      }
    }
  }
  
  void keyInputOnFirstPerspective() {
    switch(keyCode) {
      case LEFT:
        targetAirPlaneIndex = targetAirPlaneIndex > 0 ? targetAirPlaneIndex-1 : maxObjects-1;
      break;
      
      case RIGHT:
        targetAirPlaneIndex = targetAirPlaneIndex < maxObjects-1 ? targetAirPlaneIndex + 1 : 0;
      break;
    }
  }
  
  void keyInputOnThirdPerspective(PGraphics pg) {
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