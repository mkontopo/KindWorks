
public class VisManager {

  public Context conceptOne, conceptOneIntro, introScreen;
  public Context context;
  
  public VisManager() {
    introScreen = new IntroScreen(this);
    conceptOneIntro = new ConceptOneIntro(this);
    conceptOne = new ConceptOne(this);
    
    context = introScreen;

    textAlign(LEFT, TOP);
    smooth();
    cursor(loadImage("cross.png"), 8, 8);
  }

  public void run() {
    context.display();
  }
  public void setContext(Context input){
     context = input;
  }
  
  public Context getConceptOneContext(){
     return conceptOne; 
  }
  public Context getIntroScreenContext(){
     return introScreen; 
  }
  public Context getConceptOneIntroContext(){
     return conceptOneIntro; 
  }
  

  public void mousePressed() {
    context.handleClick(mouseX,mouseY);
  }
  public void keyPressed() {
    context.handleKey(key);
  }
}

