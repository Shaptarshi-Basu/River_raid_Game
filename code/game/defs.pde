// File for a bunch of ugly globals and defines
// the various stuff could be inside some singletons but there's no real benefit to it here

PImage sprite_texture;
PImage sprite_alpha;
PFont font;
String playername;
public static final String[] thestory = {
  "WHATA FUCK MAN xD", 
  "i just fall of my chair",
  "kuz i couldnt and i CANT stop", 
  "laugh xDXDXDXDXDDDDDDDDDDDD", 
  "CONGRATS MAN XD",
  "",
  "WORK IN PROGRESS",
  "",
  "PLENTY OF SPACE",
  "FOR A PROPER STORY",
  "!!!!!"
};

public static final int thestory_lines = 11;

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