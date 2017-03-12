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
  font = loadFont("Monospaced.bold-16.vlw");
  textFont(font, 16);
  playername = "";
  enemyList.add(0,new Enemy(1));
  initBackground();
  initBullets();
  initFuel();
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
    text("Fuel: " + fuelAmount(), 400, 40);
    textSize(16);
    fill(10, 15, 20);
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
  updateFuel();
    
  endShape();
  Enemy e=enemyList.get(0);
  e.enemyY+=e.speed;
  if(e.enemyY>height){
  enemyList.add(0,new Enemy((int) (new Random().nextInt(3) + 1)));
  }
  e.display(e);
  
  drawGui();
}