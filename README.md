# OculusRiftP5
Oculus Rift Library for Processing

![OculusRift_BasicExample](/OculusRift_BasicExample/screenshot.png)

The library is currently distributed by PDE format (OculusRift.pde).
First, see and run OculusRift_BasicExample.

##Examples
###OculusRift_BasicExample
This example shows simple scene that contains a wall, a floorboard, a cube, and stereo picture.

<img src="/OculusRift_BasicExample/screenshot.png" width="50%" height="50%" alt="OculusRift_BasicExample">
<br>

###OculusRift_PanoramaView
It shows a spherical panorama view. The included picture was taken by [RICOH THETA](https://theta360.com/).

<img src="/OculusRift_PanoramaView/screenshot.jpg" width="50%" height="50%" alt="OculusRift_PanoramaView">
<br>

###OculusRift_RadarExample
It shows a radar denoting user's head direction.

<img src="/OculusRift_RadarExample/screenshot.png" width="50%" height="50%" alt="OculusRift_RadarExample">
<br>

###OculusRift_VideoSeeThrough

This is an example for making augmented reality. You need web camera for running it. This code uses sarxos's [webcam-capture](https://github.com/sarxos/webcam-capture/) library instead of Processing's Capture class, because jna.jar used by Processing's Capture class conflicts with jna-4.1.0.jar used in OculusRift.pde.

<img src="/OculusRift_VideoSeeThrough/screenshot.jpg" width="50%" height="50%" alt="OculusRift_VideoSeeThrough">
<br>

##Environment
It was checked that it worked in the following environment.
- Oculus Rift DK2
- Oculus Runtime for Windows V0.5.0.1-beta
<br>
<br>

## How to use

### Skeleton

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

Please make the function named "onDrawScene(int eye)" and write a code about 3D scene in it. In the function, the scale is approximately real scale and the unit is a millimeter. The default eye position is on the origin (0, 0, 0) in the scene. The parameter "eye" gives LEFT or RIGHT.
<br>
<br>

### API

| Method  | Description |
|:---------|:------------|
|boolean enableHeadTracking(); |Enables head tracking. |
|void draw();| Draws a stereo image for Oculus Rift display.|
|void resetHeadState();| Resets the head state matrix by current state.|
|PMatrix3D getMatrix();| Gets the current head state matrix.|
<br>

## Acknowledgements
Thanks a lot for the following codes.
 
- [jherico/jovr](https://github.com/jherico/jovr)
- [JOVR – Java bindings for Oculus Rift SDK 0.4.2.0 | Laht's blog](http://laht.info/jovr-java-bindings-for-oculus-rift-sdk-0-4-0/)
- [ixd-hof/Processing](https://github.com/ixd-hof/Processing/tree/master/Examples/Oculus%20Rift/OculusRift_Basic)
- [xohm/SimpleOculusRift](https://github.com/xohm/SimpleOculusRift)
- [mactkg/pg_jack_p3d.pde](https://gist.github.com/mactkg/66f99c9563c6a043e14e)
- [Solved: Using a Quaternion and Vector to construct a camera view matrix](https://social.msdn.microsoft.com/Forums/en-US/ec92a231-2dbf-4f3e-b7f5-0a4d9ea4cae2)

