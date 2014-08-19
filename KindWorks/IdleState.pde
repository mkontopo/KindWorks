
public class IdleState implements State {

  public Person p;
  public Button nameButton;

  public IdleState(Person p) {
    this.p = p;

    nameButton = new Button(p.getX(), p.getY(), textWidth(p.getName()), 15, color(255, 0), p.getColor(), "");
  }

  public void display() {
    textFont(Anglecia);

    nameButton.display();
    nameButton.boxHighlight();

    fill(p.getColor());
    text(p.getName(), p.getX(), p.getY());
    //text(p.getDeedNumber(), p.getX(), p.getY()+10);
  }

  //inherited methods
  public void handleClick(float x, float y) {
    if (nameButton.isOver(x, y)) {
      //p.setState( p.getDetailState() );

      p.addState("DetailState", p.getDetailState() );
      nameButton.toggleActive();
    }
  }
  public float getTreePixelHeight() {
    return 0;
  }
}
