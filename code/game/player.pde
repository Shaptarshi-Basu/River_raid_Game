void drawPlayer() {
  
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
      spawnBullet(player[0] + 5, player[1] - 16, 0, -14, 16+32, BulletType.PLAYER);
    drawQuad(player[0] - 11, player[1] - 30, (16 + 32) + fireframe);
  } else if(fireframe > 4 && fireframe <= 8) {
    if(fireframe == 5)
      spawnBullet(player[0] - 5, player[1] - 16, 0, -14, 16+32, BulletType.PLAYER);
    drawQuad(player[0] - 21, player[1] - 30, (16 + 32) + fireframe - 4);
  }
   
  drawQuad(player[0] - 16, player[1] - 16, 16);

  float speed = 5;
  player[0] -= move[2] * speed; //left
  player[0] += move[3] * speed; //right
  //player[1] -= move[0] * speed; //up
  //player[1] += move[1] * speed; //down
}