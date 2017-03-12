int[] pattern = { 
  512, 512, 512, 528, 528, 528, 528, 528, 528, 528, 528, 528, 512, 512, 512, 
  512, 512, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 512, 512, 512,
  512, 512, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 512, 512, 512,
  512, 512, 512, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 512, 512,
  512, 512, 512, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 512, 512,
  512, 512, 512, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 512, 512
};

void fillBackground(int row) {
  //println(row);
  while(row > BG_HEIGHT*2)
    row -= BG_HEIGHT*2;
  for(int i = 0; i < pattern.length / BG_WIDTH; i++) {
    int targetrow = row + i;
    if(targetrow >= BG_HEIGHT*2)
      targetrow -= BG_HEIGHT*2;
      
    for(int j = 0; j < BG_WIDTH; j++) {
      background[targetrow*BG_WIDTH + j] = pattern[i*BG_WIDTH + j];
    }
  }
}


int nextfill;
int nextrow;

void initBackground() {  
  for(int j = 0; j < BG_HEIGHT*2; j++) {
    for(int i = 0; i < BG_WIDTH; i++) {
      background[j*BG_WIDTH + i] = 16*32 + 16;
    }
  }
  background[BG_WIDTH * BG_HEIGHT] = 1;
  fillBackground(20);
  nextfill = 0 + 6*SPRITE_SIZE;
  nextrow = 20 + 6;
}

void drawBackground() { 
  int startpos = floor((scroll)/32);
  if(startpos >= BG_HEIGHT*2)
  {
    startpos -= BG_HEIGHT*2;
    scroll -= BG_HEIGHT*2*SPRITE_SIZE;
    nextfill -= BG_HEIGHT*2*SPRITE_SIZE;
  }
  
  if(scroll > nextfill) {
    fillBackground(nextrow);
    nextfill = nextfill + 6*SPRITE_SIZE;
    nextrow = nextrow + 6;
    if(nextrow > BG_HEIGHT * 2)
      nextrow -= BG_HEIGHT * 2;
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