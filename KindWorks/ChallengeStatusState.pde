
public class ChallengeStatusState implements State {

  public HashMap<String, Button> buttonList;
  public float x, y;

  public Person p;
  public Person challengedPerson;
  private float boxWidth, boxHeight;
  private String txt;

  public ChallengeStatusState(Person p) {
    buttonList = new HashMap<String, Button>();
    this.p = p;
    this.x = p.x;
    this.y = p.y;
    boxWidth = 200;
    boxHeight = 100;
    txt = "";

    if (p.challenges.size() > 0)
      challengedPerson = p.challenges.get(0);
  }


  public void display() {

    x = (p.getX() + p.getChallengeX()) / 2;
    y = (p.getY() + p.getChallengeY()) / 2;

    //    if (p.getChallengeNames() <= 0) {
    //      boxHeight = 100;
    //      txt = split(p.getName(),' ')[0] + " has not challenged anybody yet.";
    //    }

    if (p.getCompleted().size() > 0) {
      if (p.getCompleted().get(0).equals( "Completed" )) {
        txt = p.getChallengeNames().get(0) + " completed the challenge.";
      }
      else {
        txt = p.getChallengeNames().get(0) + " has not yet completed the challenge.";
      }
    } 



    ArrayList<String> words = wordWrap(txt, 150);
    boxHeight = 100 + words.size() * 14;
    fill(p.getColor());
    noStroke();
    rect(x, y, 200, boxHeight);
    fill(255);
    textSize(textSize * 0.9);
    for (int i=0; i<words.size(); i++) {
      String s = words.get(i);
      text(s, x+20, y+50+(i*20));
    }

    Iterator i = buttonList.entrySet().iterator();
    while (i.hasNext ()) {
      Map.Entry entry = (Map.Entry)i.next();
      String thisKey = (String)entry.getKey();
      Button b = (Button)entry.getValue();
      if (thisKey.equals("CloseButton")) {
        b.display(x, y);
      } 
      b.textHighlight();
    }
  }

  public void handleClick(float x, float y) {
    if (buttonList.get("CloseButton").isOver(x, y)) {
      vm.getContext().setActivePerson(null);
      p.clearAllStates();
      p.clearLines();
    }
    else if (buttonList.containsKey("ViewPotentialVisibilityButton")) {
      if (buttonList.get("ViewPotentialVisibilityButton").isOver(x, y)) {
        p.addState("PotentialVisibilityState", p.getPotentialVisibilityState());
      }
    }
  }


  public float getTreePixelHeight() {
    return 0;
  }

  public void addButton(String s, Button b ) {
    buttonList.put(s, b);
  }

  public void removeButton(String k) {
  }
  public HashMap getButtonList() {
    return buttonList;
  }
}

