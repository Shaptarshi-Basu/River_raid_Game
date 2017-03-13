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
    spr = 16 + 32;
    type = BulletType.FREE;
  }
  
  void update() {
    if(type == BulletType.FREE)
      return;
      
    x += vx;
    y += vy;
    if(x > VID_WIDTH + 16 || x < -16 || y > VID_HEIGHT + 16 || y < -16) {
      type = BulletType.FREE;
      return;
    }
    drawQuad(x - 16, y - 16, spr);
  }
}

public static final int MAX_BULLETS = 256;
public Bullet[] bullets = new Bullet[MAX_BULLETS];
void initBullets() {
  println("init boolets");
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
  for(int i = 1; i < MAX_BULLETS; i++) {
    bullets[i].update();
  }
}