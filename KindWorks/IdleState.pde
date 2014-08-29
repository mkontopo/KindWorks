
public class IdleState implements State {

  public Person p;
  HashMap<String, Button> buttonList;
  PImage ximg;

  public IdleState(Person p) {
    this.p = p;
    ximg = loadImage("x.png");
    buttonList = new HashMap<String, Button>();
  }

  public void display() {

    Iterator i = buttonList.entrySet().iterator();
    while (i.hasNext ()) {
      Map.Entry entry = (Map.Entry)i.next();
      String thisKey = (String)entry.getKey();
      Button b = (Button)entry.getValue();
      if (thisKey.equals("NameButton")) {
        b.display(p.getX(), p.getY());
        b.boxHighlight();
        fill(p.getColor());
        textFont(Anglecia);
        textSize(floor(height / DISPLAY_SCALER)-4);
        textAlign(LEFT, CENTER);
        text(p.getName(), p.getX()+10, p.getY()+(b.h/2));
      }
    }
  }

  //inherited methods
  public void handleClick(float x, float y) {

    if (buttonList.get("NameButton").isOver(x, y)) {
      vm.getContext().setActivePerson(p); 
      //if (!k.equals("IdleState")) {
      for (Person other : vm.getPeople()) {
        if (!other.equals(this) && other.containsState("IdleState")) {
          other.clearAllStates();
          other.clearLines();
        }
        //other.getIdleState().buttonList.get("NameButton").setActive(true);
      }
      //}

      if (vm.getContext().equals(vm.getConceptOneContext())) {
        p.addState("DetailState", p.getDetailState() );
        p.getDetailState().addButton(  "CloseButton", new Button(ximg)  );
        p.getDetailState().addButton(  "ViewSeenUsersButton", new Button(30, color(50), color(255), "VIEW SEEN USERS") );
      }
      else {

        if (!p.isWaiting()) {
          p.addState("DetailState", p.getDetailState());
          p.getDetailState().addButton( "CloseButton", new Button(ximg)  );

          if (p.getChallengeNames().size() > 0) {
            String txt = "SEE WHO "+ split(p.getName(), " ")[0].toUpperCase() +" CHALLENGED";
            p.getDetailState().addButton( "ViewChallengeButton", new Button(textWidth(txt)+20, 30, color(50), color(255), txt)  );
          }
        } 
        else {       
          //Draw the "Connect Seen Users" lines... 
          if (p.getSeenUsers().size() > 0) {
            //Draw a line from p to each of p's seen users...
            for (String viewerName : p.getSeenUsers().keySet()) {
              if ( containsName(vm.getPeople(), viewerName) )
                p.addVLine(p, getPersonByName(vm.getPeople(), viewerName));
              else if ( containsName(vm.getViewers(), viewerName) )
                p.addVLine(p, getPersonByName(vm.getViewers(), viewerName));
            }
          }

          if (p.zoomable()) {
            for (Person p: vm.getPeople()) p.setZoom(true);
          }
        }
      }


      buttonList.get("NameButton").setActive(true);
    }
  }

  public void addButton(String s, Button b ) {
    buttonList.put(s, b);
  }
  public void removeButton(String k) {
    Iterator iter = buttonList.entrySet().iterator();
    while (iter.hasNext ()) {
      Map.Entry entry = (Map.Entry)iter.next();
      String thisKey = (String)entry.getKey();
      if (thisKey.equals(k)) {
        iter.remove();
      }
    }
  }

  public HashMap getButtonList() {
    return buttonList;
  }


  public float getTreePixelHeight() {
    return 0;
  }
}

