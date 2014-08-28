
public class Person {

  //Data Associated with a one Person entry
  private String name, location, deedLocation, date, postType, fileName, description;
  private int groupNum;
  private int deed, seenUsersNumber, totalVisibility;
  private Map<String, Integer> SeenUsers; //String Int pair of seen users and their respective visibilities
  public ArrayList<String> challengeNames;
  public ArrayList<String> completed;
  public ArrayList<Person> challenges;
  private float p_lat, p_lon, d_lat, d_lon;
  private PImage img;
  private boolean waiting = false;
  public boolean zoom = false;
  public boolean zoomable = false;
  private VisManager vm;
  public Person associated; //For non-participants
  ArrayList<Line> lines;
  ArrayList<VLine> viewerLines;

  private float x, y;
  private color col;
  public float imgWidth, imgHeight;

  public float listY, listX;
  public float geoX, geoY, targetX, targetY;
  public float geoXradial, geoYradial;
  private float easing = 0.09;

  State idleState, detailState, potentialVisibilityState, seenUsersState, challengeStatusState;
  //State state;
  public Map<String, State> visibleStates;

  Person(VisManager vm, String input) { //You get one line from the data file
    this.vm = vm;
    lines = new ArrayList<Line>();
    viewerLines = new ArrayList<VLine>();
    challenges = new ArrayList<Person>(); 
    challengeNames = new ArrayList<String>();
    completed = new ArrayList<String>();


    initPerson(input); 
    associated = null;  


    geoX = map(p_lon, -130, -65, 100, width-200);
    geoY = map(p_lat, 55, 20, 100, height-200);

    float theta = random(2*TWO_PI);
    float xoff = cos(theta) * 40;
    float yoff = sin(theta) * 40;
    geoXradial = geoX + xoff;
    geoYradial = geoY + yoff;

    col = selectColor(groupNum);

    visibleStates =  new ConcurrentHashMap<String, State>();

    idleState = new IdleState(this);
    detailState = new DetailState(this);
    potentialVisibilityState = new PotentialVisibilityState(this);
    seenUsersState = new SeenUsersState(this);
    challengeStatusState = new ChallengeStatusState(this);

    visibleStates.put("IdleState", idleState);
    idleState.addButton( "NameButton", new Button(textWidth(name), 15, color(255, 0), col, "") );

    //state = idleState;
  }
  public void initLocation(float xin, float yin) {
    listX = xin;
    listY = yin;
    targetX = listX;
    targetY = listY;
    this.x = listX;
    this.y = listY;
  }

  public void setLocation(float x, float y) {
    targetX = x;
    targetY = y;
  }
  public void associatePerson(Person p) {
    associated = p;
  }

  public void display() {
    x = lerp(x, targetX, easing);
    y = lerp(y, targetY, easing);

    for (Line l : lines) {
      l.display();
    }
    for (VLine l : viewerLines) {
      l.display();
    }

    Iterator iterator = visibleStates.entrySet().iterator();
    while (iterator.hasNext ()) {
      Map.Entry entry = (Map.Entry)iterator.next();
      State state = (State)entry.getValue();
      state.display();
    }
  }

  public void handleClick(float x, float y) {

    Iterator it = visibleStates.entrySet().iterator();
    while (it.hasNext ()) {
      Map.Entry entry = (Map.Entry)it.next();
      State state = (State)entry.getValue();
      state.handleClick(x, y);
    }
  }

  public void removeOthers(ArrayList<Person> people) {

    for (Person p : people) {
      if (!p.equals(this) && p.containsState("DetailState")) {
        p.clearAllStates();
        p.clearLines();
      }
    }
  }

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

  //TODO:  Remove all Buttons as well.....

  public void clearAllStates() {
    
    if (!visibleStates.isEmpty()) {
      
      Iterator i = visibleStates.entrySet().iterator();
      while (i.hasNext ()) {
        Map.Entry entry = (Map.Entry)i.next();
        String thisKey = (String)entry.getKey();
        if (!thisKey.equals("IdleState")) {
          //Remove any buttons associated with it...
          if (((State)entry.getValue()).getButtonList().size() > 0) {
            ((State)entry.getValue()).getButtonList().clear();
          }
          //Now remove it entirely
          i.remove();
        }
      }


      if (this.containsState("IdleState"))
        ((Button)(((IdleState)visibleStates.get("IdleState")).getButtonList().get("NameButton"))).setActive(false); //so ugly...
    }
  }

