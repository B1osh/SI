float highscoreMul;
float multiMul;


void resetMul() {
  level = 1;
  score = 0;
  lives = 3;
  stage = 0;
  multiMul = 1.5;
  randomPolygon.randomise(min((level + 3) / 2, 7));
  drawnPolygon.randomise(min((level + 3) / 2, 7));
  mouseX = width/2;
  mouseY = height/2;
}

void multiplier() {
  
  
  if(stage == 0) {
    randomPolygon.display();
    drawnPolygon.drawn();
    drawnPolygon.display();
    textSize(width/16);
    fill(255);
    textAlign(LEFT, TOP);
    text("Level: " + level + "\nLives: " + lives + "\nScore: " + round(score) + "\nHighscore: " + round(highscoreMul), 20, 20);
    textAlign(RIGHT, TOP);
    textSize(width/8);
    text(multiMul + "x", width - 20, 20);
    if(touchIsEnded) {
      stage = 1;
    }
  }

  
  if(stage == 1) {
    
    
    randomPolygon.display();
    drawnPolygon.display();
    
    if((drawnPolygon.area() * 100) / (multiMul * randomPolygon.area()) < 90 || (drawnPolygon.area() * 100) / (multiMul * randomPolygon.area()) > 110) {
      fill(255, 0, 0);
    }else {
      fill(0, 255, 0);
    }
    textSize(width/4);
    textAlign(CENTER, CENTER);
    text(round((drawnPolygon.area() * 100) / (multiMul * randomPolygon.area())) + "%", width/2, height/2);
    textSize(width/16);
    fill(255);
    textAlign(LEFT, TOP);
    text("Level: " + level + "\nLives: " + lives + "\nScore: " + round(score ) + "\nHighscore: " + round(highscoreMul), 20, 20);
    textAlign(RIGHT, TOP);
    textSize(width/8);
    text(multiMul + "x", width - 20, 20);
    
    wait  ++;
    
    if(wait  > 100) {
      stage  = 1;
      wait  = 0;
      
      if((drawnPolygon.area() * 100) / (multiMul * randomPolygon.area()) < 90 || (drawnPolygon.area() * 100) / (multiMul * randomPolygon.area()) > 110) {
        mouseX = width/2;
        mouseY = height/2;
        lives  -= 1;
        stage  = 0;
        if(lives  <= 0) {
          PAscore = round(score);
          resetMul ();
          mo = "multiplier";
          hs = round(highscoreMul);
          mode = "playagain";
        }
      }else {
        mouseX = width/2;
        mouseY = height/2;
        score  += 100 - abs(100 - (drawnPolygon.area() * 100) / (multiMul * randomPolygon.area()));
        highscoreMul = max(score, highscoreMul);
        level ++;
        randomPolygon.randomise(min((level + 3) / 2, 7));
        drawnPolygon.randomise(min((level + 3) / 2, 7));
        multiMul = float(int(random(6, 20))) / 10;
        stage = 0;
      }
    }
    
  } 
  
}
