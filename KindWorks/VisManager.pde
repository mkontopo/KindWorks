
public class VisManager {
  //public ArrayList<Line> lines;

  public ArrayList<Person> people;
  public ArrayList<Person> viewers;
  public String[] input;
  public int numLocations;
  public ArrayList<String> states;
  public ArrayList<Float> lastKnownY;
  public ArrayList<PVector> stateLocs;

  public Context conceptOne, conceptTwo, conceptOneIntro, conceptTwoIntro, introScreen;
  public Context context;

  public VisManager() {
    initDeeds();
    //lines = new ArrayList<Line>();

    numLocations = 0;
    states = new ArrayList<String>();
    stateLocs = new ArrayList<PVector>();
    lastKnownY = new ArrayList<Float>();

    people = new ArrayList<Person>();
    viewers =new ArrayList<Person>();

    input = loadStrings("KindWorksData.csv");

    for (int i=0; i<41; i++) {

      //Creating the people array
      Person tempPerson = new Person(this, input[i]);
      people.add( tempPerson );

      //Creating the viewers array for this person
      if (tempPerson.getSeenUsers().size() > 0) {
        for (String name : tempPerson.getSeenUsers().keySet()) {

          if (!containsName(viewers, name)) {
            viewers.add( new Person(this, name+",0,"+tempPerson.location+",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0") );
            //viewers.get(viewers.size()-1).associatePerson(tempPerson);
          }
        }
      }

      //A list of States. For spacing out the people later.
      if (tempPerson.location.charAt(0) != ('0')) {
        println(tempPerson.location);

        String tstate = split(tempPerson.location, '$')[1];
        tstate = trim(tstate);
        if (!states.contains(tstate))
        {
          states.add( tstate );
          stateLocs.add( new PVector(tempPerson.geoX, tempPerson.geoY) );
          lastKnownY.add( 0.0 );
          numLocations++;
        }
      }
    }

    //Another loop that removes participant names from the Viewers list
    for (int i=viewers.size()-1; i>=0; i--) {
      Person viewer = viewers.get(i);
      if (containsName(people, viewer.name))
        viewers.remove(i);
    }
    //A final loop that sets the Associated person for each viewer
    for (Person v : viewers) {
      v.associatePerson( people.get(floor(random(people.size()))) );
    }

    //Assign each person their "challenge" person
    for (Person p : people) {
      if (p.getChallengeNames().size() > 0) {
        String s = p.getChallengeNames().get(0);
        if (containsName(people, s))
          p.getChallengePeople().add( getPersonByName(people, s) );
        else if (containsName(viewers, s)) {
          p.getChallengePeople().add( getPersonByName(viewers, s) );
        }
      }
    }

    //Init Context
    introScreen = new IntroScreen(this);
    conceptOneIntro = new ConceptOneIntro(this);
    conceptTwoIntro = new ConceptTwoIntro(this);
    conceptOne = new ConceptOne(this);
    conceptTwo = new ConceptTwo(this);

    //Assign context
    context = introScreen;

    smooth();
    cursor(loadImage("cross.png"), 8, 8);
  }

  public ArrayList<Person> getPeople() {
    return people;
  }  
  public ArrayList<Person> getViewers() {
    return viewers;
  }  
  public ArrayList<String> getLocations() {
    return states;
  }

  public void run() {
    context.display();
  }

  public void setContext(Context input) {
    context = input;
  }
  public Context getContext() {
    return context;
  }


  public Context getConceptOneContext() {
    return conceptOne;
  }
  public Context getConceptTwoContext() {
    return conceptTwo;
  }
  public Context getIntroContext() {
    return introScreen;
  }
  public Context getConceptOneIntroContext() {
    return conceptOneIntro;
  }
  public Context getConceptTwoIntroContext() {
    return conceptTwoIntro;
  }



  public void mousePressed() {
    context.handleClick(mouseX, mouseY);
  }
  public void keyPressed() {
    context.handleKey(key);
  }
  //  public void addLine(Person a, Person b) {
  //    lines.add( new Line(a.getX(), a.getY(), b.getX(), b.getY())  );
  //  }
  //  public void clearLines(){
  //    lines.clear(); 
  //  }
}