  public void addLine(Person a, Person b) {
    lines.add( new Line(a, b)  );
  }
  public void addVLine(Person a, Person b) {
    viewerLines.add( new VLine(a, b)  );
  }
  //  public void updateLines(){
  //      for(Line l : lines)
  //        l.update(x,y, challengePeople.get(0).getX(), challengePeople.get(0).getY());
  //  }
  public void clearLines() {
    lines.clear();
    viewerLines.clear();
  }


  public boolean containsState(String k) {
    return visibleStates.containsKey(k);
  }

  public float getX() {
    return x;
  }
  public float getY() {
    return y;
  }
  public float getChallengeX() {
    if (challenges.size() > 0)
      return challenges.get(0).getX();
    else return 0;
  }
  public float getChallengeY() {
    if (challenges.size() > 0)
      return challenges.get(0).getY();
    else return 0;
  }
  public float getGeoX() {
    return geoXradial;
  }
  public float getGeoY() {
    return geoYradial;
  }
  public float getListX() {
    return listX;
  }
  public float getListY() {
    return listY;
  }
  public String getName() {
    return name;
  }
  public String getLocation(){
     String loc =  location.replace('$', ',');
     return loc;
  }
  public int getGroupNumber() {
    return groupNum;
  }
  public String getPostType() {
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
  public Person getAssociatedPerson() {
    return associated;
  }
  public color getColor() {
    return col;
  }
  public int getDeed() {
    return deed;
  }
  public int getSeenUsersNumber() {
    return seenUsersNumber;
  }
  public int getTotalVisibility() {
    return totalVisibility;
  }
  public Map<String, Integer> getSeenUsers() {
    return SeenUsers;
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
  public State getChallengeStatusState() {
    return challengeStatusState;
  }
  public ArrayList<Person> getChallengePeople() {
    return challenges;
  }
  public ArrayList<String> getChallengeNames() {
    return challengeNames;
  }
  public ArrayList<String> getCompleted() {
    return completed;
  }
  public void setWaiting(boolean w) {
    waiting = w;
  }
  public void setZoomable(boolean z) {
    zoomable = z;
  }
  public void setZoom(boolean z) {
    zoom = z;
  }
  public boolean zoomable() {
    return zoomable;
  }
  public boolean isWaiting() {
    return waiting;
  }
  public boolean isZoomed() {
    return zoom;
  }


  private void initPerson(String thisPerson) {
    println("New Person!");
    String[] oneLine = split(thisPerson, ',');
    print("Loading......");
    name = oneLine[0];
    if (name.charAt(0)=='0') name = "No Name";
    groupNum = int(oneLine[1])-1;

    location = oneLine[2]; //Need to swap $ with ,
    //if (!location.equals("0")){
    //location = location.replace('$', ',');
    //}

    if (!oneLine[3].equals("0")) {
      String[] tloc = split(oneLine[3], '/');
      p_lat = float(tloc[0]);
      p_lon = float(tloc[1]);
    }
    else {
      p_lat = 37.5;  //If no position data, put them in the center of USA
      p_lon = -97.5;
    }



    deed = int(oneLine[7]);
    deedLocation = oneLine[8]; //Need to swap $ with ,
    //if (!deedLocation.equals("0")) deedLocation = deedLocation.replace('$', ',');


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
        SeenUsers.put(trim(peeps[i]), visnums[i]);
    }

    totalVisibility = int(oneLine[14]);

    //16 = challenged person
    if (oneLine[16].charAt(0) != '0') {
      if (oneLine[16].indexOf("$") > 0) { //If there's more than one name
        println(oneLine[16]);
        String[] tempNames = split(oneLine[16], '$');
        String[] results = split(oneLine[17], '$');
        println(tempNames);
        for (int k=0; k<tempNames.length; k++) {
          challengeNames.add( tempNames[k] );
          completed.add( results[k] );
        }
      }
      else {
        challengeNames.add( trim(oneLine[16]) );
        completed.add( trim(oneLine[17]) );
      }
    }



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
}

