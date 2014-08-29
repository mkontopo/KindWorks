import java.util.HashMap;
import java.util.concurrent.ConcurrentHashMap;
import java.util.Map;
import java.util.Iterator;


public VisManager vm;

final float DISPLAY_SCALER = 900/14;
public int textSize;
public PFont Dosis_book, Dosis_bold, Anglecia, Anglecia_large;

void setup() {
  size(displayWidth, displayHeight-50);

  textSize = floor(height / DISPLAY_SCALER);
  Dosis_book = createFont("Dosis-Medium.ttf", textSize);
  Dosis_bold = createFont("Dosis-SemiBold.ttf", textSize);
  Anglecia = createFont("Anglecia-Pro-Text-Regular.otf", textSize);
  Anglecia_large = createFont("Anglecia-Pro-Text-Regular.otf", textSize*2);

  vm = new VisManager();
}

void draw() {
  vm.run();
}

void mousePressed() {
  vm.mousePressed();
}

void keyPressed() {
  vm.keyPressed();
}

