float throttle;

void drawPlayer() {
  
  if (move[0] > 0){ // if up key pressed throttle up
    //speed = 10;
    throttle += 0.1;
    if(throttle > 10)
      throttle = 10;
  }
  else if (move[1] > 0){ // if down key pressed slow down
    throttle -= 0.1;
    if(throttle < 2)
      throttle = 2;
  }
  
  scroll_speed = floor(throttle);
  
  float speed = 5;
  player[0] -= move[2] * speed; //left
  player[0] += move[3] * speed; //right
  //player[1] -= move[0] * speed; //up
  //player[1] += move[1] * speed; //down
  
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
   
  drawQuad(player[0] - HALF_SPRITE, player[1] - HALF_SPRITE, 8);
}