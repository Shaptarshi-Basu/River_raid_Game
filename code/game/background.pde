
public static final int BG_WIDTH = 15;
public static final int BG_HEIGHT = 20;

public int[] background = new int[BG_WIDTH * (BG_HEIGHT * 2)];
public int scroll;

int[] pattern = { 
  550, 551, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 517, 579, 550, 
  550, 551, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 549, 550, 550,
  550, 551, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 581, 576, 550,
  550, 578, 519, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 549, 550,
  550, 577, 583, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 549, 550,
  550, 551, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 549, 550
};

int[] pat_straight = {
  550, 551, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 549, 550,
  550, 551, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 549, 550,
  550, 551, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 549, 550,
  550, 551, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 549, 550,
  550, 551, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 549, 550,
  550, 551, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 549, 550,
  550, 551, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 549, 550,
  550, 551, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 549, 550
};

int[] pat_island = {
  550, 551, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 549, 550,
  550, 551, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 549, 550,
  550, 551, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 549, 550,
  550, 551, 528, 528, 528, 528, 517, 518, 519, 528, 528, 528, 528, 549, 550,
  550, 551, 528, 528, 528, 528, 549, 550, 551, 528, 528, 528, 528, 549, 550,
  550, 551, 528, 528, 528, 528, 581, 582, 583, 528, 528, 528, 528, 549, 550,
  550, 551, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 549, 550,
  550, 551, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 549, 550
};

int[] pat_tight = {
  550, 551, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 549, 550,
  550, 578, 519, 528, 528, 528, 528, 528, 528, 528, 528, 528, 517, 579, 550,
  550, 550, 578, 519, 528, 528, 528, 528, 528, 528, 528, 517, 579, 550, 550,
  550, 550, 550, 578, 519, 528, 528, 528, 528, 528, 517, 579, 550, 550, 550,
  550, 550, 550, 577, 583, 528, 528, 528, 528, 528, 581, 576, 550, 550, 550,
  550, 550, 577, 583, 528, 528, 528, 528, 528, 528, 528, 581, 576, 550, 550,
  550, 577, 583, 528, 528, 528, 528, 528, 528, 528, 528, 528, 581, 576, 550,
  550, 551, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 549, 550,
  550, 551, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 549, 550
};

int[] pat_bridge = {
  550, 551, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 549, 550,
  550, 578, 519, 528, 528, 528, 528, 528, 528, 528, 528, 528, 517, 579, 550,
  550, 550, 578, 519, 528, 528, 528, 528, 528, 528, 528, 517, 579, 550, 550,
  550, 550, 550, 551, 528, 528, 528, 528, 528, 528, 528, 549, 550, 550, 550,
  550, 550, 550, 551, 528, 528, 528, 528, 528, 528, 528, 549, 550, 550, 550,
  550, 550, 550, 551, 528, 528, 528, 528, 528, 528, 528, 549, 550, 550, 550,
  550, 550, 577, 583, 528, 528, 528, 528, 528, 528, 528, 581, 576, 550, 550,
  550, 577, 583, 528, 528, 528, 528, 528, 528, 528, 528, 528, 581, 576, 550,
  550, 551, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 549, 550,
  550, 551, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 549, 550
};

int TILE_SIZE = 32;
float scroll_speed = 0;
public int stage = 1;
public int stage_patterns = 0;

void fillBackground(int row, int[] pat) {
  int numrows = pat.length / BG_WIDTH;
  while(row > BG_HEIGHT*2)
    row -= BG_HEIGHT*2;
  for(int i = 0; i < numrows; i++) {
    int targetrow = row + i;
    if(targetrow >= BG_HEIGHT*2)
      targetrow -= BG_HEIGHT*2;
      
    for(int j = 0; j < BG_WIDTH; j++) {
      background[targetrow*BG_WIDTH + j] = pat[(numrows-i-1)*BG_WIDTH + j];
    }
  }
}

