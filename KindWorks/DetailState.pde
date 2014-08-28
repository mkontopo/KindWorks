
public class DetailState implements State {


  Person p;
  HashMap<String, Button> buttonList;
  DetailBox detailBox;
  PImage ximg;

  public DetailState(Person p) {
    this.p = p;
    ximg = loadImage("x.png");

    buttonList = new HashMap<String, Button>();
    detailBox = new DetailBox(p.getX(), p.getY()+35);
  }


  public void display() {

    detailBox.run(p.getX(), p.getY()+35);
  }


  public void handleClick(float x, float y) {

    if (buttonList.get("CloseButton").isOver(x, y)) {
      vm.getContext().setActivePerson(null);
      p.clearAllStates();
      p.clearLines();
    }

    else if (buttonList.containsKey("ViewSeenUsersButton") && buttonList.get("ViewSeenUsersButton").isOver(x, y)) {
      p.addState("SeenUsersState", p.getSeenUsersState());
      p.getSeenUsersState().addButton( "ViewPotentialVisibilityButton", new Button(30, color(50), color(255), "VIEW POTENTIAL VISIBILITY") );
    } 
    else if (buttonList.containsKey("ViewChallengeButton") && buttonList.get("ViewChallengeButton").isOver(x, y)) {
      Person cp = p.getChallengePeople().get(0);
      if (vm.getPeople().contains(cp) || vm.getViewers().contains(cp)) {
        p.addState("ChallengeStatusState", p.getChallengeStatusState());
        p.addLine(p, p.getChallengePeople().get(0));
        p.getChallengeStatusState().addButton( "CloseButton", new Button(ximg)  );
      }

      p.removeState("DetailState");
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
  //Nonsense 
  public float getTreePixelHeight() {
    return 0;
  }


  //-------Internal Class to handle info box---------------
  private class DetailBox {

    private float x, y;
    private float boxWidth, boxHeight;
    private int gutter;
    private int textBoxHeight = 100;

    private float imgHeight;
    ArrayList<String> text;

    public DetailBox(float x, float y) {
      this.x = x;
      this.y = y;

      gutter = 20;
      boxWidth = p.imgWidth + (gutter*2);

      if (boxWidth < 200) boxWidth = 200;

      text = wordWrap(p.getDescription(), int(p.imgWidth-10));
      textBoxHeight = text.size() * 14;     

      if (p.getPostType().contains("image"))
        imgHeight = p.imgHeight;
      else
        imgHeight = 0;

      //Finally.. the total box height
      boxHeight = imgHeight + textBoxHeight + 50 + (gutter*4);
    }

    public void run() {
      x = p.getX()+30;
      y = p.getY()+20;
      textFont(Anglecia);

      fill(p.getColor());
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

      if (vm.getContext().equals(vm.getConceptTwoContext())) {
        if (p.getChallengePeople().size() <=0) {
          stroke(255);
          line(x+gutter, textY+20, x+100, textY+20);
          text("Has not challenged anybody yet.", x+gutter, textY+40);
        }
      }

      Iterator i = buttonList.entrySet().iterator();
      while (i.hasNext ()) {
        Map.Entry entry = (Map.Entry)i.next();
        String thisKey = (String)entry.getKey();
        Button b = (Button)entry.getValue();
        if (thisKey.equals("CloseButton")) {
          b.display(x, y);
        } 
        else if (thisKey.equals("ViewSeenUsersButton")) {
          b.display(x+gutter, y+imgHeight+textBoxHeight+(gutter*3));
        }
        else if (thisKey.equals("ViewChallengeButton")) {
          b.display(x+gutter, y+imgHeight+textBoxHeight+(gutter*3));
        }
        b.textHighlight();
      }
    }

    public void run(float dx, float dy) {
      this.x = dx;
      this.y = dy;
      run();
    }
  }
  //----------------------
}

