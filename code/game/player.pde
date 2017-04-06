
float[] player = { 240, 560 };
float[] move = {0, 0, 0, 0};
boolean shooting = false;
int fireframe = 0;
int deadframe = -1;
int lives = 3;

float throttle;

void killPlayer() {
  if(deadframe >= 0)
    return;
  if(lives > 0) {
    spawnFx(0 + HALF_SPRITE, 640 - SPRITE_SIZE - SPRITE_SIZE * (lives-1) + HALF_SPRITE, 0, -2, fxtype.EXP1);
    spawnFx(0 + HALF_SPRITE, 640 - SPRITE_SIZE - SPRITE_SIZE * (lives-1) + HALF_SPRITE, random(-8, 8), -2 + random(-8, 8), fxtype.EXP2);
    spawnFx(0 + HALF_SPRITE, 640 - SPRITE_SIZE - SPRITE_SIZE * (lives-1) + HALF_SPRITE, random(-8, 8), -2 + random(-8, 8), fxtype.EXP2);
    spawnFx(0 + HALF_SPRITE, 640 - SPRITE_SIZE - SPRITE_SIZE * (lives-1) + HALF_SPRITE, random(-8, 8), -2 + random(-8, 8), fxtype.EXP2);
    lives--;
  }
  if(scroll_speed > 2)
    scroll_speed = 2;
  deadframe = 0;

  for(int i = 0; i < 3; i++) {
    spawnFx(player[0], player[1], random(-4, 4), random(-4, 4), fxtype.EXP1);
    spawnFx(player[0], player[1], random(-15, 15), random(-15, 15), fxtype.EXP2);
  }
}

void drawPlayer() {
  if(deadframe < 0) {
    
    float maxthrottle = 7 + stage;
    float minthrottle = 2 + stage * 0.6;
    
    if (move[0] > 0) // if up key pressed throttle up
      throttle += 0.3;
    else if (move[1] > 0) // if down key pressed slow down
      throttle -= 0.3;
    
    if(throttle > maxthrottle)
      throttle = maxthrottle;
    else if(throttle < minthrottle)
      throttle = minthrottle;
    
    scroll_speed = floor(throttle);
    
    float speed = 5;
    player[0] -= move[2] * speed; //left
    player[0] += move[3] * speed; //right
    //player[1] -= move[0] * speed; //up
    //player[1] += move[1] * speed; //down
    
    if(checkBgCollision(player[0], player[1]) > 0)
      killPlayer();
    
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
        spawnBullet(player[0] + 8, player[1] - HALF_SPRITE - 8, 0, -20, 8+16, BulletType.PLAYER);
      drawQuad(player[0] - HALF_SPRITE + 8, player[1] - HALF_SPRITE - 24, (8 + 16) + fireframe);
    } else if(fireframe > 4 && fireframe <= 8) {
      if(fireframe == 5)
        spawnBullet(player[0] - 8, player[1] - HALF_SPRITE - 8, 0, -20, 8+16, BulletType.PLAYER);
      drawQuad(player[0] - HALF_SPRITE - 8, player[1] - HALF_SPRITE - 24, (8 + 16) + fireframe - 4);
    }
  } else { // is dead
    if(deadframe < 80) {
      if(deadframe % 8 == 0)
        spawnFx(player[0], player[1], random(-2, 2), random(-2, 2), fxtype.EXP1);
      if(deadframe % 2 == 0)
        spawnFx(player[0], player[1], random(-8, 8), random(-8, 8), fxtype.EXP2);
   
      player[1] += scroll_speed;
    }
    
    if(deadframe == 45)
      fadetarget = 0;
    if(deadframe == 96) {
      //in the middle of a black screen
      player[1] = 560;
      player[0] = 240;
      initBackground();
      resetEnemies();
      resetBullets();
      throttle = 3;
      setFuelToMax();
    }
    if(deadframe == 100) {
      fadetarget = 255;
    }
    
    deadframe++;
    
    if(deadframe > 120) {
      deadframe = -1;
      showStageMessage();
      stage_patterns = 0;
    }
  }
  
  drawQuad(player[0] - HALF_SPRITE, player[1] - HALF_SPRITE, 8);
  int tempfuel = 64-(fuelAmount()*64 / max_fuel);
  drawQuad(VID_WIDTH-64, VID_HEIGHT-64, 64, tempfuel, 256+64, 0); // Jerry can can (green)
  drawQuad(VID_WIDTH-64, VID_HEIGHT-64+tempfuel, 64, 64-tempfuel, 256, tempfuel); // Jerry can can (red)
  
  for(int l = 0; l < lives; l++)
    drawQuad(0, 640 - SPRITE_SIZE - SPRITE_SIZE * l, 8);
}