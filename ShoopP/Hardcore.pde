float highscoreHar;


void resetHar() {
  level = 1;
  score = 0;
  lives = 1;
  stage = 0;
  randomPolygon.randomise(min((level + 3) / 2, 7));
  drawnPolygon.randomise(min((level + 3) / 2, 7));
  mouseX = width/2;
  mouseY = height/2;
}

void hardcore() {
  
  
  if(stage == 0) {
    randomPolygon.display();
    drawnPolygon.drawn();
    drawnPolygon.display();
    textSize(width/16);
    fill(255);
    textAlign(LEFT, TOP);
    text("Level: " + level + "\nLives: " + lives + "\nScore: " + round(score) + "\nHighscore: " + round(highscoreHar), 20, 20);
    if(touchIsEnded) {
      stage = 1;
    }
  }

  
  if(stage == 1) {
    
    
    randomPolygon.display();
    drawnPolygon.display();
    
    if((drawnPolygon.area() * 100) / randomPolygon.area() < 95 || (drawnPolygon.area() * 100) / randomPolygon.area() > 105) {
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
    text("Level: " + level + "\nLives: " + lives + "\nScore: " + round(score ) + "\nHighscore: " + round(highscoreHar), 20, 20);
    
    wait  ++;
    
    if(wait  > 100) {
      stage  = 1;
      wait  = 0;
      
      if((drawnPolygon.area() * 100) / randomPolygon.area() < 95 || (drawnPolygon.area() * 100) / randomPolygon.area() > 105) {
        mouseX = width/2;
        mouseY = height/2;
        lives  -= 1;
        stage  = 0;
        if(lives  <= 0) {
          PAscore = round(score);
          resetHar ();
          mo = "hardcore";
          hs = round(highscoreHar);
          mode = "playagain";
        }
      }else {
        mouseX = width/2;
        mouseY = height/2;
        score  += 100 - abs(100 - (drawnPolygon.area() * 100) / randomPolygon.area());
        highscoreHar = max(score, highscoreHar);
        level ++;
        randomPolygon.randomise(min((level + 3) / 2, 7));
        drawnPolygon.randomise(min((level + 3) / 2, 7));
        stage = 0;
      }
    }
    
  } 
  
}
