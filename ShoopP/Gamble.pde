
float highscoreGam;

void resetGam() {
  level = 1;
  score = 0;
  stage = 0;
  randomPolygon.randomise(7);
  drawnPolygon.randomise(7);
  mouseX = width/2;
  mouseY = height/2;
}

void gamble() {
  
  
  if(stage == 0) {
    randomPolygon.display();
    drawnPolygon.drawn();
    drawnPolygon.display();
    textSize(width/16);
    fill(255);
    textAlign(LEFT, TOP);
    text("Level: " + level + "\nScore: " + round(score) + "\nHighscore: " + round(highscoreGam), 20, 20);
    if(touchIsEnded) {
      stage = 1;
    }
  }

  
  if(stage == 1) {
    
    
    randomPolygon.display();
    drawnPolygon.display();
    
    if((drawnPolygon.area() * 100) / randomPolygon.area() > 200) {
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
    text("Level: " + level + "\nScore: " + round(score) + "\nHighscore: " + round(highscoreGam), 20, 20);
    
    wait ++;
    
    if(wait > 100) {
      stage = 1;
      wait = 0;
      
      if((drawnPolygon.area() * 100) / randomPolygon.area() > 200) {
        mouseX = width/2;
        mouseY = height/2;
        level ++;
        stage = 0;
        if(level >= 11) {
          PAscore = round(score);
          resetGam();
          mo = "gamble";
          hs = round(highscoreGam);
          mode = "playagain";
        }
      }else {
        mouseX = width/2;
        mouseY = height/2;
        score += drawnPolygon.area() * 100 / randomPolygon.area();
        highscoreGam = max(score, highscoreGam);
        level ++;
        randomPolygon.randomise(7);
        drawnPolygon.randomise(7);
        stage = 0;
        if(level >= 11) {
          PAscore = round(score);
          resetGam();
          mo = "gamble";
          hs = round(highscoreGam);
          mode = "playagain";
        }
        
      }
      
    }
    
  } 
  
}
