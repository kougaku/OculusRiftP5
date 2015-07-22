boolean isFullScreen = true;
//boolean isFullScreen = false;

OculusRift oculus;
PImage imgL;
PImage imgR;
PVector position;

boolean sketchFullScreen() {
  return isFullScreen;
}

void setup() {
  size( 1920, 1080, P3D );
  oculus = new OculusRift(this);
  oculus.enableHeadTracking();

  PImage img = loadImage("stereo.jpg");
  imgL = img.get( 0, 0, img.width/2, img.height );
  imgR = img.get( img.width/2, 0, img.width/2, img.height );

  position = new PVector( 0, 1200, 0 );  // 1200 mm from floor.
}

void draw() {
  oculus.draw();
}

// Scene for OculusRift
void onDrawScene(int eye) {
  // The scale is approximately real scale. The unit is a millimeter.
  // The default eye position is on the origin (0, 0, 0) in the scene.
  // The parameter "eye" gives LEFT or RIGHT.

  background(50);
  fill(255);
  translate( position.x, position.y, position.z  );

  // picture
  pushMatrix();
  translate( 0, -1500, -1800 );
  imageMode(CENTER);
  scale(3.0);
  if (eye == LEFT) {
    image(imgL, 0, 0);
  } else if (eye == RIGHT) {
    image(imgR, 0, 0);
  }
  popMatrix();

  // light
  lights();

  // floor
  pushMatrix();
  rotateX(radians(90));
  drawPlate( 4000, 4000, 500 );
  popMatrix();

  // wall
  pushMatrix();
  translate( 0, -1500, -2000 );
  drawPlate( 4000, 3000, 500 );
  popMatrix();

  // cube
  pushMatrix();
  translate( 0, -500, -800 );
  fill(50, 200, 50);
  rotateX(millis()/1000.0);
  rotateY(millis()/900.0);
  box(200);
  popMatrix();
}

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
  
  // Move
  if (keyCode==LEFT) {
    position.x += 20;
  }
  if (keyCode==RIGHT) {
    position.x -= 20;
  }
  if (keyCode==UP) {
    position.z += 20;
  }
  if (keyCode==DOWN) {
    position.z -= 20;
  }
} 

