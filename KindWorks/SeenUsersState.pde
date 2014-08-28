public class SeenUsersState implements State {

  public Person p;
  public SeenUsersTree seenUsersTree;
  HashMap<String, Button> buttonList;


  public SeenUsersState(Person p) {
    this.p = p;
    buttonList = new HashMap<String, Button>();

    seenUsersTree = new SeenUsersTree(p.getX()+30, p.getY()-20, p.getSeenUsersNumber());
  }

  //inherited methods
  public void display() {

    seenUsersTree.run(p.getX()+30, p.getY()-20);

    Iterator i = buttonList.entrySet().iterator();
    while (i.hasNext ()) {
      Map.Entry entry = (Map.Entry)i.next();
      String thisKey = (String)entry.getKey();
      Button b = (Button)entry.getValue();
      if (thisKey.equals("ViewPotentialVisibilityButton")) {
        b.display(p.getX()+40, seenUsersTree.getTreePixelHeight()+40);
      } 
      b.textHighlight();
    }
  }

  //inherited methods
  public void handleClick(float x, float y) {
    if (buttonList.containsKey("ViewPotentialVisibilityButton")) {
      if (buttonList.get("ViewPotentialVisibilityButton").isOver(x, y)) {
        p.addState("PotentialVisibilityState", p.getPotentialVisibilityState());
      }
    }
  }

  public void addButton(String s, Button b ) {
    buttonList.put(s, b);
  }

  public void removeButton(String k) {
    Iterator iter = buttonList.entrySet().iterator();
    while (iter.hasNext ()) {
      Map.Entry entry = (Map.Entry)iter.next();
      String thisKey = (String)entry.getKey();
      if (thisKey.equals(k)) {
        iter.remove();
      }
    }
  }
  public HashMap getButtonList() {
    return buttonList;
  }

  public float getTreePixelHeight() {
    return seenUsersTree.getTreePixelHeight();
  }

  //---------------------------
  private class SeenUsersTree {


    private float x, y;
    private int numUsers;
    private int spacer = 8;
    public float treePixelHeight;
    private int gutter = 10;

    public SeenUsersTree(float x, float y, int num) {
      this.x = x;
      this.y = y;
      numUsers = num;
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
    }

    public float getTreePixelHeight() {
      return treePixelHeight;
    }
  }
  //---------------------------
}

