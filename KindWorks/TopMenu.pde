public class TopMenu implements Menu {
  public Button[] deeds;
  public Button showAll;
  Context context;

  public int deedSelection;

  public TopMenu(Context c) {
    this.context = c;
    deedSelection = 0;

    deeds = new Button[5];
    for (int i=0; i<deeds.length; i++) { 
      deeds[i] = new Button(25, 25, color(255, 0), color(255), Integer.toString(5-i));
      deeds[i].setFontSize(20);
    }
    showAll = new Button(25, color(255, 0), color(255), "DEEDS");
    showAll.setFontSize(20);
  }
  public void display() {
    int c = 0;
    for (Button b : deeds) {
      b.display(width-100-((++c+1)*20), 20);
      b.underlineHighlight(12);
    }
    showAll.display(width-150-((++c+1)*20), 20);
    showAll.underlineHighlight(textWidth(showAll.buttonText));
  }
  public void handleClick(float x, float y) {

    if (showAll.isOver(x, y)) {
      vm.getContext().setActivePerson(null);
      deedSelection = 0;
      for (Person p : vm.getPeople()) {
        //p.visibleStates.clear();
        p.clearAllStates();

        if (!p.containsState("IdleState")) {
          p.addState( "IdleState", p.getIdleState() );
        }
        p.setLocation(p.getListX(), p.getListY());
      }
    }
    for (Button b : deeds) {
      if (b.isOver(x, y)) {
        vm.getContext().setActivePerson(null);
        vm.getContext().initPositions();
        //Okay this is the button we clicked.
        //Find the deed number as an int
        int targetDeed = int(b.buttonText);
        deedSelection = targetDeed;
        //println("you clicked " + targetDeed);

        //Now go through every Person based on the people list
        for (Person p : vm.getPeople()) {
          p.addState( "IdleState", p.getIdleState() );
          //p.setLocation(p.getGeoX(), p.getGeoY());
          if (!p.visibleStates.isEmpty() && p.getDeedNumber()!=targetDeed) { 
            p.visibleStates.clear();
          } 
          else if (p.getDeedNumber() == targetDeed) {
            //p.setLocation(findXPos(p.geoX), findXPos(p.geoY));
            
          }
        }
        context.setPositions();
      }
    }
  }

  public int getSelection() {
    return deedSelection;
  }
}

public class TopMenuTwo extends TopMenu {
  ArrayList<Person> viewers;

  public TopMenuTwo(Context c) {
    super(c);
  }
  public void handleClick(float x, float y) {

    if (showAll.isOver(x, y)) {
      vm.getContext().setActivePerson(null);
      deedSelection = 0;
      for (Person p : vm.getPeople()) {
        //p.visibleStates.clear();
        p.clearAllStates();
        p.clearLines();

        if (!p.containsState("IdleState")) {
          p.addState( "IdleState", p.getIdleState() );
          p.setLocation(p.getListX(), p.getListY());
        }
      }
      for (Person p : vm.getViewers()) {
        //p.visibleStates.clear();
        p.clearAllStates();
        p.clearLines();

        if (!p.containsState("IdleState")) {
          p.addState( "IdleState", p.getIdleState() );
          p.setLocation(p.getListX(), p.getListY());
        }
      }
    }
    for (Button b : deeds) {
      if (b.isOver(x, y)) {
        vm.getContext().setActivePerson(null);
        //vm.clearLines();
        //Okay this is the button we clicked.
        //Find the deed number as an int
        int targetDeed = int(b.buttonText);
        deedSelection = targetDeed;
        //println("you clicked " + targetDeed);

        //Now go through every Person based on the people list you got passed in
        for (Person p : vm.getPeople()) {
          p.addState( "IdleState", p.getIdleState() );
          if (!p.visibleStates.isEmpty() && p.getDeedNumber()!=targetDeed) { 
            if (sawDeed(p, targetDeed) == false) {
              p.visibleStates.clear();
              p.clearLines();
            }
          }
        }
        for (Person p : vm.getViewers()) {
          p.addState( "IdleState", p.getIdleState() );
          if (sawDeed(p, targetDeed) == false) {
            p.visibleStates.clear();
            p.clearLines();
          }
        }
      }
      
    }
    context.setPositions();
  }
  public boolean sawDeed(Person tp, int deed) {
    //does your name appear the SeenUsers list for a person who completed deed n
    boolean result;
    for (Person p : vm.getPeople()) {
      if (p.getDeed() == deed && p.getSeenUsers().containsKey(trim(tp.getName()))) { 
        //println("found somebody");
        return true;
      }
    }
    return false;
  }
}

