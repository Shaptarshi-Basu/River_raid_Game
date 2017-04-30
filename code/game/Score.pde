
public int[] scores = new int[5];
public String[] scorenames = new String[5];


void loadScores() {
  BufferedReader input = createReader("scores.txt");
  String line;
  for(int i = 0; i < 5; i++) {
    scorenames[i] = "error";
    scores[i] = 0;
    try {
      line = input.readLine();
      scorenames[i] = line;
      line = input.readLine();
      scores[i] = int(line);
    } catch(IOException e) {
    }
  }
}

void addScore() {
  int newscore = scoreAmount();
  int i;
  for(i = 0; i < 5; i++) {
    if(newscore > scores[i]) {
      for(int j = 3; j >= i; j--) {
        scores[j+1] = scores[j];
        scorenames[j+1] = scorenames[j];
      }
      scores[i] = newscore;
      scorenames[i] = playername;
      break;
    }
  }
  PrintWriter output = createWriter("scores.txt");
  for(i = 0; i < 5; i++) {
    output.println(scorenames[i]);
    output.println(scores[i]);
  }
  output.flush();
  output.close();
}

public int current_score;
public int score_time;

void initScore() {
  current_score = 0;
}

void updateScore() {
  if(score_time > 0)
    score_time--;
}

int scoreAmount() {
  return current_score;
}

float scoreTime() {
  return score_time;
}

void enemiesDestroyed(int amt) {
    current_score += amt;
    score_time = 6 + (amt/60);
}