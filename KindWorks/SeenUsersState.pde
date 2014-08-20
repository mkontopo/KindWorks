
//TODO: Continue pushing Person positions to the buttons...


public class SeenUsersState implements State {

  public Person p;
  public SeenUsersTree seenUsersTree;

  public SeenUsersState(Person p) {
    this.p = p;
    seenUsersTree = new SeenUsersTree(p.getX()+30, p.getY()-20, p.getSeenUsersNumber());
  }

  //inherited methods
  public void display() {

    seenUsersTree.run(p.getX()+30, p.getY()-20);
  }

  //inherited methods
  public void handleClick(float x, float y) {

    if (seenUsersTree.viewPotentialVisibilityButton.isOver(x, y)) {
      p.addState("PotentialVisibilityState", p.getPotentialVisibilityState());
      //p.addState("IdleState", p.getIdleState());
      println("added ok");
    }
  }
  public float getTreePixelHeight() {
    return seenUsersTree.getTreePixelHeight();
  }

  //---------------------------
  private class SeenUsersTree {
    Button viewPotentialVisibilityButton;

    private float x, y;
    private int numUsers;
    private int spacer = 8;
    public float treePixelHeight;
    private int gutter = 10;

    public SeenUsersTree(float x, float y, int num) {
      this.x = x;
      this.y = y;
      numUsers = num;
      
      
      viewPotentialVisibilityButton = new Button(x+gutter, (treePixelHeight+40), 30, color(50), color(255), "VIEW POTENTIAL VISIBILITY");
    }

    void run(float x, float y) {
      this.x = x;
      this.y = y;
      treePixelHeight = y-((numUsers-1)*spacer);
      
      for (int i=0; i<numUsers; i++) {
        fill(p.getColor());
        noStroke();
        ellipse(x, y-(i*spacer), 6, 6);
      }
      
      text(numUsers+" SEEN", x+10, treePixelHeight);
      

      viewPotentialVisibilityButton.display(x+gutter, (treePixelHeight+40));
      viewPotentialVisibilityButton.textHighlight();
    }

    public float getTreePixelHeight() {
      return treePixelHeight;
    }
  }
  //---------------------------
}

