
public class ConceptTwo implements Context {

  public Menu topMenuTwo, bottomMenuTwo;
  VisManager vm;

  public PImage legend;
  float x, y, targetx, targety, targetZoom, zoomFactor;
  private boolean start = true;
  public Person activePerson;

  public ConceptTwo(VisManager vm) {
    this.vm = vm;
    activePerson = null;

    targetZoom = 1.0;
    zoomFactor = 1.0;
    targetx = 0;
    targety = 0;

    topMenuTwo = new TopMenuTwo(this);
    bottomMenuTwo = new BottomMenuTwo(this);
    legend = loadImage("conceptTwoKey.jpg");
  }

  public void display() {
    if (start) {
      initPositions();
      start = false;
    }

    background(#2e313c);

    fill(#f1f2f2);
    int rs = 100;
    rect(rs, rs, width-(2*rs), height-(2*rs));

    textFont(Anglecia_large);
    text("KINDWORKS", width/2-(textWidth("KINDWORKS")/2), 65);

    tint(255);
    image(legend, rs, 20);

    fill(#40a4a3);
    textFont(Anglecia);
    text(deeds[topMenuTwo.getSelection()], width/2, 120);

    if (!vm.getPeople().get(0).isZoomed()) {
      targetZoom = 1.0;
      targetx = 0;
      targety = 0;
    }
    else {
      targetZoom = 0.5;
      targetx = width/4-50;
      targety = height/4-200;
    }
    zoomFactor = lerp(zoomFactor, targetZoom, 0.09);
    x = lerp(x, targetx, 0.09);
    y = lerp(y, targety, 0.09);

    pushMatrix();
    translate(x, y);
    scale(zoomFactor);
    showNames();
    popMatrix();

    if (targetZoom < 1.0 && activePerson != null) {
      textSize(60);
      fill(activePerson.getColor());
      StringBuilder sb = new StringBuilder();
      sb.append("");
      sb.append(activePerson.getTotalVisibility());
      String t = sb.toString();
      text(t, width/2-(textWidth(t)/2), height-250);
      fill(#2e313c);
      textSize(16);
      String tt = "number of potential influence of reach with kind deeds.";
      text(tt, width/2-(textWidth(tt)/2), height-180);
    }

    if (activePerson != null) {
      fill(activePerson.getColor());
      text(activePerson.getLocation(), width-200, height-100);
    }

//    for (int j=0; j<vm.states.size(); j++) {
//      fill(255, 0, 0);
//      ellipse(vm.stateLocs.get(j).x, vm.stateLocs.get(j).y, 8, 8);
//    }

    topMenuTwo.display();
    bottomMenuTwo.display();
  }

  private void showNames() {
    for (Person p : vm.people)
      p.display();
    for (Person p : vm.viewers)
      p.display();
  }

  public void setActivePerson(Person p) {
    activePerson = p;
  }


  public void handleClick(float x, float y) {
    for (Person p : vm.people) {
      p.handleClick(x, y);
    }
    topMenuTwo.handleClick(x, y);
    bottomMenuTwo.handleClick(x, y);
  }
  public void handleKey(char k) {
    //Clear all
    if (key=='c' || key=='C') {
      for (Person p : vm.people) {

        if (p.visibleStates.size() > 1)
          p.visibleStates.clear();
        //p.clearAllStates();
      }
    }
    else if (key == 'm' || key=='M') {
      vm.setContext( vm.getIntroContext() );
    }
  }
  public ArrayList<Person> getPeople() {
    return vm.people;
  }
  int spacer = 25;
  public void initPositions() {


    for (int j=0; j<vm.states.size(); j++) {
      String state = vm.states.get(j);

      float xpos = findXPos(vm.stateLocs.get(j).x);
      //if(xpos == 0) xpos = findXPos(width/2);
      float ypos = 150;//vm.stateLocs.get(j).y;//constrain((vm.stateLocs.get(j).y) / 5.0, 150, height);
      float ypos2 = ypos;


      for (int k=0; k<j; k++) {
        if (   abs( findXPos(vm.stateLocs.get(j).x) - findXPos(vm.stateLocs.get(k).x) ) < 5  ) {
          //println(vm.states.get(j) + " is on top of " + vm.states.get(k) );
          ypos = vm.lastKnownY.get(k);
          ypos2 = ypos;
        }
      }
      //println("Starting Y for " + vm.states.get(j) + " = " + ypos);
      for (Person p : vm.getPeople()) {
        String tstate = "";
        //println("Drawing " + p.getName() + " at " + xpos);

        if (p.location.charAt(0) != ('0')) {
          tstate = split(p.location, '$')[1];
          tstate = trim(tstate);
          if (tstate.equals(state) && p.visibleStates.size()>0) {

            p.initLocation(xpos, ypos);
            //p.initLocation(findXPos(p.geoX), ypos);
            //p.initLocation(p.geoX, ypos);
            ypos+=spacer;
          }
        }
        else {
          p.initLocation(findXPos(width/2), ypos2);
          ypos2 +=spacer;
        }
      }//end Person for

        for (Person v : vm.getViewers()) {
        String tstate = "";

        if (v.getAssociatedPerson().location.charAt(0) != ('0')) {
          tstate = split(v.getAssociatedPerson().location, '$')[1];
          tstate = trim(tstate);
          if (tstate.equals(state) && v.visibleStates.size()>0) {
            v.initLocation(xpos, ypos);
            //v.initLocation(findXPos(v.getAssociatedPerson().geoX), ypos);
            ypos+=spacer;
          }
        }
        else {
          //v.initLocation(xpos, ypos2);
          v.initLocation(findXPos(width/2), ypos2);
          ypos2 += spacer;
        }
      }//end Viewers for  

        vm.lastKnownY.set(j, ypos);
      //print("Last known y for " + vm.states.get(j) + " = " + vm.lastKnownY.get(j) + " ...  ");
    }//end state for
  }

  public void setPositions() {
    for (int j=0; j<vm.states.size(); j++) {
      String state = vm.states.get(j);

      float xpos = findXPos(vm.stateLocs.get(j).x);
      //if(xpos == 0) xpos = findXPos(width/2);
      float ypos = 150;//vm.stateLocs.get(j).y;//constrain((vm.stateLocs.get(j).y) / 5.0, 150, height);
      float ypos2 = ypos;


      for (int k=0; k<j; k++) {
        if (   abs( findXPos(vm.stateLocs.get(j).x) - findXPos(vm.stateLocs.get(k).x) ) < 5  ) {
          //println(vm.states.get(j) + " is on top of " + vm.states.get(k) );
          ypos = vm.lastKnownY.get(k);
          ypos2 = ypos;
        }
      }
      //println("Starting Y for " + vm.states.get(j) + " = " + ypos);
      for (Person p : vm.getPeople()) {
        String tstate = "";
        //println("Drawing " + p.getName() + " at " + xpos);

        if (p.location.charAt(0) != ('0')) {
          tstate = split(p.location, '$')[1];
          tstate = trim(tstate);
          if (tstate.equals(state) && p.visibleStates.size()>0) {

            p.setLocation(xpos, ypos);
            //p.initLocation(findXPos(p.geoX), ypos);
            //p.initLocation(p.geoX, ypos);
            ypos+=spacer;
          }
        }
        else {
          p.setLocation(findXPos(width/2), ypos2);
          ypos2 += spacer;
        }
      }//end Person for

        for (Person v : vm.getViewers()) {
        String tstate = "";

        if (v.getAssociatedPerson().location.charAt(0) != ('0')) {
          tstate = split(v.getAssociatedPerson().location, '$')[1];
          tstate = trim(tstate);
          if (tstate.equals(state) && v.visibleStates.size()>0) {
            v.setLocation(xpos, ypos);
            //v.initLocation(findXPos(v.getAssociatedPerson().geoX), ypos);
            ypos+=spacer;
          }
        }
        else {
          //v.initLocation(xpos, ypos2);
          v.setLocation(findXPos(width/2), ypos2);
          ypos2 += spacer;
        }
      }//end Viewers for  

        vm.lastKnownY.set(j, ypos);
      //print("Last known y for " + vm.states.get(j) + " = " + vm.lastKnownY.get(j) + " ...  ");
    }//end state for
  }
}



public class ConceptTwoIntro implements Context {
  VisManager vm;
  Button conceptOneButton, conceptTwoButton;
  String[] text;
  String b1, b2;

  public ConceptTwoIntro(VisManager vm) {
    this.vm = vm;
    text = loadStrings("conceptTwo.txt");

    b1 = "CONCEPT 1";
    b2 = "CONCEPT 2";

    conceptOneButton = new Button(150, 50, color(#f1f2f2), color(#40a4a3), b1);
    conceptTwoButton = new Button(150, 50, color(#f1f2f2), color(#40a4a3), b2);
  }

  public void display() {
    noStroke();
    //bg colors
    fill(#40a4a3);
    rect(0, 0, width, height/2);

    fill(#2e313c);
    rect(0, height/2, width, height/2);

    fill(#f1f2f2);
    rect(100, 100, width-200, height-200);


    fill(240);
    //title
    textAlign(CENTER, CENTER);
    textFont(Anglecia_large);
    textSize(35);
    text("KINDWORKS", width/2, 20);   

    //intro text
    textAlign(CENTER, CENTER);
    textFont(Dosis_book);

    fill(15);
    textSize(35);
    text("CONCEPT 2", width/2, height/2-70);

    textSize(18);
    ArrayList<String> lines = wordWrap(text[0], width/3);
    for (int i=0; i<lines.size(); i++) {
      String s = lines.get(i);

      text(s, width/2, height/2+60+(i*30));
    }

    fill(#40a4a3);
    ellipse(width/2, height/2, 10, 10);

    float halfButton = conceptOneButton.w/2;
    conceptOneButton.display(width/2-halfButton, 50);
    conceptTwoButton.display(width/2-halfButton, 100);
    conceptOneButton.drawHighlightBox();
    conceptTwoButton.drawHighlightBox();
  }
  public void setPositions() {
  }
  public void initPositions() {
  }
  public void handleClick(float x, float y) {
    if (conceptOneButton.isOver(x, y)) {
      vm.setContext( vm.getConceptOneIntroContext() );
    }
    else if (conceptTwoButton.isOver(x, y)) {
      vm.setContext( vm.getConceptTwoContext() );
    }
  } 
  public void handleKey(char k) {
    if (key == 'm' || key=='M') {
      vm.setContext( vm.getIntroContext() );
      for (Person p : vm.getPeople()) p.clearLines();
    }
  }
  public ArrayList<Person> getPeople() {
    return vm.people;
  }
  public Menu getBottomMenu() {
    return null;
  }
  public void setActivePerson(Person p) {
  }
}

