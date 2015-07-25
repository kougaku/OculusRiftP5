// This code is based on: https://processing.org/examples/texturesphere.html

class PanoramaSphere {

  private PImage img;
  private int numPointsW;
  private int numPointsH_2pi; 
  private int numPointsH;

  private float[] coorX;
  private float[] coorY;
  private float[] coorZ;
  private float[] multXZ;

  public PanoramaSphere(int n) {

    int numPtsW = n;
    int numPtsH_2pi = n;

    // The number of points around the width and height
    numPointsW = numPtsW+1;
    numPointsH_2pi = numPtsH_2pi;  // How many actual pts around the sphere (not just from top to bottom)
    numPointsH = ceil((float)numPointsH_2pi/2)+1;  // How many pts from top to bottom (abs(....) b/c of the possibility of an odd numPointsH_2pi)

    coorX = new float[numPointsW];   // All the x-coor in a horizontal circle radius 1
    coorY = new float[numPointsH];   // All the y-coor in a vertical circle radius 1
    coorZ = new float[numPointsW];   // All the z-coor in a horizontal circle radius 1
    multXZ = new float[numPointsH];  // The radius of each horizontal circle (that you will multiply with coorX and coorZ)

    for (int i=0; i<numPointsW; i++) {  // For all the points around the width
      float thetaW = i*2*PI/(numPointsW-1);
      coorX[i] = sin(thetaW);
      coorZ[i] = cos(thetaW);
    }

    for (int i=0; i<numPointsH; i++) {  // For all points from top to bottom
      if (int(numPointsH_2pi/2) != (float)numPointsH_2pi/2 && i==numPointsH-1) {  // If the numPointsH_2pi is odd and it is at the last pt
        float thetaH = (i-1)*2*PI/(numPointsH_2pi);
        coorY[i] = cos(PI+thetaH); 
        multXZ[i] = 0;
      } else {
        //The numPointsH_2pi and 2 below allows there to be a flat bottom if the numPointsH is odd
        float thetaH = i*2*PI/(numPointsH_2pi);

        //PI+ below makes the top always the point instead of the bottom.
        coorY[i] = cos(PI+thetaH); 
        multXZ[i] = sin(thetaH);
      }
    }
  }


  public void draw(float r, PImage t) { 
    pushStyle();
    noStroke();
    
    float rx = r;
    float ry = r;
    float rz = r;

    // These are so we can map certain parts of the image on to the shape   
    float changeU = -t.width/(float)(numPointsW-1); // <<< flip horizontal >>>
    float changeV = t.height/(float)(numPointsH-1); 
    float v = 0;  // Height variable for the texture

    beginShape(TRIANGLE_STRIP);
    texture(t);
    for (int i=0; i< (numPointsH-1); i++) {  // For all the rings but top and bottom
      // Goes into the array here instead of loop to save time
      float coory = coorY[i];
      float cooryPlus = coorY[i+1];

      float multxz = multXZ[i];
      float multxzPlus = multXZ[i+1];
      float u = t.width;  // Width variable for the texture  <<< flip horizontal >>>

      for (int j=0; j<numPointsW; j++) {  // For all the pts in the ring
        normal(coorX[j]*multxz, coory, coorZ[j]*multxz);
        vertex(coorX[j]*multxz*rx, coory*ry, coorZ[j]*multxz*rz, u, v);
        normal(coorX[j]*multxzPlus, cooryPlus, coorZ[j]*multxzPlus);
        vertex(coorX[j]*multxzPlus*rx, cooryPlus*ry, coorZ[j]*multxzPlus*rz, u, v+changeV);
        u+=changeU;
      }
      v += changeV;
    }
    endShape();
    popStyle();
  }
}

