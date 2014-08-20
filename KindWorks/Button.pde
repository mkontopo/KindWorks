
public class Button {

  public float x, y, w, h, alpha;
  PImage img;
  private color col, originalCol, txtCol;
  private String buttonText;
  private int buttonGutter;
  private boolean over;
  private boolean active = false;

  public Button(float x, float y, float h, color col, color txtCol, String txt) {
    this.x = x;
    this.y = y;
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


  public Button(float x, float y, float w, float h, color col, color txtCol, String txt) {
    this(x, y, h, col, txtCol, txt);
    this.w = w;
  }
  public Button(float x, float y, PImage img) {
    this(x, y, img.width, img.height, color(255, 0), color(255, 0), "");
    this.img = img;
  }



  public void display() {
    textFont(Dosis_book);
    if (active) drawHighlightBox();

    //draw text
    fill(col);
    noStroke();
    rect(x, y, w, h);
    fill(txtCol, alpha);
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
    
    if(active)
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
  public boolean isActive(){
     return active; 
  }

  public void drawHighlightBox() {
    noFill();
    stroke(txtCol);
    strokeWeight(1);
    rect(x, y, w, h);
  }
}

