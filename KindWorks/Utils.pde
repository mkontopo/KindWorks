String[] deeds = new String[6];
public void initDeeds() {
  deeds[0] = "Select a number above to filter by deed.";
  deeds[1] = "In line at coffee shop, pay for someone's coffee behind you.";
  deeds[2] = "Say \"I love you\" to someone you care about.";
  deeds[3] = "Call or write to somebody who changed your life.";
  deeds[4] = "Pay for someone's bus ticket today.";
  deeds[5] = "Come up with your own good deed!";
}
/**
 wordwrap taken from http://wiki.processing.org/index.php?title=Word_wrap_text
 @author Daniel Shiffman
 */

ArrayList wordWrap(String s, int maxWidth) {
  // Make an empty ArrayList
  ArrayList a = new ArrayList();
  float w = 0;    // Accumulate width of chars
  int i = 0;      // Count through chars
  int rememberSpace = 0; // Remember where the last space was
  // As long as we are not at the end of the String
  while (i < s.length ()) {
    // Current char
    char c = s.charAt(i);
    String cc = ""+c;
    w += textWidth(cc); // accumulate width
    if (c == ' ') rememberSpace = i; // Are we a blank space?
    if (w > maxWidth) {  // Have we reached the end of a line?
      String sub = s.substring(0, rememberSpace); // Make a substring
      // Chop off space at beginning
      if (sub.length() > 0 && sub.charAt(0) == ' ') sub = sub.substring(1, sub.length());
      // Add substring to the list
      a.add(sub);
      // Reset everything
      s = s.substring(rememberSpace, s.length());
      i = 0;
      w = 0;
    } 
    else {
      i++;  // Keep going!
    }
  }

  // Take care of the last remaining line
  if (s.length() > 0 && s.charAt(0) == ' ') s = s.substring(1, s.length());
  a.add(s);

  return a;
}

public boolean containsName(ArrayList<Person> peeps, String name) {
  for (int i=0; i<peeps.size(); i++) {
    Person p = peeps.get(i);
    if (trim(p.getName()).equals(trim(name)))
      return true;
  } 
  return false;
}
public Person getPersonByName(ArrayList<Person> peeps, String name) {
  for (int i=0; i<peeps.size(); i++) {
    Person p = peeps.get(i);
    if (trim(p.getName()).equals(trim(name)))
      return p;
  } 
  return null;
}

public float findXPos(float xin) {
  //Split the screen into n sections
  int n = 11;
  float oneCol = width / n;
  float[] xs = new float[n-1];
  //init list
  for (int i=0; i<xs.length; i++) {
    xs[i] = (i+1) * oneCol;
  }
  //search list
  for (int i=0; i<xs.length; i++) {
    if (xin - xs[i] < oneCol) {
      return xs[i];
    }
  }
  return width/2;
}

public class Line {
  Person a, b;
  float cx1, cy1, cx2, cy2, t;
  float bl = 0;
  float dashlength = 5;

  Line(Person a, Person b) {
    this.a = a;
    this.b = b;
  } 
  public void display() {  
    stroke(a.getColor());
    noFill();
    float offset = abs(a.getX() - b.getX())/2;
    //line(a.getX(), a.getY(), b.getX(), b.getY());
    cx1 = (a.getX() < width/2) ? a.getX()+offset : a.getX()-offset;
    cy1 = a.getY();
    cx2 = (b.getX() < width/2) ? b.getX()+offset : b.getX()-offset;
    cy2 = b.getY();

    if (a.getX() == b.getX()) {
      cx1 = a.getX() - 100;
      cx2 = b.getX() - 100;
    }
    //bezier(a.getX(), a.getY(), cx1, cy1, cx2, cy2, b.getX(), b.getY());
    renderBezier(a.getX(), a.getY()+10, cx1, cy1+10, cx2, cy2+10, b.getX(), b.getY()+10);
  }
  private void renderBezier(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
    bl = blength(x1, y1, x2, y2, x3, y3, x4, y4);
    //find any point on the curve:
    t+=0.01;
    if (t>1) {
      t=0;
    }

    double mu, mum1, mum13, mu3;

    mu = t;
    mum1 = 1 - mu;
    mum13 = mum1 * mum1 * mum1;
    mu3 = mu * mu * mu;

    float xn = (float) ( mum13*x1 + 3*mu*mum1*mum1*x2 + 3*mu*mu*mum1*x3 + mu3*x4 );
    float yn = (float) ( mum13*y1 + 3*mu*mum1*mum1*y2 + 3*mu*mu*mum1*y3 + mu3*y4 );

    float dashnum = bl/dashlength;
    float dx = x1;
    float dy = y1;
    float t = 0;
    strokeWeight(1);
    for (int i=0; i < dashnum*2; i++) {
      t += 0.001;
      float[] p = findPositionOnBezier(x1, y1, x2, y2, x3, y3, x4, y4, t);
      while ( t < 1 && dist (dx, dy, p[0], p[1]) < dashlength) {
        t += 0.001;
        p = findPositionOnBezier(x1, y1, x2, y2, x3, y3, x4, y4, t);
      }
      if (t >= 1) { 
        p[0] = x4; 
        p[1] = y4;
      }
      if (i*0.5 == Math.round(i*0.5)) {

        line(dx, dy, p[0], p[1]);
      }
      dx = p[0];
      dy = p[1];
      if (t == 1) { 
        break;
      }
    }
  }
  private float[] findPositionOnBezier(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4, float t) {
    float [] out = new float[] {
      0, 0
    };
    double mu, mum1, mum13, mu3;
    mu = t;
    mum1 = 1 - mu;
    mum13 = mum1 * mum1 * mum1;
    mu3 = mu * mu * mu;
    out[0] = (float) ( mum13*x1 + 3*mu*mum1*mum1*x2 + 3*mu*mu*mum1*x3 + mu3*x4 );
    out[1] = (float) ( mum13*y1 + 3*mu*mum1*mum1*y2 + 3*mu*mu*mum1*y3 + mu3*y4 );
    return out;
  }

  private float blength(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
    float out = 0;
    float t = 0;
    float px = x1;
    float py = y1;

    for (int i=0; i<100; i++) {
      t+=(0.01);
      float[] p = findPositionOnBezier(x1, y1, x2, y2, x3, y3, x4, y4, t);
      out+=dist(px, py, p[0], p[1]);
      px = p[0];
      py = p[1];
    }
    return out;
  }
}

public class VLine extends Line {
  VLine(Person a, Person b) {
    super(a, b);
  }
  public void display() {
    stroke(a.getColor());
    strokeWeight(1);
    noFill();
    float offset = abs(a.getX() - b.getX())/2;
    //line(a.getX(), a.getY(), b.getX(), b.getY());
    cx1 = (a.getX() < b.getX()) ? a.getX()+offset : a.getX()-offset;
    cy1 = a.getY();
    cx2 = (a.getX() < b.getX()) ? b.getX()-offset : b.getX()+offset;
    cy2 = b.getY();

    if (a.getX() == b.getX()) {
      cx1 = a.getX() - 100;
      cx2 = b.getX() - 100;
    }
    //line(a.getX(), a.getY(), b.getX(), b.getY());
    bezier(a.getX(), a.getY()+10, cx1, cy1+10, cx2, cy2+10, b.getX(), b.getY()+10);
  }
}

