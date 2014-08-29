public class IntroScreen implements Context {
  //PImage intro;
  String b1, b2; 
  Button conceptOneButton, conceptTwoButton;
  VisManager vm;
  String[] text;

  public IntroScreen(VisManager vm) {
    this.vm = vm;
    //intro = loadImage("Intro_Screen.jpg");
    text = loadStrings("intro.txt");

    b1 = "CONCEPT 1";
    b2 = "CONCEPT 2";

    conceptOneButton = new Button(200, 50, color(#40a4a3), color(255), b1);
    conceptTwoButton = new Button(200, 50, color(#2e313c), color(255), b2);
  }

  public void display() {

    //tint(255);
    //image(intro, 0, 0, width, height);

    fill(#40a4a3);
    rect(0, 0, width, height/2);
    fill(#2e313c);
    rect(0, height/2, width, height/2);

    fill(#f1f2f2);
    rect(100, 100, width-200, height-200);


    fill(20);
    //title
    textAlign(CENTER, CENTER);
    textFont(Anglecia_large);
    textSize(50);
    text("KINDWORKS", width/2, 200);   

    //intro text
    textAlign(CENTER, CENTER);
    textFont(Dosis_bold);
    textSize(18);
    
    ArrayList<String> lines = wordWrap(text[0], width/3);
    for(int i=0; i<lines.size(); i++)  {
      String s = lines.get(i);
      text(s, width/2, 300+(i*30)); 
    }
    
    fill(0);
    rect(width/2-25, height-400, 50, 9);
    
    textFont(Anglecia_large);
    textSize(18);
    text("DATA VISUALIZATIONS", width/2, height-350);


    float halfButton = conceptOneButton.w/2;
    int offset = 150;
    conceptOneButton.display(width/2-offset-halfButton, height-200);
    conceptTwoButton.display(width/2+offset-halfButton, height-200);
  }
  public void handleClick(float x, float y) {
    if (conceptOneButton.isOver(x, y)) {
      vm.setContext( vm.getConceptOneIntroContext() );
    }
    else if (conceptTwoButton.isOver(x, y)) {
      vm.setContext( vm.getConceptTwoIntroContext() );
    }
  } 
  public void setPositions() {
  }
  public void initPositions() {
  }
  public void handleKey(char k) {
  }
  public ArrayList<Person> getPeople() {
    return null;
  }
  public void setActivePerson(Person p) {
  }
}

