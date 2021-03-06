

class Enemy { 
  int speed;
  float x;
  float y;
  float w;
  float h;
  int type;
  int spr;
  float xv;
  int hp;
  int points;
  int think;
   
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
    hp = 0;
    points = 0;
  }
  
  void kill() {
    for(int i = 0; i < 3; i++) {
      spawnFx(x, y, random(-4, 4), random(-4, 4), fxtype.EXP1);
      spawnFx(x, y, random(-15, 15), random(-15, 15), fxtype.EXP2);
    }
    if(type == 1) { // ship needs more splosions
      spawnFx(x - 32, y, random(-4, 4), random(-4, 4), fxtype.EXP1);
      spawnFx(x + 32, y, random(-4, 4), random(-4, 4), fxtype.EXP1);
    }
    if(type == 5) { // bridge needs more splosions and stage ++
      stage++;
      stage_patterns = 0;
      showStageMessage();
      for(int j = 0; j < 8; j++) {
        spawnFx(x - 128 + 32*j, y - 16, random(-2, 2), random(-2, 2), fxtype.EXP1);
        spawnFx(x - 128 + 32*j, y + 16, random(-2, 2), random(-2, 2), fxtype.EXP1);
      }
    }
    enemiesDestroyed(points);
    free();
  }
  
  void damage(int amount) {
    hp -= amount;
    if(hp <= 0)
      kill();
  }
  
  // fill this to check for player vs enemy/fuel depot collision
  void checkTouch() {
    switch(type)
    {
    case 4: // fuel depot
      if (checkCollision(player[0], player[1], 24, 24, x, y, w, h) > 0){
        refuel();
        // customer requirement requires it to stay
        //this.free();
      }
      break;
    case 5: // bridge
      if (checkCollision(player[0], player[1], 0, 0, x, y, w, h) > 0) {
        killPlayer();
      }
      break;
    default: // rest
      if (checkCollision(player[0], player[1], 0, 0, x, y, w, h) > 0){
        killPlayer();
        kill();
      }
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
      hp = 5;
      points = 500;
      float maxspeed = stage*0.5 + 1;
      if(maxspeed > 9)
        maxspeed = 9;
      xv = floor(random(0,2))*maxspeed*2 - maxspeed;
    }
    else if(choice == 1) { // jet
      x = random(100,int(VID_WIDTH-100));
      y = -SPRITE_SIZE;
      w = SPRITE_SIZE;
      h = SPRITE_SIZE;
      speed = 4;
      spr = 16*4 + 8;
      type = 2;
      hp = 3;
      points = 250;
      think = 10;
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
      hp = 3;
      points = 125;
    }
    else if(choice == 3) { // fuel depot
      y = -SPRITE_SIZE;
      do {
        x = random(100,int(VID_WIDTH-100));
      } while(checkBgCollision(x, y) > 0);
      w = SPRITE_SIZE * 1.5;
      h = SPRITE_SIZE * 1.5;
      speed = 0;
      spr = 16*5 + 8;
      type = 4;
    } else { // bridge
      x = 240;
      y = -SPRITE_SIZE * 3;
      w = 256;
      h = 128;
      speed = 0;
      spr = 0;
      type = 5;
      hp = 12;
      points = 1000;
    }
  }
  
  // use this to 'remove' an enemy
  void free() {
    if(type == 0)
      return;
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
    
    float maxspeed = stage*0.5 + 1;
    if(maxspeed > 9)
      maxspeed = 9;
    
    if(checkBgCollision(x - w*0.5, y) > 0) {
      xv = maxspeed;
    }
    else if(checkBgCollision(x + w*0.5, y) > 0){
      xv = -maxspeed;
    }
    
    drawQuad(x - SPRITE_SIZE, y - HALF_SPRITE, spr);
    drawQuad(x, y - HALF_SPRITE, spr+1);    
  }
  
  void displayHelicopter() {
    x += round(xv);
    float maxspeed = stage + 1;
    if(maxspeed > 9)
      maxspeed = 9;
    if(player[0]<x && xv > -maxspeed){
      xv -= maxspeed * 0.1;
    }
    else if(player[0]>x && xv < maxspeed){
      xv += maxspeed * 0.1;
    }
    
    drawQuad(x - HALF_SPRITE, y - HALF_SPRITE, spr);
    spr++;
    if(spr > 16*2+11)
      spr = 16*2+8;
    
    think--;
    if(think < 0) {
      spawnBullet(x, y, 0, 8, 16*6 + 8, BulletType.SMALL);
      think = 25;
    }
  }
  
  void displayJet() {
    drawQuad(x - HALF_SPRITE, y - HALF_SPRITE, spr);
    think--;
    if(think < 0) {
      float tvx = player[0] - x;
      float tvy = player[1] - y;
      float normx = tvx / sqrt(tvx*tvx + tvy*tvy);
      float normy = tvy / sqrt(tvx*tvx + tvy*tvy);
      spawnBullet(x, y, normx*4, normy*4, 16*6 + 8, BulletType.SMALL);
      think = 20;
    }
  }
  
  void displayFuelDepot() {
    drawQuad(x - HALF_SPRITE, y - HALF_SPRITE, spr); 
  }
  
  void displayBridge() {
    drawQuad(x - 128, y - SPRITE_SIZE, 256, 128, 0, 192);
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
    case 5:
      displayBridge();
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

int spawn_delay;

void updateEnemies() {
  
  if(spawn_delay < 0)
  {
    if(fuelAmount() < 90)
      spawnEnemy(3);
    else
      spawnEnemy(floor(random(4)));
    spawn_delay = SPRITE_SIZE*12 - (SPRITE_SIZE*stage);
    if(spawn_delay < SPRITE_SIZE * 2)
      spawn_delay = SPRITE_SIZE * 2;
  }
  spawn_delay -= scroll_speed;
  
  for(int i = 0; i < MAX_ENEMIES; i++) {
    if(enemies[i].type > 0)
      enemies[i].display();
  }
  
}

void resetEnemies() {
  for(int i=0; i < MAX_ENEMIES; i++) {
    enemies[i].free();
  }
  spawn_delay = SPRITE_SIZE * 8;
}