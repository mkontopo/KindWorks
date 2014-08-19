
public class Person {

  //Data Associated with a one Person entry
  private String name, location, deedLocation, date, postType, fileName, description;
  private int groupNum;
  private int deed, seenUsersNumber, totalVisibility;
  private Map<String, Integer> SeenUsers; //String Int pair of seen users and their respective visibilities
  private float p_lat, p_lon, d_lat, d_lon;
  private PImage img;

  private float x, y;
  private color col;
  public float imgWidth, imgHeight;

  public float listY, listX;
  private float easing = 0.01;

  State idleState, detailState, potentialVisibilityState, seenUsersState;
  //State state;
  public Map<String, State> visibleStates;

  Person(float x, float y, String input) { //You get one line from the data file
    initPerson(input);

    listX = x;
    listY = y;

    this.x = listX;
    this.y = listY;

    col = selectColor(groupNum);

    visibleStates =  new ConcurrentHashMap<String, State>();

    idleState = new IdleState(this);
    detailState = new DetailState(this);
    potentialVisibilityState = new PotentialVisibilityState(this);
    seenUsersState = new SeenUsersState(this);

    visibleStates.put("IdleState", idleState);

    //state = idleState;
  }

  public void setPosition(float x, float y) {
    this.x = x;
    this.x = y;
  }

  public void display() {
    x = lerp(x, listX, easing);
    y = lerp(y, listY, easing);

    Iterator iterator = visibleStates.entrySet().iterator();
    while (iterator.hasNext ()) {
      Map.Entry entry = (Map.Entry)iterator.next();
      State o = (State)entry.getValue();
      o.display();
    }
  }

  public void handleClick(float x, float y) {

    Iterator it = visibleStates.entrySet().iterator();
    while (it.hasNext ()) {
      Map.Entry entry = (Map.Entry)it.next();
      State o = (State)entry.getValue();
      o.handleClick(x, y);
    }
  }

  //SETTERS AND GETTERS

  public void addState(String k, State v) {
    visibleStates.put(k, v);
  }
  public void removeState(String k) {
    Iterator iter = visibleStates.entrySet().iterator();
    while (iter.hasNext ()) {
      Map.Entry entry = (Map.Entry)iter.next();
      String thisKey = (String)entry.getKey();
      if (thisKey.equals(k)) {
        iter.remove();
      }
    }
  }

  public void clearAllStates() {
    if (!visibleStates.isEmpty()) {
      Iterator i = visibleStates.entrySet().iterator();
      while (i.hasNext ()) {
        Map.Entry entry = (Map.Entry)i.next();
        String thisKey = (String)entry.getKey();
        if (!thisKey.equals("IdleState")) {
          i.remove();
        }
      }

      if(this.containsState("IdleState"))
        ((IdleState)visibleStates.get("IdleState")).nameButton.toggleActive();
    }
  }


  public void setState(State s) {
    //state = s;
  }
  public boolean containsState(String k) {
    //if visibleStates contains this key
    return visibleStates.containsKey(k);
  }

  public float getX() {
    return x;
  }
  public float getY() {
    return y;
  }
  public String getName() {
    return name;
  }
  public int getGroupNumber() {
    return groupNum;
  }
  public String getPostType(){
     return postType; 
  }
  public String getDescription() {
    return description;
  }
  public int getDeedNumber() {
    return deed;
  }
  public PImage getImage() {
    return img;
  }
  public color getColor() {
    return col;
  }
  public int getSeenUsersNumber() {
    return seenUsersNumber;
  }
  public int getTotalVisibility() {
    return totalVisibility;
  }

  public State getDetailState() {
    return detailState;
  }
  public State getIdleState() {
    return idleState;
  }
  public State getPotentialVisibilityState() {
    return potentialVisibilityState;
  }
  public State getSeenUsersState() {
    return seenUsersState;
  }

  private void initPerson(String thisPerson) {
    println("New Person!");
    String[] oneLine = split(thisPerson, ',');
    print("Loading......");
    name = oneLine[0];
    groupNum = int(oneLine[1])-1;

    location = oneLine[2]; //Need to swap $ with ,

    if (!oneLine[3].equals("0")) {
      String[] tloc = split(oneLine[3], '/');
      p_lat = float(tloc[0]);
      p_lon = float(tloc[1]);
    }
    else {
      p_lat = 0;
      p_lon = 0;
    }



    deed = int(oneLine[7]);
    deedLocation = oneLine[8]; //Need to swap $ with ,

    if (!oneLine[3].equals("0")) {
      String[] tdloc = split(oneLine[9], '/');
      d_lat = float(tdloc[0]);
      d_lon = float(tdloc[0]);
    } 
    else {
      d_lat = 0;
      d_lon = 0;
    }

    date = oneLine[10];
    seenUsersNumber = int(oneLine[11]);

    SeenUsers = new HashMap<String, Integer>();
    if (oneLine[12].charAt(0) != '0') {

      String[] peeps = split(oneLine[12], "$");
      int[] visnums = int(split(oneLine[13], "$"));
      for (int i=0; i<peeps.length; i++)
        SeenUsers.put(peeps[i], visnums[i]);
    }

    totalVisibility = int(oneLine[14]);



    postType = oneLine[18];
    fileName = oneLine[19];

    if (fileName.charAt(0) != '0') 
      img = loadImage(fileName);
    else 
      img = loadImage("noPicture.jpg");


    imgWidth = img.width / 3;

    float imgRatio = img.width / imgWidth;
    imgHeight = img.height / imgRatio;
    description = oneLine[20];
    //    char[] td = description.toCharArray();
    //    for(char c : 
    if (!description.equals("0")) description = description.replace('$', ',');
    println("Loaded " + name + ", " + oneLine.length + " items");
    println("--------------");
  }
  public color selectColor(int gn) {
    switch(gn) {
    case 0:
      return #b4c234;
    case 1:
      return #226a73;
    case 2: 
      return #ee8c44;
    default:
      return #cccccc;
    }
  }

  void keyPressed() {
    switch(key) {
    case 'c':
      if (!visibleStates.isEmpty()) {

        Iterator i = visibleStates.entrySet().iterator();
        while (i.hasNext ()) {
          Map.Entry entry = (Map.Entry)i.next();
          String thisKey = (String)entry.getKey();
          if (!thisKey.equals("IdleState")) {
            i.remove();
          }
        }
      }
      break;
    }
  }
}

