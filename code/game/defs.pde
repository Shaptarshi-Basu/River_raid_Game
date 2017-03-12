// File for a bunch of ugly globals and defines
// the various stuff could be inside some singletons but there's no real benefit to it here

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

public static final int BG_WIDTH = 15;
public static final int BG_HEIGHT = 20;
public static final int VID_WIDTH = 480;
public static final int VID_HEIGHT = 640;
public static final int SPRITE_SIZE = 32;
public static final float PIXEL_SIZE = 1.0/VID_WIDTH;
public static final float SPRITE_SIZE_F = 32.0/VID_WIDTH;
public static final int SPRITESHEET_SIZE = 32;
public int[] background = new int[BG_WIDTH * (BG_HEIGHT * 2)];
public int scroll;


float[] player = { 240, 320 };
float[] move = {0, 0, 0, 0};
boolean shooting = false;
int fireframe = 0;