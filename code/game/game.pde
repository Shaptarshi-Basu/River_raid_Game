import processing.opengl.*;

public enum Menu {
  ASKNAME, INTRO, MAIN, GAME
}
public Menu current_menu;
public int current_menu_max;
public int current_menu_selection;
public float[] current_menu_bboxes; //mouse input

void useMenu(int sel) {
  switch(current_menu) {
  case ASKNAME:
    setMenu(Menu.INTRO);
    break;
  case INTRO:
    setMenu(Menu.MAIN);
    break;
  case MAIN:
    if(sel == 0)
      setMenu(Menu.GAME);
    break;
  case GAME:
    break;
  }
}

void setMenu(Menu menu) {
  current_menu = menu;
  switch(menu) {
  case ASKNAME:
    current_menu_max = 0;
    current_menu_selection = 0;
    break;
  case INTRO:
    current_menu_max = 0;
    current_menu_selection = 0;
    break;
  case MAIN:
    current_menu_max = 3;
    current_menu_selection = 0;
    break;
  case GAME:
    current_menu_max = 0;
    current_menu_selection = 0;
    break;
  }
}

void setup() {
  sprite_texture = loadImage("spritesheet.png");  
  noSmooth();

  current_menu = Menu.ASKNAME;
  
  for(int j = 0; j < BG_HEIGHT*2; j++) {
    for(int i = 0; i < BG_WIDTH; i++) {
      background[j*BG_WIDTH + i] = 96;
    }
  }
  background[0] = 1;
  background[BG_HEIGHT*BG_WIDTH + 1] = 2;
  font = loadFont("Monospaced.bold-16.vlw");
  textFont(font, 16);
  playername = "";
  initBullets();
}

void settings() {
  size(VID_WIDTH, VID_HEIGHT, P3D);
}

void keyTyped() {
  switch(current_menu) {
  case ASKNAME:
    if(playername.length() < 20)
      playername += key;
    break;
  default:
    break;
  }
}

void keyPressed() {
  if(current_menu == Menu.GAME)
  {
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
    } else if(key == 'z' || key == 'Z') {
      shooting = true;
    }
  }
  else
  {
    switch(keyCode) {
    case BACKSPACE:
      if(current_menu == Menu.ASKNAME && playername.length() > 0)
        playername = playername.substring(0, playername.length() - 1);
    case ENTER:
      useMenu(current_menu_selection);
      break;
    case UP:
      current_menu_selection -= 1;
      if(current_menu_selection < 0)
        current_menu_selection = current_menu_max;
      break;
    case DOWN:
      current_menu_selection += 1;
      if(current_menu_selection > current_menu_max)
        current_menu_selection = 0;
      break;
    default:
      break;
    }
  }
}

void keyReleased() {
  switch(current_menu) {
  default:
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
    } else if(key == 'z' || key == 'Z') {
      shooting = false;
    }
    break;
  }
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


void drawPlayer() {
  
  if(fireframe > 0) {
    if(fireframe > 7) {
      fireframe = 0;
    } else {
      fireframe++;
    }
  }
  if(shooting && fireframe == 0) {
    fireframe = 1;
  }
  
  if(fireframe > 0 && fireframe <= 4) {
    if(fireframe == 1)
      spawnBullet(player[0] + 5, player[1] - 16, 0, -14, 16+32, BulletType.PLAYER);
    drawQuad(player[0] - 11, player[1] - 30, (16 + 32) + fireframe);
  } else if(fireframe > 4 && fireframe <= 8) {
    if(fireframe == 5)
      spawnBullet(player[0] - 5, player[1] - 16, 0, -14, 16+32, BulletType.PLAYER);
    drawQuad(player[0] - 21, player[1] - 30, (16 + 32) + fireframe - 4);
  }
   
  drawQuad(player[0] - 16, player[1] - 16, 16);
}

//FIXME: Move elsewhere
void drawSprites() {
  updateBullets();
  drawPlayer();
}

