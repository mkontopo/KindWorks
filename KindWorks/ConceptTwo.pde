
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
    if(start){
      initPositions();
      start = false;
    }
    
    background(#2e313c);

    fill(#f1f2f2);
    int rs = 100;
    rect(rs, rs, width-(2*rs), height-(2*rs));

    textFont(Anglecia);
    text("KINDWORKS", width/2-(textWidth("KINDWORKS")/2), 75);

    tint(255);
    image(legend, rs, 20);

    fill(#40a4a3);
    text(deeds[topMenuTwo.getSelection()], width/2-(textWidth(deeds[topMenuTwo.getSelection()])/2), 120);

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
  public float findXPos(float xin) {
    //Split the screen into n sections
    int n = 12;
    float oneCol = width / n;
    float[] xs = new float[n-1];
    //init list
    for (int i=0; i<xs.length; i++) {
      xs[i] = (i+1) * oneCol;
    }
    //search list
    for (int i=0; i<xs.length; i++) {
      if (xin - xs[i] < oneCol) {
        return xs[i];
      }
    }
    return width/2;
  }
  public void initPositions() {
    for (String state : vm.states) {
      float ypos = 200;
      float ypos2 = 200;
      for (Person p : vm.getPeople()) {
        String tstate = "";

        if (p.location.charAt(0) != ('0')) {
          tstate = split(p.location, '$')[1];
          tstate = trim(tstate);
          if (tstate.equals(state) && p.visibleStates.size()>0) {
            p.initLocation(findXPos(p.geoX), ypos);
            //p.initLocation(p.geoX, ypos);
            ypos+=20;
          }
        }
        else {
          p.initLocation(width/2+random(-200,200), ypos2);
          ypos2 += 20;
        }
      }//end Person for
      for (Person p : vm.getViewers()) {
        String tstate = "";

        if (p.location.charAt(0) != ('0')) {
          tstate = split(p.location, '$')[1];
          tstate = trim(tstate);
          if (tstate.equals(state) && p.visibleStates.size()>0) {
            p.initLocation(p.getAssociatedPerson().geoX, ypos);
            ypos+=20;
          }
        }
        else {
          p.initLocation(width/2, ypos2);
          ypos2 += 20;
        }
      }//end Viewers for
    }//end state for
  }

  public void setPositions() {
    for (String state : vm.states) {
      float ypos = 200;
      float ypos2 = 200;
      for (Person p : vm.getPeople()) {
        String tstate = "";

        if (p.location.charAt(0) != ('0')) {
          tstate = split(p.location, '$')[1];
          tstate = trim(tstate);
          if (tstate.equals(state) && p.visibleStates.size()>0) {
            p.setLocation(findXPos(p.geoX), ypos);
            //p.initLocation(p.geoX, ypos);
            ypos+=20;
          }
        }
        else {
          p.setLocation(width/2, ypos2);
          ypos2 += 20;
        }
      }//end Person for
      for (Person p : vm.getViewers()) {
        String tstate = "";

        if (p.location.charAt(0) != ('0')) {
          tstate = split(p.location, '$')[1];
          tstate = trim(tstate);
          if (tstate.equals(state) && p.visibleStates.size()>0) {
            p.setLocation(findXPos(p.getAssociatedPerson().getX()), ypos);
            ypos+=20;
          }
        }
        else {
          p.setLocation(width/2, ypos2);
          ypos2 += 20;
        }
      }//end Viewers for
    }//end state for
  }
}



public class ConceptTwoIntro implements Context {
  VisManager vm;
  PImage conceptIntro;
  Button conceptOneButton, conceptTwoButton;
  String b1, b2;

  public ConceptTwoIntro(VisManager vm) {
    this.vm = vm;
    conceptIntro = loadImage("ConceptTwoIntro.jpg");

    b1 = "CONCEPT 1";
    b2 = "CONCEPT 2";

    conceptOneButton = new Button(50, color(#40a4a3), color(255), b1);
    conceptTwoButton = new Button(50, color(#40a4a3), color(255), b2);
  }

  public void display() {
    tint(255);
    image(conceptIntro, 0, 0, width, height);


    float halfButton = textWidth(b1)/2;
    conceptOneButton.display(width/2-halfButton, 100);
    conceptTwoButton.display(width/2-halfButton, 150);
  }
  public void setPositions() {
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
      for(Person p : vm.getPeople()) p.clearLines();
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

