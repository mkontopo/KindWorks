
public class Button {

  public float x, y, w, h, alpha;
  PImage img;
  private color col, originalCol, txtCol;
  private String buttonText;
  private int buttonGutter;
  private boolean over;
  private boolean active = false;
  private boolean waiting = false;

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
    textFont(Dosis_book);
    if (active) drawHighlightBox();

    //draw text
    fill(col);
    noStroke();
    rect(x, y, w, h);


    if (!waiting)
      fill(txtCol, alpha);
    else {
      fill(txtCol, map(sin(millis()/100.0), -1,1, 50,250));
    }
    textSize(12);
    text(buttonText, x+(buttonGutter/2), y+5);
    if (img != null)
      image(img, x, y);
  }
  public void display(float dx, float dy) {
    this.x = dx;
    this.y = dy;
    display();
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
      stroke(txtCol);
      line(x+10, y+(textSize*2), x+10+len, y+(textSize*2));
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
  public boolean isWaiting(){
     return waiting; 
  }

  public void drawHighlightBox() {
    noFill();
    stroke(txtCol);
    strokeWeight(1);
    rect(x, y, w, h);
  }
}