//FIXME: Move elsewhere
void drawGui() {
  // Draw UI elements here
  // maybe a 'switch' for different menus
  // case MENU_ASKNAME:, case MENU_MAINMENU: etc
  // use drawQuad stuff to draw the bitmap graphics (windows, buttons, text boxes)
  // use processing's text rendering shit to draw text
  switch(current_menu) {
  case ASKNAME:
    // draw bitmap graphics first, no text until endShape(); 
    beginShape(QUADS);
    texture(sprite_texture);
    drawWindow(VID_WIDTH/2 - SPRITE_SIZE * 4, VID_HEIGHT/2 - SPRITE_SIZE * 2, 8, 4);
    drawShortWindow(VID_WIDTH/2 - SPRITE_SIZE * 3.5, VID_HEIGHT/2, 7);
    endShape();
    // now draw all the texts
    textAlign(CENTER, CENTER);
    textSize(16);
    fill(10, 15, 20);
    text("ENTER YOUR NAME", VID_WIDTH / 2, VID_HEIGHT / 2 - 32);
    text(playername + "|", VID_WIDTH/2, VID_HEIGHT/2 + 16);
    
    break;
  case INTRO:
    beginShape(QUADS);
    texture(sprite_texture);
    drawWindow(VID_WIDTH/2 - SPRITE_SIZE * 6, VID_HEIGHT/2 - SPRITE_SIZE * 8, 12, 16);
    endShape();
    textAlign(CENTER, CENTER);
    textSize(16);
    fill(10, 15, 20);
    text("STORY SO FAR...", VID_WIDTH / 2, VID_HEIGHT/2 - SPRITE_SIZE * 7);
    for(int i = 0; i < thestory_lines; i++)
      text(thestory[i], VID_WIDTH / 2, VID_HEIGHT/2 - SPRITE_SIZE * 5 + 24 * i);
    
    break;
  case MAIN:
    beginShape(QUADS);
    texture(sprite_texture);
    drawWindow(VID_WIDTH/2 - SPRITE_SIZE * 5, VID_HEIGHT/2 - SPRITE_SIZE * 5, 10, 10);
    endShape();
    textAlign(CENTER, CENTER);
    textSize(16);
    fill(10, 15, 20);
    text("MAIN MENU", VID_WIDTH/2, VID_HEIGHT/2 - SPRITE_SIZE * 4);
    
    text("NEW GAME", VID_WIDTH/2, VID_HEIGHT/2 - SPRITE_SIZE * 2);
    text("HIGH SCORES", VID_WIDTH/2, VID_HEIGHT/2 - SPRITE_SIZE * 2 + 24);
    text("QUIT", VID_WIDTH/2, VID_HEIGHT/2 - SPRITE_SIZE * 2 + 24*4);
    
    text("MADE BY", VID_WIDTH/2, VID_HEIGHT/2 + SPRITE_SIZE * 3);
    text("G21 PPKOSKI", VID_WIDTH/2, VID_HEIGHT/2 + SPRITE_SIZE * 3 + 24);
    break;
  case GAME:
    break;
  default:
    text("UNKNOWN MENU SET", VID_WIDTH / 2, VID_HEIGHT / 2);
    break;
  }
}

void draw() {
  beginShape(QUADS);
  texture(sprite_texture);
  textureMode(IMAGE);
  noStroke();
  
  if (move[0] > 0){ // if up key pressed throttle up
    //speed = 10;
    scroll += 7;
  }
  else if (move[1] > 0){ // if down key pressed slow down
    scroll += 3;
  }
  else scroll += 5; // otherwise scroll as normal
  
  drawBackground();
  drawSprites();

  float speed = 5;
  player[0] -= move[2] * speed; //left
  player[0] += move[3] * speed; //right
  //player[1] -= move[0] * speed; //up
  //player[1] += move[1] * speed; //down
  
    
  endShape();
  
  drawGui();
}