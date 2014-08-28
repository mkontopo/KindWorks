
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
  public void setPositions() {
  }
  public void setActivePerson(Person p) {
    activePerson = p;
  }

  public void display() {
    if(start){
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

    textFont(Anglecia);
    text("KINDWORKS", width/2-(textWidth("KINDWORKS")/2), 75);

    tint(255);
    image(legend, rs, 20);

    fill(#40a4a3);
    text(deeds[topMenu.getSelection()], width/2-(textWidth(deeds[topMenu.getSelection()])/2), 120);

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
  public void initPositions() {
    initialLocations = new PVector[vm.getPeople().size()];

    int[] ypos = new int[3];
    int gutter = 200;

    for (int i=0; i<vm.people.size(); i++) {
      int groupNum = int(split(vm.input[i], ",")[1])-1;
      initialLocations[i] = new PVector(gutter+(groupNum*400), 150+(ypos[groupNum]));
      vm.getPeople().get(i).initLocation(initialLocations[i].x, initialLocations[i].y);
      ypos[groupNum] += (textSize*1.75);
    }
  }
}



public class ConceptOneIntro implements Context {

  VisManager vm;
  PImage conceptIntro;
  Button conceptOneButton, conceptTwoButton;
  String b1, b2;

  public ConceptOneIntro(VisManager vm) {
    this.vm = vm;
    conceptIntro = loadImage("ConceptOneIntro.jpg");

    b1 = "CONCEPT 1";
    b2 = "CONCEPT 2";

    conceptOneButton = new Button(50, color(#40a4a3), color(255), b1);
    conceptTwoButton = new Button(50, color(#40a4a3), color(255), b2);
  }
  public void setPositions() {
  }

  public void display() {
    tint(255);
    image(conceptIntro, 0, 0, width, height);


    float halfButton = textWidth(b1)/2;
    conceptOneButton.display(width/2-halfButton, 100);
    conceptTwoButton.display(width/2-halfButton, 150);
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

