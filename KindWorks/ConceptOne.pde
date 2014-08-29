
public class ConceptOne implements Context {
  public Menu topMenu, bottomMenu;
  public PImage legend;
  private boolean start = true;
  PVector[] initialLocations;
  VisManager vm;
  public Person activePerson;

  public ConceptOne(VisManager vm) {

    this.vm = vm;
    activePerson = null;

    topMenu = new TopMenu(this);
    bottomMenu = new BottomMenu(this);

    legend = loadImage("key.jpg");
  }
  public void setActivePerson(Person p) {
    activePerson = p;
  }

  public void display() {
    if (start) {
      initPositions();
      start = false;
    }

    background(#40a4a3);

    fill(#f1f2f2);
    int rs = 100;
    rect(rs, rs, width-(2*rs), height-(2*rs));

    //    if (topMenu.getSelection() != 0) {
    //      tint(255);
    //      image(map, rs, rs, width-(2*rs), height-(2*rs));
    //    }

    textFont(Anglecia_large);
    text("KINDWORKS", width/2-(textWidth("KINDWORKS")/2), 65);

    tint(255);
    image(legend, rs, 20);

    fill(#40a4a3);
    textFont(Anglecia);
    text(deeds[topMenu.getSelection()], width/2, 120);

    for (Person p : vm.people) {
      p.display();
    }
    topMenu.display();
    bottomMenu.display();
  }


  public void handleClick(float x, float y) {
    for (Person p : vm.people) {
      p.handleClick(x, y);
    }
    topMenu.handleClick(x, y);
    bottomMenu.handleClick(x, y);
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
  public Menu getBottomMenu() {
    return bottomMenu;
  }
  int spacer = 25;
  public void initPositions() {


    initialLocations = new PVector[vm.getPeople().size()];

    int[] ypos = new int[3];
    int gutter = 300;

    for (int i=0; i<vm.people.size(); i++) {
      int groupNum = int(split(vm.input[i], ",")[1])-1;
      initialLocations[i] = new PVector(gutter+(groupNum*400), 150+(ypos[groupNum]));
      vm.getPeople().get(i).initLocation(initialLocations[i].x, initialLocations[i].y);
      ypos[groupNum] += (textSize*1.75);
    }
  }
  public void setPositions() {
    for (int j=0; j<vm.states.size(); j++) {
      String state = vm.states.get(j);

      float ypos = vm.stateLocs.get(j).y;
      float ypos2 = ypos;
      float xoff=0;

      for (Person p : vm.getPeople()) {
        String tstate = "";

        if (p.location.charAt(0) != ('0')) {
          tstate = split(p.location, '$')[1];
          tstate = trim(tstate);
          if (tstate.equals(state) && p.visibleStates.size()>0) {
            p.setLocation(findXPos(p.geoX)+xoff, ypos);
            ypos+=spacer;
            xoff+=spacer;
          }
        }
        else {
          p.setLocation(findXPos(width/2), ypos2);
          ypos2 += spacer;
          xoff+=spacer;
        }
      }//end Person for
    }//end state for
  }
}



public class ConceptOneIntro implements Context {

  VisManager vm;
  String[] text;
  Button conceptOneButton, conceptTwoButton;
  String b1, b2;

  public ConceptOneIntro(VisManager vm) {
    this.vm = vm;
    text = loadStrings("conceptOne.txt");

    b1 = "CONCEPT 1";
    b2 = "CONCEPT 2";

    conceptOneButton = new Button(150, 50, color(#f1f2f2), color(#40a4a3), b1);
    conceptTwoButton = new Button(150, 50, color(#f1f2f2), color(#40a4a3), b2);
  }
  public void setPositions() {
  }
  public void initPositions() {
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
    text("CONCEPT 1", width/2, height/2-70);

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
  public void handleClick(float x, float y) {
    if (conceptOneButton.isOver(x, y)) {
      vm.setContext( vm.getConceptOneContext() );
    }
    else if (conceptTwoButton.isOver(x, y)) {
      vm.setContext( vm.getConceptTwoIntroContext() );
    }
  } 
  public void handleKey(char k) {
    if (key == 'm' || key=='M') {
      vm.setContext( vm.getIntroContext() );
    }
  }
  public ArrayList<Person> getPeople() {
    return null;
  }
  public Menu getBottomMenu() {
    return null;
  }
  public void setActivePerson(Person p) {
  }
}