int getTile(float x, float y) {
  if(x > VID_WIDTH)
    x = VID_WIDTH;
  if(x < 0)
    x = 0;
  if(y > VID_HEIGHT)
    y = VID_HEIGHT;
  if(y < - 240)
    y = -240;
  int ix = floor(x / HALF_SPRITE);
  int iy = floor((scroll + VID_HEIGHT - y)/32) % (BG_HEIGHT*2);
  return background[iy * BG_WIDTH + ix];
}


int nextfill;
int nextrow;

void initBackground() {  
  for(int j = 0; j < BG_HEIGHT*2; j++) {
    for(int i = 0; i < BG_WIDTH; i++) {
      background[j*BG_WIDTH + i] = 16*32 + 16;
    }
  }
  scroll = 0;
  background[BG_WIDTH * BG_HEIGHT] = 1;
  // start with 8x3=24 rows of straight pattern
  fillBackground(0, pat_straight);
  fillBackground(8, pat_straight);
  fillBackground(16, pat_straight);
  // magic numbers: start filling new patterns after scrolling 4 rows
  // this is because you see 20 at once, and we've filled 24 already
  nextfill = 4*TILE_SIZE;
  // which index row should we start filling
  nextrow = 24;
}

void drawBackground() {
  scroll += floor(scroll_speed); 
  
  int startpos = floor((scroll)/32);
  if(startpos >= BG_HEIGHT*2)
  {
    startpos -= BG_HEIGHT*2;
    scroll -= BG_HEIGHT*2*TILE_SIZE;
    nextfill -= BG_HEIGHT*2*TILE_SIZE;
  }
  
  if(scroll > nextfill) {
    int num = round(random(0, 3));
    if(stage_patterns > 6 + stage) {
      num = 4;
      if(stage_patterns > 7 + stage) {
        num = 0;
        
        // FIXME: move this to where bridge is dying
        /*if(stage_patterns > 11 + stage) {
          stage++;
          stage_patterns = 0;
          showStageMessage();
        }*/
      } else {
        spawnEnemy(4);
        spawn_delay = 12*SPRITE_SIZE;
      }
    }
    if(num == 0) {
      fillBackground(nextrow, pattern);
      nextfill = nextfill + 6*TILE_SIZE;
      nextrow = nextrow + 6;
    } else if(num == 1) {
      fillBackground(nextrow, pat_straight);
      nextfill = nextfill + 8*TILE_SIZE;
      nextrow = nextrow + 8;
    } else if(num == 2) {
      fillBackground(nextrow, pat_island);
      nextfill = nextfill + 8*TILE_SIZE;
      nextrow = nextrow + 8;
    } else if(num == 3) {
      fillBackground(nextrow, pat_tight);
      nextfill = nextfill + 9*TILE_SIZE;
      nextrow = nextrow + 9;
    } else if(num == 4) {
      fillBackground(nextrow, pat_bridge);
      nextfill = nextfill + 10*TILE_SIZE;
      nextrow = nextrow + 10;
    }
    
    stage_patterns++;
    
    if(nextrow > BG_HEIGHT * 2)
      nextrow -= BG_HEIGHT * 2;
  }

  //print(startpos);
  int pixeloffset = scroll - floor(scroll/TILE_SIZE)*TILE_SIZE;
  
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
      v = floor(frame / TILE_SIZE);
      u = frame - (v*TILE_SIZE);
      vertex(j*TILE_SIZE, (i-1)*TILE_SIZE + pixeloffset, (u*32), (v*32));
      vertex(j*TILE_SIZE + TILE_SIZE, (i-1)*TILE_SIZE + pixeloffset, (u*32) + TILE_SIZE, (v*32));
      vertex(j*TILE_SIZE + TILE_SIZE, (i-1)*TILE_SIZE + TILE_SIZE + pixeloffset, (u*32) + TILE_SIZE, (v*32) + TILE_SIZE);
      vertex(j*TILE_SIZE, (i-1)*TILE_SIZE + TILE_SIZE + pixeloffset, (u*32), (v*32) + TILE_SIZE);
    }
  }
}