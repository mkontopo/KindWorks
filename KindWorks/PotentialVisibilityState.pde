
public class PotentialVisibilityState implements State {

  HashMap<String, Button> buttonList;
  Person p;
  PImage temp_tree;
  float ypos, dia;

  public PotentialVisibilityState(Person p) {
    buttonList = new HashMap<String, Button>();
    this.p = p;
    temp_tree = loadImage("temp_tree.png");

    //if the person's list has a "seenuserstate" in it, we grab the height from that
    //otherwise the height is p.y-n
  }


  public void display() {
    dia = map(p.getTotalVisibility(), 0, 10000, 10, 200);

    if (p.containsState("SeenUsersState")) {
      ypos = p.getSeenUsersState().getTreePixelHeight()-(dia/2);
    }
    else ypos = p.getY()-80;

    tint(p.getColor());
    image(temp_tree, p.getX()+30-(dia/2), ypos, dia, dia);

    fill(p.getColor());
    text(p.getTotalVisibility() + " POTENTIAL VISIBILITY", p.getX()+30, ypos);
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
    return 0;//seenUsersTree.getTreePixelHeight();
  }

  //inherited methods
  public void handleClick(float x, float y) {
    //if we click the name (button)
    //then set the state of the person to DetailState
  }
}

