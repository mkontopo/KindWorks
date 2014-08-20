public interface Context{
   public void display();
   public ArrayList<Person> getPeople();
   public void handleClick(float x, float y); 
   public void handleKey(char k);
   public Menu getBottomMenu();
}
