public class BottomMenu implements Menu {
  public Button showAllSeen, showAllPotential;

  ArrayList<Person> people;

  public BottomMenu(ArrayList<Person> people) {
    this.people = people;

    String text1 = "SHOW ALL SEEN USERS";
    String text2 = "SHOW ALL POTENTIAL";

    showAllSeen =      new Button(width/2-(textWidth(text1))-40, height-60, 30, color(255, 0), color(255), text1);
    showAllPotential = new Button(width/2+20, height-60, 30, color(255, 0), color(255), text2);
  }
  public void display() {

    showAllSeen.display();
    showAllSeen.fillHighlight();
    showAllSeen.drawHighlightBox();

    showAllPotential.display();
    showAllPotential.fillHighlight();
    showAllPotential.drawHighlightBox();
  }

  public void handleClick(float x, float y) {

    if (showAllSeen.isOver(x, y)) {
      //Now go through every Person based on the people list you got passed in
      for (Person p : people) {
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

      for (Person p : people) {

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

