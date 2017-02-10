import processing.opengl.*;

PImage sprite_texture;
PImage sprite_alpha;

public static final int BG_WIDTH = 15;
public static final int BG_HEIGHT = 20;
public static final int VID_WIDTH = 480;
public static final int VID_HEIGHT = 640;
public static final int SPRITE_SIZE = 32;
public static final float PIXEL_SIZE = 1.0/VID_WIDTH;
public static final int SPRITESHEET_SIZE = 32;
public int[] background = new int[BG_WIDTH * (BG_HEIGHT * 2)];
public int scroll;

void setup() {
  sprite_texture = loadImage("spritesheet.png");
  sprite_alpha = createImage(sprite_texture.width, sprite_texture.height, ALPHA);
  for(int i = 0; i < sprite_texture.pixels.length; i++) {
    sprite_alpha.pixels[i] = (sprite_texture.pixels[i] >> 24) & 0xFF;
  }
  sprite_texture.mask(sprite_alpha);
  noSmooth();
  
  for(int j = 0; j < BG_HEIGHT*2; j++) {
    for(int i = 0; i < BG_WIDTH; i++) {
      background[j*BG_WIDTH + i] = 96;
    }
  }
  background[0] = 1;
  background[BG_HEIGHT*BG_WIDTH + 1] = 2;
}

void settings() {
  size(VID_WIDTH, VID_HEIGHT, P3D);
  //((PGraphicsOpenGL)g).textureSampling(2);
}

float[] player = { 0.5, 0.5 };
float[] move = {0, 0, 0, 0};

void keyPressed() {
  print("pressed " + str(keyCode) + "\n");
  if (key == CODED) {
    if (keyCode == UP) {
      move[0] = 1;
    }
    if (keyCode == DOWN) {
      move[1] = 1;
    }
    if (keyCode == LEFT) {
      move[2] = 1;
    }
    if (keyCode == RIGHT) {
      move[3] = 1;
    }
  }
}

void keyReleased() {
  print("released " + str(keyCode) + "\n");
  if (key == CODED) {
    if (keyCode == UP) {
      move[0] = 0;
    }
    if (keyCode == DOWN) {
      move[1] = 0;
    }
    if (keyCode == LEFT) {
      move[2] = 0;
    }
    if (keyCode == RIGHT) {
      move[3] = 0;
    }
  }
}

//FIXME: move draw helpers elsewhere, maybe inside another class
void drawQuad(float x, float y, float xs, float ys, float u, float v) {
  float x_screen = floor(x*VID_WIDTH);
  float y_screen = floor(y*VID_WIDTH);
  vertex(x_screen, y_screen, u, v);
  vertex(x_screen + xs, y_screen, u + xs, v);
  vertex(x_screen + xs, y_screen + ys, u + xs, v + ys);
  vertex(x_screen, y_screen + ys, u, v + ys);
}

void drawQuad(float x, float y, float u, float v) {
  float x_screen = floor(x*VID_WIDTH);
  float y_screen = floor(y*VID_WIDTH);
  vertex(x_screen, y_screen, u, v);
  vertex(x_screen + SPRITE_SIZE, y_screen, u + SPRITE_SIZE, v);
  vertex(x_screen + SPRITE_SIZE, y_screen + SPRITE_SIZE, u + SPRITE_SIZE, v + SPRITE_SIZE);
  vertex(x_screen, y_screen + SPRITE_SIZE, u, v + SPRITE_SIZE);
}

void drawQuad(float x, float y, int frame) {
  float v = floor(frame / 32);
  float u = frame - (v * 32);
  float x_screen = floor(x*VID_WIDTH);
  float y_screen = floor(y*VID_WIDTH);
  vertex(x_screen, y_screen, (u*32), (v*32));
  vertex(x_screen + SPRITE_SIZE, y_screen, (u*32) + SPRITE_SIZE, (v*32));
  vertex(x_screen + SPRITE_SIZE, y_screen + SPRITE_SIZE, (u*32) + SPRITE_SIZE, (v*32) + SPRITE_SIZE);
  vertex(x_screen, y_screen + SPRITE_SIZE, (u*32), (v*32) + SPRITE_SIZE);
}

// FIXME: move background stuff to a separate file
void drawBackground() { 
  int startpos = floor((scroll)/32);
  if(startpos >= BG_HEIGHT*2)
  {
    startpos -= BG_HEIGHT*2;
    scroll -= BG_HEIGHT*2*SPRITE_SIZE;
  }

  //print(startpos);
  int pixeloffset = scroll - floor(scroll/32)*32;
  
  float v;
  float u;
  int framenum, frame;
  int wrap = 1;
  
  for(int i = 0; i <= BG_HEIGHT; i++) {
    if(startpos+(20-i) < BG_HEIGHT*2)
      wrap = 0;
    //else
    //  wrap = 0;
    for(int j = 0; j < BG_WIDTH; j++) {
      framenum = (startpos+(20-i))*BG_WIDTH + j - (600*wrap);
      /*if(framenum < 0  || framenum >= 600)
      {
        frame = 0;
      }
      else*/
        frame = background[framenum];
      v = floor(frame / 32);
      u = frame - (v*32);
      vertex(j*SPRITE_SIZE, (i-1)*SPRITE_SIZE + pixeloffset, (u*32), (v*32));
      vertex(j*SPRITE_SIZE + SPRITE_SIZE, (i-1)*SPRITE_SIZE + pixeloffset, (u*32) + SPRITE_SIZE, (v*32));
      vertex(j*SPRITE_SIZE + SPRITE_SIZE, (i-1)*SPRITE_SIZE + SPRITE_SIZE + pixeloffset, (u*32) + SPRITE_SIZE, (v*32) + SPRITE_SIZE);
      vertex(j*SPRITE_SIZE, (i-1)*SPRITE_SIZE + SPRITE_SIZE + pixeloffset, (u*32), (v*32) + SPRITE_SIZE);
    }
  }
}

//FIXME: Move elsewhere
void drawSprites() {
}

//FIXME: Move elsewhere
void drawGui() {
  // Draw UI elements here
  // maybe a 'switch' for different menus
  // case MENU_ASKNAME:, case MENU_MAINMENU: etc
  // use drawQuad stuff to draw the bitmap graphics (windows, buttons, text boxes)
  // use processing's text rendering shit to draw text
}

void draw() {
  //println(str(move[0]) + " " + str(move[1]) + " " + str(move[2]) + " " + str(move[3]));
  //tint(0, 0, 0, 255);
  //rect(0, 0, 480, 640);
  int x, y, u, v;
  beginShape(QUADS);
  //blendMode(BLEND);
  hint(DISABLE_TEXTURE_MIPMAPS);
  ((PGraphicsOpenGL)g).textureSampling(2);
  texture(sprite_texture);
  textureMode(IMAGE);
  noStroke();

  scroll += 4;
  drawBackground();
  drawSprites();

  float speed = 0.01;
  player[0] -= move[2] * speed;
  player[0] += move[3] * speed;
  player[1] -= move[0] * speed;
  player[1] += move[1] * speed;

  drawQuad(player[0] - PIXEL_SIZE*16, player[1] - PIXEL_SIZE*16, 3);
  
  drawGui();

  endShape();
}