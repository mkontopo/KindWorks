public class IntroScreen implements Context {
  VisManager vm;
  PImage intro;
  Button conceptOneButton, conceptTwoButton;

  public IntroScreen(VisManager vm) {
    this.vm = vm;
    intro = loadImage("Intro_Screen.jpg");
    
    String b1 = "CONCEPT 1";
    String b2 = "CONCEPT 2";
    int offset = 150;
    float halfButton = textWidth(b1)/2;
    conceptOneButton = new Button(width/2-offset-halfButton,  height-200, 50,  color(#40a4a3), color(255), b1);
    conceptTwoButton = new Button(width/2+offset-halfButton,  height-200, 50, color(#40a4a3), color(255), b2);
  }

  public void display() {

    image(intro, 0, 0, width, height);
    conceptOneButton.display();
    conceptTwoButton.display();
  }
  public void handleClick(float x, float y) {
    if(conceptOneButton.isOver(x,y)){
      vm.setContext( vm.getConceptOneIntroContext() );
    }
  } 
  public void handleKey(char k) {
  }
}

