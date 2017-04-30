// File for a bunch of ugly globals and defines
// the various stuff could be inside some singletons but there's no real benefit to it here
import java.util.*;
PImage sprite_texture;
PImage sprite_alpha;
PFont font;
String playername;
public static final String[] thestory = {
  "It’s the year 2000 at Hervanta", 
  "in a parallel universe.",
  "The newly constructed canal", 
  "of Suoli between lake Suoli", 
  "and lake Näsi has fallen",
  "into hostile hands.",
  "Your mission is to take control",
  "of the important canal",
  "with your own built fighter jet",
  "TIE-Fighter 69.",
  "Beware of the floating beer",
  "drinkers and Putin jets and",
  "remember to fill up the fuel",
  "tanks by flying over the tankers",
  "before your fuel runs out.",
  "Destroy everything in your sight",
  "and take back what is rightfully yours!"
};

public static final int thestory_lines = 17;

public int fade;
public int fadetarget;
public int stage_message_time;