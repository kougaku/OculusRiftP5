//boolean isFullScreen = true;
boolean isFullScreen = false;

OculusRift oculus;

boolean sketchFullScreen() {
  return isFullScreen;
}

void setup() {
  size( 1920, 1080, P3D );
  oculus = new OculusRift(this);
  oculus.enableHeadTracking();
}

void draw() {
  oculus.draw();
}

// Scene for OculusRift
void onDrawScene(int eye) {  

  // calculates head direction vector in XZ plane
  PMatrix3D current_matrix = new PMatrix3D();
  getMatrix( current_matrix );
  float dx = current_matrix.m02;
  float dz = current_matrix.m22;
  PVector dir = new PVector(dx, -dz);
  dir.normalize();

  background(50);
  strokeWeight(4);
  fill(255);

  // lights ON
  lights();

  // floor  
  pushMatrix();
  translate( 0, 1200, 0 );
  rotateX(radians(90));
  stroke(0);
  drawPlate( 4000, 4000, 500 );
  popMatrix();

  // cube
  pushMatrix();
  translate( 0, 0, -800 );
  fill(200, 50, 50);
  rotateX(millis()/1000.0);
  rotateY(millis()/900.0);
  box(200);
  popMatrix();

  // lights OFF
  noLights();

  // radar
  drawRadar(dir.x, dir.y);
}

// radar
void drawRadar(float dx, float dy) {
  fill(0, 100);
  stroke(0, 200, 0);

  hint(DISABLE_DEPTH_TEST);
  pushMatrix();
  resetMatrix();
  translate( -50, 50, -100 );
  ellipse( 0, 0, 50, 50 );
  line( 0, 0, 25*dx, 25*dy );
  popMatrix();
  hint(ENABLE_DEPTH_TEST);
}

// plate
void drawPlate(float w, float h, float grid_interval) {
  for (float x=-w/2; x<w/2; x+=grid_interval) {
    line( x, -h/2, 0, x, h/2, 0 );
  }
  for (float y=-h/2; y<h/2; y+=grid_interval) {
    line( -w/2, y, 0, w/2, y, 0 );
  }
  box( w, h, 0.5 );
}

void keyPressed() {
  // Reset head state
  if (key==' ') {
    oculus.resetHeadState();
  }
} 

