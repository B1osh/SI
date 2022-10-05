float highscoreIrr;

void resetIrr() {
  level = 1;
  score = 0;
  lives = 3;
  stage = 0;
  randomI.randomise();
  drawnI.randomise();
  mouseX = width/2;
  mouseY = height/2;
}

void irregular() {
  
  
  if(stage == 0) {
    randomI.display();
    drawnI.drawn();
    drawnI.display();
    textSize(width/16);
    fill(255);
    textAlign(LEFT, TOP);
    text("Level: " + level + "\nLives: " + lives + "\nScore: " + round(score) + "\nHighscore: " + round(highscoreIrr), 20, 20);
    if(touchIsEnded) {
      stage = 1;
    }
  }

  
  if(stage == 1) {
    
    
    randomI.display();
    drawnI.display();
    
    if((drawnI.area() * 100) / randomI.area() < 90 || (drawnI.area() * 100) / randomI.area() > 110) {
      fill(255, 0, 0);
    }else {
      fill(0, 255, 0);
    }
    textSize(width/4);
    textAlign(CENTER, CENTER);
    text(round((drawnI.area() * 100) / randomI.area()) + "%", width/2, height/2);
    textSize(width/16);
    fill(255);
    textAlign(LEFT, TOP);
    text("Level: " + level + "\nLives: " + lives + "\nScore: " + round(score ) + "\nHighscore: " + round(highscoreIrr), 20, 20);
    
    wait  ++;
    
    if(wait > 100) {
      stage  = 1;
      wait  = 0;
      
      if((drawnI.area() * 100) / randomI.area() < 90 || (drawnI.area() * 100) / randomI.area() > 110) {
        mouseX = width/2;
        mouseY = height/2;
        lives  -= 1;
        stage  = 0;
        if(lives  <= 0) {
          PAscore = round(score);
          resetIrr();
          mo = "irregular";
          hs = round(highscoreIrr);
          mode = "playagain";
        }
      }else {
        mouseX = width/2;
        mouseY = height/2;
        score  += 100 - abs(100 - (drawnI.area() * 100) / randomI.area());
        highscoreIrr = max(score, highscoreIrr);
        level ++;
        randomI.randomise();
        drawnI.randomise();
        stage = 0;
      }
    }
    
  } 
  
}
