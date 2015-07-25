import com.github.sarxos.webcam.Webcam;
import java.awt.image.BufferedImage;
import java.util.List;
import java.awt.Dimension;


class PCapture {
  Webcam webcam;

  public PCapture(int id, int w, int h) {
    super();
    List<Webcam> webcams = Webcam.getWebcams();
    webcam = webcams.get(id);

    Dimension size = new Dimension( w, h );
    webcam.setCustomViewSizes(new Dimension[] { 
      size
    } 
    );

    webcam.setViewSize(size);
    webcam.open();
  }

  PImage getImage() {
    BufferedImage bImg = webcam.getImage();    
    PImage pImg = createImage(bImg.getWidth(), bImg.getHeight(), ARGB);  

    for (int y = 0; y < pImg.height; y++) {  
      for (int x = 0; x < pImg.width; x++) {  
        pImg.pixels[y * pImg.width + x] = bImg.getRGB(x, y);
      }
    }  
    return pImg;
  }
}

