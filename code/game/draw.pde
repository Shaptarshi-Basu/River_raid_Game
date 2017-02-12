// draw an arbitrary sized quad
void drawQuad(float x, float y, float xs, float ys, float u, float v) {
  float x_screen = floor(x); //floor(x*VID_WIDTH);
  float y_screen = floor(y); //floor(y*VID_WIDTH);
  vertex(x_screen, y_screen, u, v);
  vertex(x_screen + xs, y_screen, u + xs, v);
  vertex(x_screen + xs, y_screen + ys, u + xs, v + ys);
  vertex(x_screen, y_screen + ys, u, v + ys);
}

// draw a SPRITE_SIZE sized quad
void drawQuad(float x, float y, float u, float v) {
  float x_screen = floor(x); //floor(x*VID_WIDTH);
  float y_screen = floor(y); //floor(y*VID_WIDTH);
  vertex(x_screen, y_screen, u, v);
  vertex(x_screen + SPRITE_SIZE, y_screen, u + SPRITE_SIZE, v);
  vertex(x_screen + SPRITE_SIZE, y_screen + SPRITE_SIZE, u + SPRITE_SIZE, v + SPRITE_SIZE);
  vertex(x_screen, y_screen + SPRITE_SIZE, u, v + SPRITE_SIZE);
}

// draw a SPRITE_SIZE sized quad with set frame instead of UV
void drawQuad(float x, float y, int frame) {
  float v = floor(frame / 32);
  float u = frame - (v * 32);
  float x_screen = floor(x); //floor(x*VID_WIDTH);
  float y_screen = floor(y); //floor(y*VID_WIDTH);
  vertex(x_screen, y_screen, (u*32), (v*32));
  vertex(x_screen + SPRITE_SIZE, y_screen, (u*32) + SPRITE_SIZE, (v*32));
  vertex(x_screen + SPRITE_SIZE, y_screen + SPRITE_SIZE, (u*32) + SPRITE_SIZE, (v*32) + SPRITE_SIZE);
  vertex(x_screen, y_screen + SPRITE_SIZE, (u*32), (v*32) + SPRITE_SIZE);
}

// draw a window meant for mostly UI
void drawWindow(float x, float y, int xs, int ys) {
  if(xs < 2 || ys < 2)
    return;
  for(int i = 0; i < xs; i++) {
    for(int j = 0; j < ys; j++) {
      if(i == 0) {
        if(j == 0)
          drawQuad(x + i*SPRITE_SIZE, y + j*SPRITE_SIZE, 0);
        else if(j == ys - 1)
          drawQuad(x + i*SPRITE_SIZE, y + j*SPRITE_SIZE, 0 + 64);
        else
          drawQuad(x + i*SPRITE_SIZE, y + j*SPRITE_SIZE, 0 + 32);
      } else if(i == xs - 1) {
        if(j == 0)
          drawQuad(x + i*SPRITE_SIZE, y + j*SPRITE_SIZE, 2 + 0);
        else if(j == ys - 1)
          drawQuad(x + i*SPRITE_SIZE, y + j*SPRITE_SIZE, 2 + 64);
        else
          drawQuad(x + i*SPRITE_SIZE, y + j*SPRITE_SIZE, 2 + 32);
      } else {
        if(j == 0)
          drawQuad(x + i*SPRITE_SIZE, y + j*SPRITE_SIZE, 1 + 0);
        else if(j == ys - 1)
          drawQuad(x + i*SPRITE_SIZE, y + j*SPRITE_SIZE, 1 + 64);
        else
          drawQuad(x + i*SPRITE_SIZE, y + j*SPRITE_SIZE, 1 + 32);
      }
    }
  }
}

// draw a 1 tall window for buttons or text input boxes
void drawShortWindow(float x, float y, int w) {
  if(w < 2)
    return;
  for(int i = 0; i < w; i++) {
    if(i == 0)
      drawQuad(x + i*SPRITE_SIZE, y, 3);
    else if(i == w - 1)
      drawQuad(x + i*SPRITE_SIZE, y, 5);
    else
      drawQuad(x + i*SPRITE_SIZE, y, 4);
  }
}