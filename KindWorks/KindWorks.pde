import java.util.HashMap;
import java.util.concurrent.ConcurrentHashMap;
import java.util.Map;
import java.util.Iterator;

VisManager vm;

public int textSize;
final float DISPLAY_SCALER = 900/14;
PFont Dosis_book, Anglecia;

void setup() {
  size(displayWidth, displayHeight-50);

  textSize = floor(height / DISPLAY_SCALER);
  Dosis_book = createFont("Dosis-Book.ttf", textSize);
  Anglecia = createFont("Anglecia-Pro-Text-Regular.otf", textSize);

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

