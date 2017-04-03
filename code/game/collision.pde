
// Give it center coord + width
int checkCollision(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  if(y1 + h1*0.5 > y2 - h2*0.5 && y1 - h1*0.5 < y2 + h2*0.5)
    if(x1 + w1*0.5 > x2 - w2*0.5 && x1 - w1*0.5 < x2 + w2*0.5)    
      return 1;
  return 0;
}