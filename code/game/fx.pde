public enum fxtype { 
  FREE, EXP1, EXP2 
};

class FXSprite {
  fxtype type;
  float x;
  float y;
  float vx;
  float vy;
  int frame;
  int nextframe;
  
  FXSprite() {
    type = fxtype.FREE;
    x = 0;
    y = 0;
    frame = 0;
    nextframe = 0;
  }
  
  void update() {
    switch(type) {
    case EXP1:
      x += vx;
      y += vy + scroll_speed;
      drawQuad(x - HALF_SPRITE, y - HALF_SPRITE, frame);
      frame++;
      if(frame > 7*16+13)
        type = fxtype.FREE;
      break;
    case EXP2:
      x += vx;
      y += vy + scroll_speed;
      drawQuadHalf(x - HALF_SPRITE*0.5, y - HALF_SPRITE*0.5, frame);
      nextframe--;
      if(nextframe < 0)
      {
        nextframe = 1;
        frame++;
        if(frame > 14*32+31)
          type = fxtype.FREE;
      }
      break;
    default:
      break;
    }
  }
}

int MAX_FX = 128;
public FXSprite[] fx = new FXSprite[MAX_FX];

void initFx() {
  for(int i = 0; i < MAX_FX; i++)
    fx[i] = new FXSprite();
}

int spawnFx(float x, float y, float vx, float vy, fxtype type) {
  for(int i = 0; i < MAX_FX; i++) {
    if(fx[i].type == fxtype.FREE) {
      fx[i].x = x;
      fx[i].y = y;
      fx[i].vx = vx;
      fx[i].vy = vy;
      fx[i].type = type;
      switch(type) {
      case EXP1: // bigger explosion
        fx[i].frame = 16*7;
        fx[i].nextframe = 0; // 60 fps
        break;
      case EXP2:
        fx[i].frame = 32*14 + 28;
        fx[i].nextframe = 1;
        break;
      default:
        fx[i].frame = 0;
        break;
      }
      return i;
    }
  }
  return 0;
}

void updateFx() {
  for(int i = 0; i < MAX_FX; i++) {
    if(fx[i].type != fxtype.FREE)
      fx[i].update();
  }
}