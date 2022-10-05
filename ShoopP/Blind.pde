
Timer second;
float highscoreBli;

void resetBli() {
  level = 1;
  score = 0;
  lives = 3;
  stage = 0;
  randomPolygon.randomise(min((level + 3) / 2, 7));
  drawnPolygon.randomise(min((level + 3) / 2, 7));
  mouseX = width/2;
  mouseY = height/2;
  second.Start();
}

void blind() {
  
  
  if(stage == 0) {
    if(!second.isOut()) {
      randomPolygon.display();
    }else{
      drawnPolygon.drawn();
      drawnPolygon.display();
    }
    textSize(width/16);
    fill(255);
    textAlign(LEFT, TOP);
    text("Level: " + level + "\nLives: " + lives + "\nScore: " + round(score) + "\nHighscore: " + round(highscoreBli), 20, 20);
    if(touchIsEnded) {
      stage = 1;
    }
  }

  
  if(stage == 1) {
    
    randomPolygon.display();
    drawnPolygon.display();
    
    if((drawnPolygon.area() * 100) / randomPolygon.area() < 90 || (drawnPolygon.area() * 100) / randomPolygon.area() > 110) {
      fill(255, 0, 0);
    }else {
      fill(0, 255, 0);
    }
    textSize(width/4);
    textAlign(CENTER, CENTER);
    text(round((drawnPolygon.area() * 100) / randomPolygon.area()) + "%", width/2, height/2);
    textSize(width/16);
    fill(255);
    textAlign(LEFT, TOP);
    text("Level: " + level + "\nLives: " + lives + "\nScore: " + round(score ) + "\nHighscore: " + round(highscoreBli), 20, 20);
    
    wait  ++;
    
    if(wait  > 100) {
      stage  = 1;
      wait  = 0;
      second.Start();
      
      if((drawnPolygon.area() * 100) / randomPolygon.area() < 90 || (drawnPolygon.area() * 100) / randomPolygon.area() > 110) {
        mouseX = width/2;
        mouseY = height/2;
        lives  -= 1;
        stage  = 0;
        if(lives  <= 0) {
          PAscore = round(score);
          resetBli ();
          mo = "blind";
          hs = round(highscoreBli);
          mode = "playagain";
        }
      }else {
        mouseX = width/2;
        mouseY = height/2;
        score  += 100 - abs(100 - (drawnPolygon.area() * 100) / randomPolygon.area());
        highscoreBli = max(score, highscoreBli);
        level ++;
        randomPolygon.randomise(min((level + 3) / 2, 7));
        drawnPolygon.randomise(min((level + 3) / 2, 7));
        stage = 0;
      }
    }
    
  } 
  
}
