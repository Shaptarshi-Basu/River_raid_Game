public enum BulletType { 
  FREE, PLAYER, SMALL, BIG 
}

class Bullet {
  float x;
  float y;
  float vx;
  float vy;
  int spr;
  BulletType type;
  
  Bullet() {
    x = y = vx = vy = 0;
    spr = 8 + 16;
    type = BulletType.FREE;
  }
  
  void free() {
    type = BulletType.FREE;
  }
  
  void checkTouch() {
    if(checkBgCollision(x, y) > 0) {
      spawnFx(x, y-24, random(-2, 2), random(-2, 2), fxtype.EXP2);
      free();
    }
    if(type == BulletType.PLAYER) {
      for(int i = 0; i < MAX_ENEMIES; i++) {
        if(enemies[i].type > 0 &&enemies[i].type!=4 ) {
          if(checkCollision(x , y, 8, 16, enemies[i].x, enemies[i].y, enemies[i].w, enemies[i].h) > 0){
            enemies[i].damage(1);
            spawnFx(x, y-24, random(-4, 4), random(-4, 4), fxtype.EXP2);
            free();
          }
        }
      }
    }
    else if(type == BulletType.SMALL) {
      if(checkCollision(player[0], player[1], 8, 8, x, y, 8, 8) > 0) {
        killPlayer();
        free();
      }
    }
  }
  
  void update() {
    if(type == BulletType.FREE)
      return;
    checkTouch();
    x += vx;
    y += vy;
    if(x > VID_WIDTH + 16 || x < -16 || y > VID_HEIGHT + 16 || y < -16) {
      free();
      return;
    }
    drawQuad(x - HALF_SPRITE, y - HALF_SPRITE, spr);
  }
}


public static final int MAX_BULLETS = 256;
public Bullet[] bullets = new Bullet[MAX_BULLETS];

void initBullets() {
  for(int i = 0; i < MAX_BULLETS; i++)
    bullets[i] = new Bullet();
}

int spawnBullet(float x, float y, float vx, float vy, int spr, BulletType type) {
  for(int i = 0; i < MAX_BULLETS; i++) {
    if(bullets[i].type == BulletType.FREE) {
      bullets[i].x = x;
      bullets[i].y = y;
      bullets[i].vx = vx;
      bullets[i].vy = vy;
      bullets[i].spr = spr;
      bullets[i].type = type;
      return i;
    }
  }
  println("WTF OUT OF BULLETS");
  return 0;
}

void updateBullets() {
  for(int i = 0; i < MAX_BULLETS; i++) {
    bullets[i].update();
  }
}

void resetBullets() {
  for(int i=0; i < MAX_BULLETS; i++) {
    bullets[i].free();
  }
}