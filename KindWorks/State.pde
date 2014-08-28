public interface State {

  public void handleClick(float x, float y);
  public void display();
  
  public void addButton( String s, Button b );
  public void removeButton(String k);
  public HashMap getButtonList();
  
  public float getTreePixelHeight();
}

