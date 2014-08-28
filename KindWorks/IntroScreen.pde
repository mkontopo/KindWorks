public class IntroScreen implements Context {
  PImage intro;
  String b1, b2; 
  Button conceptOneButton, conceptTwoButton;
  VisManager vm;

  public IntroScreen(VisManager vm) {
    this.vm = vm;
    intro = loadImage("Intro_Screen.jpg");

    b1 = "CONCEPT 1";
    b2 = "CONCEPT 2";


    conceptOneButton = new Button( 50, color(#40a4a3), color(255), b1);
    conceptTwoButton = new Button( 50, color(#40a4a3), color(255), b2);
  }

  public void display() {

    tint(255);
    image(intro, 0, 0, width, height);
    float halfButton = textWidth(b1)/2;
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
  public void handleKey(char k) {
  }
  public ArrayList<Person> getPeople() {
    return null;
  }
  public void setActivePerson(Person p) {
    
  }
}

