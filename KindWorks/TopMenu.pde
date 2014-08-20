public class TopMenu implements Menu {
  public Button[] deeds;
  public Button showAll;

  public int deedSelection;
  ArrayList<Person> people;

  public TopMenu(ArrayList<Person> people) {
    this.people = people;
    deedSelection = 0;

    deeds = new Button[5];
    float tx = 0;
    for (int i=0; i<deeds.length; i++) {
      tx = width-100-((i+1)*20);
      deeds[i] = new Button(tx, 20, 20, 20, color(255, 0), color(255), Integer.toString(5-i));
    }
    showAll = new Button(tx-50, 20, 30, color(255, 0), color(255), "DEEDS");
  }
  public void display() {
    for (Button b : deeds) {
      b.display();
      b.underlineHighlight(12);
    }
    showAll.display();
    showAll.underlineHighlight(textWidth(showAll.buttonText));
  }
  public void handleClick(float x, float y) {
    if (showAll.isOver(x, y)) {
      deedSelection = 0;
      for (Person p : people) {
        p.visibleStates.clear();
        
        if (!p.containsState("IdleState")){
          p.addState( "IdleState", p.getIdleState() );
          p.setLocation(p.getListX(), p.getListY());
        }  
      }
    }
    for (Button b : deeds) {
      if (b.isOver(x, y)) {

        //Okay this is the button we clicked.
        //Find the deed number as an int
        int targetDeed = int(b.buttonText);
        deedSelection = targetDeed;
        println("you clicked " + targetDeed);

        //Now go through every Person based on the people list you got passed in
        for (Person p : people) {
          p.addState( "IdleState", p.getIdleState() );
          p.setLocation(p.getGeoX(), p.getGeoY());
          //For each person, cycle through all visible states

          if (!p.visibleStates.isEmpty() && p.getDeedNumber()!=targetDeed) { 
              //clear all visible states for htis Person 
              
              p.visibleStates.clear();
              //toggle the highlighting off
              
          }
        }
      }
    }
  }

  public int getSelection() {
    return deedSelection;
  }
}

