class Score {

  int score;
  float time;
  
  Score() {
    score = 0;
  }
  
  void update() {
    if(time > 0)
      time--;
   // score++;
  }


  void addScore(int amount) {
    score += amount;
  }

  int getScore() {
    return score;
  }
}

public Score score;

void initScore() {
  score = new Score();
}

void updateScore() {
  score.update();
}

int scoreAmount() {
  return score.getScore();
}

float scoreTime() {
  return score.time;
}

void enemiesDestroyed(int amt) {
    score.addScore(amt);
    score.time = 6 + (amt/60);
}