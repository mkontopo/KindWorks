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

