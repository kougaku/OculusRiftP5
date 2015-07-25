boolean isFullScreen = true;
//boolean isFullScreen = false;

OculusRift oculus;
PanoramaSphere psphere;
PImage img;

boolean sketchFullScreen() {
  return isFullScreen;
}

void setup() {
  size( 1920, 1080, P3D );
  oculus = new OculusRift(this);
  oculus.enableHeadTracking();

  psphere = new PanoramaSphere(100);
  img = loadImage("panorama.jpg");
}

void draw() {
  oculus.draw();
}

// Scene for OculusRift
void onDrawScene(int eye) {
  rotateZ(radians(-90)); // this corrects the angle of the view
  psphere.draw(1000, img);
}

void keyPressed() {
  // Reset head state
  if (key==' ') {
    oculus.resetHeadState();
  }
} 

