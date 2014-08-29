
public class Button {

  public float x, y, w, h, alpha;
  PImage img;
  private color col, originalCol, txtCol;
  private String buttonText;
  private int buttonGutter;
  private boolean over;
  private boolean active = false;
  private boolean waiting = false;
  private float txtsize;

  public Button(float h, color col, color txtCol, String txt) {
    this.x = 0;
    this.y = 0;
    buttonGutter = 20;
    this.w = textWidth(txt) + buttonGutter;
    this.h = h;
    this.col = col;
    originalCol = col;
    this.txtCol = txtCol;
    buttonText = txt;
    noStroke();
    alpha = 255;
    txtsize = 12;
  }


  public Button(float w, float h, color col, color txtCol, String txt) {
    this(h, col, txtCol, txt);
    this.w = w;
  }
  public Button(PImage img) {
    this(img.width, img.height, color(255, 0), color(255, 0), "");
    this.img = img;
  }



  public void display() {
    //textFont(Dosis_bold);
    //textSize(ceil(textSize*1.2));
    if (active) drawHighlightBox();

    //draw text
    fill(col);
    noStroke();
    rect(x, y, w, h);


    if (!waiting)
      fill(txtCol, alpha);
    else {
      fill(txtCol, map(sin(millis()/100.0), -1, 1, 50, 250));
    }
    textFont(Dosis_bold);
    textSize(txtsize);
    textAlign(CENTER, CENTER);
    text(buttonText, x+(w/2), y+(h/2));
    if (img != null)
      image(img, x, y);
  }
  public void display(float dx, float dy) {
    this.x = dx;
    this.y = dy;
    display();
  }
  public void setFontSize(int sz) {
    txtsize = sz;
  }

  public void boxHighlight() {
    if (this.isOver(mouseX, mouseY)) { 
      drawHighlightBox();
    }
  }
  public void fillHighlight() {
    col = (this.isOver(mouseX, mouseY)) ?  color(50) : originalCol;

    if (active)
      col = color(50);
    else
      col = color(255, 0);
  }

  public void underlineHighlight(float len) {
    if (this.isOver(mouseX, mouseY)) {
      strokeWeight(3);
      stroke(txtCol);
      line(x+8, y+(textSize*2), x+8+len, y+(textSize*2));
    }
  }

  public void textHighlight() {
    if (this.isOver(mouseX, mouseY)) { 
      alpha = 255;
    } 
    else alpha = 200;
  }

  public boolean isOver(float tx, float ty) {
    over = (tx>x && tx<x+w && ty>y && ty<y+h) ? true : false;
    return over;
  }

  public void toggleActive() {
    active = !active;
  }
  public void setActive(boolean a) {
    active = a;
  }
  public void setWaiting(boolean w) {
    waiting = w;
  }
  public boolean isActive() {
    return active;
  }
  public boolean isWaiting() {
    return waiting;
  }

  public void drawHighlightBox() {
    noFill();
    stroke(txtCol);
    strokeWeight(1.5);
    rect(x, y, w, h);
  }
}

