
public class ConceptOne implements Context {
  VisManager vm;
  ArrayList<Person> people;
  Menu topMenu, bottomMenu;
  PImage legend;
  PImage map;

  public ConceptOne(VisManager vm) {
    this.vm = vm;

    initDeeds();
    String[] input = loadStrings("KindWorksData_Revised.csv");

    people = new ArrayList<Person>();

    topMenu = new TopMenu(people);
    bottomMenu = new BottomMenu(people);

    int[] ypos = new int[3];
    int gutter = 200;
    legend = loadImage("key.jpg");
    map = loadImage("usa.png");

    //TODO: Fix this weird loading bug
    for (int i=0; i<41; i++) {
      int groupNum = int(split(input[i], ",")[1])-1;
      println(i);
      people.add( new Person(gutter+(groupNum*400), 150+(ypos[groupNum]), input[i]) );
      ypos[groupNum] += (textSize*1.75);
    }
  }

  public void display() {
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

    for (Person p : people) {
      p.display();
    }
    topMenu.display();
    bottomMenu.display();
  }


  public void handleClick(float x, float y) {
    for (Person p : people) {
      p.handleClick(x, y);
    }
    topMenu.handleClick(x, y);
    bottomMenu.handleClick(x, y);
  }
  public void handleKey(char k) {
    //Clear all
    if (key=='c' || key=='C') {
      for (Person p : people) {

        if (p.visibleStates.size() > 1)
          p.visibleStates.clear();
        //p.clearAllStates();
      }
    }
  }
}



public class ConceptOneIntro implements Context {

  VisManager vm;
  PImage conceptIntro;
  Button conceptOneButton, conceptTwoButton;

  public ConceptOneIntro(VisManager vm) {
    this.vm = vm;
    conceptIntro = loadImage("ConceptOneIntro.jpg");

    String b1 = "CONCEPT 1";
    String b2 = "CONCEPT 2";
    float halfButton = textWidth(b1)/2;
    conceptOneButton = new Button(width/2-halfButton, 100, 50, color(#40a4a3), color(255), b1);
    conceptTwoButton = new Button(width/2-halfButton, 150, 50, color(#40a4a3), color(255), b2);
  }

  public void display() {

    image(conceptIntro, 0, 0, width, height);
    conceptOneButton.display();
    conceptTwoButton.display();
  }
  public void handleClick(float x, float y) {
    if (conceptOneButton.isOver(x, y)) {
      vm.setContext( vm.getConceptOneContext() );
    }
  } 
  public void handleKey(char k) {
  }
}

