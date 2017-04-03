

class Enemy { 
  int speed;
  float x;
  float y;
  float w;
  float h;
  int type;
  int spr;
  float xv;
   
  // initialize object to empty, type 0 meaning not active
  Enemy() {
    type = 0;
    x = 0;
    y = 0;
    w = 0;
    h = 0;
    speed = 0;
    spr = 0;
    xv = 0;
  }
  
  // fill this to check for player vs enemy/fuel depot collision
  void checkTouch() {
    switch(type)
    {
    case 4: // fuel depot
      break;
    default: // rest
      break;
    }
  }

  // set spawn params for an enemy
  void setSpawnParms(int choice) {
    if(choice == 0) { // tanker
      x = random(100,int(VID_WIDTH-100));
      y = -SPRITE_SIZE;
      w = SPRITE_SIZE*2;
      h = SPRITE_SIZE;
      speed = 0;
      spr = 16*3 + 8;
      type = 1; 
      xv = 0; //floor(random(0,2))*8 - 4;
    }
    else if(choice == 1) { // jet
      x = random(100,int(VID_WIDTH-100));
      y = -SPRITE_SIZE;
      w = SPRITE_SIZE;
      h = SPRITE_SIZE;
      speed = 4;
      spr = 16*4 + 8;
      type = 2;
    }
    else if(choice == 2) { // helicopter
      x = random(100,int(VID_WIDTH-100));
      y = -SPRITE_SIZE;
      w = SPRITE_SIZE;
      h = SPRITE_SIZE;
      speed = -1;
      spr = 16*2 + 8;
      type = 3;
      xv = 0;
    }
    else { // fuel depot
      x = random(100,int(VID_WIDTH-100));
      y = -SPRITE_SIZE;
      w = SPRITE_SIZE * 1.5;
      h = SPRITE_SIZE * 1.5;
      speed = 0;
      spr = 16*5 + 8;
      type = 4;
    }  
  }
  
  // use this to 'remove' an enemy
  void free() {
    type = 0;
    x = 0;
    y = 0;
    w = 0;
    h = 0;
    speed = 0;
    spr = 0;
    xv = 0;
    active_enemies--;
  }

  void displayTanker() {
    x += xv; 
    if(x <= (0+SPRITE_SIZE+50)){
      xv = 4;
    }
    else if(x>=(VID_WIDTH+SPRITE_SIZE-200)){
      xv = -4;
    }
    
    drawQuad(x - SPRITE_SIZE, y - HALF_SPRITE, spr);
    drawQuad(x, y - HALF_SPRITE, spr+1);    
  }
  
  void displayHelicopter() {
    x += round(xv);
    if(player[0]<x && xv > -4){
      xv -= 0.4;
    }
    else if(player[0]>x && xv < 4){
      xv += 0.4;
    }
    
    drawQuad(x - HALF_SPRITE, y - HALF_SPRITE, spr);
    spr++;
    if(spr > 16*2+11)
      spr = 16*2+8;
  }
  
  void displayJet() {
    drawQuad(x - HALF_SPRITE, y - HALF_SPRITE, spr);
  }
  
  void displayFuelDepot() {
    drawQuad(x - HALF_SPRITE, y - HALF_SPRITE, spr); 
  }
  
  void display(){
    y += floor(scroll_speed) + speed;
    checkTouch();
    switch(type) {
    case 1:
     displayTanker();
     break;
    case 2:
      displayJet();
      break;
    case 3:
      displayHelicopter();
      break;
    case 4:
      displayFuelDepot();
      break;
    }
    
    if(y > VID_HEIGHT+SPRITE_SIZE)
      free();
  }
}

// Rewrote some code so that it's cleaner and more efficient.
// The main thing is to use an array for all enemies so that you
// never have to dynamically allocate memory for them ever again
// which gets rid of adding burden to the garbage collector.

public static final int MAX_ENEMIES = 64;
public Enemy[] enemies = new Enemy[MAX_ENEMIES];
public int active_enemies = 0;

void initEnemies() {
  for(int i = 0; i < MAX_ENEMIES; i++)
    enemies[i] = new Enemy();
}

int spawnEnemy(int type) {
  for(int i = 0; i < MAX_ENEMIES; i++) {
    if(enemies[i].type == 0) {
      enemies[i].setSpawnParms(type);
      active_enemies++;
      return i;
    }
  }
  println("WTF OUT OF ENEMIES");
  return 0;
}

void updateEnemies() {
  for(int i = 0; i < MAX_ENEMIES; i++) {
    if(enemies[i].type > 0)
      enemies[i].display();
  }
}