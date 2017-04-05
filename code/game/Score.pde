class Score {

  int score;
  
  Score() {
    score = 0;
  }
  
  void update() {
    score++;
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

void enemiesDestroyed() {
  
    score.addScore(100);
}