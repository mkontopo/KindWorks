
public class DetailState implements State {


  Person p;
  DetailBox detailBox;

  public DetailState(Person p) {
    this.p = p;
    detailBox = new DetailBox(p.getX(), p.getY()+35);
  }

  //inherited methods
  public void display() {

    detailBox.run(p.getX(), p.getY()+35);
  }

  //inherited methods
  public void handleClick(float x, float y) {

    if (detailBox.closeButton.isOver(x, y)) {
      //p.removeState("DetailState");
      p.clearAllStates();
    } 
    else if (detailBox.viewSeenUsersButton.isOver(x, y)) {
      p.addState("SeenUsersState", p.getSeenUsersState());
      p.getSeenUsersState().setButtonVisilibity(true);
    }
  }
  public float getTreePixelHeight() {
    return 0;
  }
  public void setButtonVisilibity(boolean result){
    
  }


  //----------------------
  private class DetailBox {
    public Button closeButton;
    public Button viewSeenUsersButton;

    private float x, y;
    private float boxWidth, boxHeight;
    private int gutter;
    private int textBoxHeight = 100;
    PImage ximg;
    private float imgHeight;
    ArrayList<String> text;

    public DetailBox(float x, float y) {
      this.x = x;
      this.y = y;
      ximg = loadImage("x.png");

      gutter = 20;
      boxWidth = p.imgWidth + (gutter*2);

      text = wordWrap(p.getDescription(), int(p.imgWidth-10));
      textBoxHeight = text.size() * 14;     

      if (p.getPostType().contains("image"))
        imgHeight = p.imgHeight;
      else
        imgHeight = 0;

      closeButton = new Button(x, y, ximg);
      viewSeenUsersButton = new Button(x+gutter, y+imgHeight+textBoxHeight+(gutter*3), 30, color(50), color(255), "VIEW SEEN USERS");

      //Finally.. the total box height
      boxHeight = imgHeight + textBoxHeight + viewSeenUsersButton.h + (gutter*4);
    }

    public void run() {
      x = p.getX();
      y = p.getY()+35;
      textFont(Anglecia);

      fill(#FFAC74);
      noStroke();
      rect(x, y, boxWidth, boxHeight);


      tint(255);
      image(p.getImage(), x+gutter, y+gutter, p.imgWidth, imgHeight);


      fill(255);
      float  textY = y+imgHeight+(2*gutter);

      for (String s : text) {
        text(s, x+gutter, textY);
        textY += 14;
      }
      //text(p.getDescription(), x+gutter, y+imgHeight+(2*gutter), p.imgWidth, textBoxHeight);



      closeButton.display(x,y);
      closeButton.textHighlight();
      viewSeenUsersButton.display(x+gutter, y+imgHeight+textBoxHeight+(gutter*3));
      viewSeenUsersButton.textHighlight();
    }
    
    public void run(float dx, float dy){
        this.x = dx;
        this.y = dy;
        run();
    }
  }
  //----------------------
}

