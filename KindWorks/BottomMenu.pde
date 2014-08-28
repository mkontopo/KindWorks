public class BottomMenu implements Menu {
  public Button showAllSeen, showAllPotential;
  String text1, text2;
  Context context;

  public BottomMenu(Context c) {
    this.context = c;

    text1 = "SHOW ALL SEEN USERS";
    text2 = "SHOW ALL POTENTIAL";

    showAllSeen =      new Button(30, color(255, 0), color(255), text1);
    showAllPotential = new Button(30, color(255, 0), color(255), text2);
  }
  public void display() {

    showAllSeen.display(width/2 - (textWidth(text1)/2) - 100, height-80 );
    showAllSeen.fillHighlight();
    showAllSeen.drawHighlightBox();

    showAllPotential.display(width/2 - (textWidth(text2)/2) + 100, height-80);
    showAllPotential.fillHighlight();
    showAllPotential.drawHighlightBox();
  }

  public void handleClick(float x, float y) {
    
    if (showAllSeen.isOver(x, y)) {
      vm.getContext().setActivePerson(null);
      //Now go through every Person based on the people list you got passed in
      for (Person p : vm.getPeople()) {
        if (p.containsState("IdleState")) {
          if (!showAllSeen.isActive()) {
            p.addState( "SeenUsersState", p.getSeenUsersState() );
          }
          else {
            p.removeState( "SeenUsersState" );
          }
        }
      }
      showAllSeen.toggleActive();
    }
    if (showAllPotential.isOver(x, y)) {

      //Now go through every Person based on the people list you got passed in
      vm.getContext().setActivePerson(null);
      for (Person p : vm.getPeople()) {

        //If it's not already in the list
        if (p.containsState("IdleState")) {
          if (!showAllPotential.isActive()) {
            p.addState( "PotentialVisiblityState", p.getPotentialVisibilityState() );
          } 
          else {
            p.removeState("PotentialVisiblityState");
          }
        }
      }
      showAllPotential.toggleActive();
    }
  }
  public int getSelection() {
    return 0;
  }
}

public class BottomMenuTwo implements Menu {

  public Button viewAllChallengeUsers, connectSeenUsers, viewPotentialVisibility;
  String text1, text2, text3;

  ArrayList<Person> people;
  Context context;

  public BottomMenuTwo(Context c) {

    text1 = "VIEW ALL CHALLENGE CONNECTIONS";
    text2 = "CONNECT SEEN USERS";
    text3 = "VIEW POTENTIAL VISIBILITY";

    viewAllChallengeUsers =    new Button(30, color(255, 0), color(255), text1);
    connectSeenUsers =         new Button(30, color(255, 0), color(255), text2);
    viewPotentialVisibility =  new Button(30, color(255, 0), color(255), text3);
  }
  public void display() {
    viewAllChallengeUsers.display(width/3 - (textWidth(text1)/2), height-80 );
    viewAllChallengeUsers.fillHighlight();
    viewAllChallengeUsers.drawHighlightBox();

    connectSeenUsers.display(width/2 - (textWidth(text2)/2), height-80);
    connectSeenUsers.fillHighlight();
    connectSeenUsers.drawHighlightBox();

    viewPotentialVisibility.display(2*width/3 - (textWidth(text3)/2), height-80);
    viewPotentialVisibility.fillHighlight();
    viewPotentialVisibility.drawHighlightBox();

    if (connectSeenUsers.isWaiting()) {
      fill(50);
      String t = "Select a name to view Seen Users";
      text(t, width/2-(textWidth(t)/2), height-120);
    }
  }

  public void handleClick(float x, float y) {
    //First Button
    if (viewAllChallengeUsers.isOver(x, y)) {
      vm.getContext().setActivePerson(null);
      for (Person p : vm.getPeople()) {
        if (p.containsState("IdleState")) {
          if (!viewAllChallengeUsers.isActive() && p.getChallengePeople().size()>0) {
            ((Button)(((IdleState)p.visibleStates.get("IdleState")).getButtonList().get("NameButton"))).setActive(true);
            //add this persons challenge line
            p.addLine(p, p.getChallengePeople().get(0));
          }
          else {
            ((Button)(((IdleState)p.visibleStates.get("IdleState")).getButtonList().get("NameButton"))).setActive(false);
            //clear all challenge lines
            p.clearLines();
          }
        }
      }
      viewAllChallengeUsers.toggleActive();
    }

    //Second Button
    if (connectSeenUsers.isOver(x, y)) {
      vm.getContext().setActivePerson(null);
      if (!connectSeenUsers.isWaiting()) {
        connectSeenUsers.setWaiting(true);
        for (Person p : vm.getPeople()) { 
          p.setWaiting(true); 
        }
      }
      else {
        connectSeenUsers.setWaiting(false);

        for (Person p : vm.getPeople()) { 
          p.setWaiting(false);
          p.clearLines();
        }
      }

      connectSeenUsers.toggleActive();
    }

    //Third Button
    if (viewPotentialVisibility.isOver(x, y)) {
      vm.getContext().setActivePerson(null);
      if (!viewPotentialVisibility.isWaiting()) {
        viewPotentialVisibility.setWaiting(true);
        for (Person p : vm.getPeople()){
          p.setWaiting(true);
          p.setZoomable(true);
        }
      }
      else {
        viewPotentialVisibility.setWaiting(false);
        for (Person p : vm.getPeople()) { 
          p.setWaiting(false);
          p.clearLines();
          p.setZoomable(false);
          p.setZoom(false);
        }
      }

      viewPotentialVisibility.toggleActive();
    }
  }


  public int getSelection() {
    return 0;
  }
}

