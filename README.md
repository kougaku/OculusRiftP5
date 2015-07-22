# OculusRiftP5
Oculus Rift Library for Processing

![OculusRift_BasicExample](https://raw.githubusercontent.com/kougaku/OculusRiftP5/master/OculusRift_BasicExample/screenshot.png)


The library is currently distributed by PDE format (OculusRift.pde).
Fisrt, see and run OculusRift_BasicExample.



### How to use

#### Skeleton

```scala
OculusRift oculus;

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

}
```


#### API

| Method  | Description |
|:---------|:------------|
|boolean enableHeadTracking(); |Enables head tracking. |
|void draw();| Draws a stereo image for Oculus Rift display.|
|void resetHeadState();| Resets the head state matrix by current state.|
|PMatrix3D getMatrix();| Gets the current head state matrix.|