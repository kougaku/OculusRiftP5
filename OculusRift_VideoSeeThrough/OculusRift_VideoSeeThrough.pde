//boolean isFullScreen = true;
boolean isFullScreen = false;

OculusRift oculus;
PCapture cam;
PImage camera_image;

boolean sketchFullScreen() {
  return isFullScreen;
}

void setup() {
  size( 1920, 1080, P3D );
  oculus = new OculusRift(this);
  oculus.enableHeadTracking();

  // capture setting
  cam = new PCapture( 2, 1024, 768 ); // id, width, height
}

void draw() {
  camera_image = cam.getImage();
  oculus.draw();
}

// Scene for OculusRift
void onDrawScene(int eye) {
  background(0);

  // camera image
  hint(DISABLE_DEPTH_TEST);
  pushMatrix();
  resetMatrix();
  translate( 0, 0, -400);
  imageMode(CENTER);
  image( camera_image, 0, 0 );
  popMatrix();
  hint(ENABLE_DEPTH_TEST);

  // light
  fill(255);
  lights();

  // cube
  pushMatrix();
  translate( 0, -500, -3000 );
  fill(50, 200, 50);
  rotateX(millis()/1000.0);
  rotateY(millis()/900.0);
  box(500);
  popMatrix();
}

void keyPressed() {
  // Reset head state
  if (key==' ') {
    oculus.resetHeadState();
  }
} 

