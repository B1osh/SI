Timer timed;
Timer halfsecond;
float highscoreTim;
void resetTim() {
  level = 1;
  stage = -1;
  score = 0;
  randomPolygon.randomise(min((level + 3) / 2, 7));
  drawnPolygon.randomise(min((level + 3) / 2, 7));
  mouseX = width/2;
  mouseY = height/2;
}

void timed() {
  
  if(stage == -1) {
    timed.Start();
    stage = 0;
  }
  
  
  if(stage == 0) {
    randomPolygon.display();
    drawnPolygon.drawn();
    drawnPolygon.display();
    textSize(width/16);
    fill(255);
    textAlign(LEFT, TOP);
    text("Level: " + int(score) + "\nHighscore: " + round(highscoreTim), 20, 20);
    timed.display(width/16, width - 20, width/16, color(255));
    if(touchIsEnded) {
      stage = 1;
      halfsecond.Start();
      
    }
    if(timed.isOut()) {
      PAscore = round(score);
      resetTim ();
      mo = "timed";
      hs = round(highscoreTim);
      mode = "playagain";
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
    text("Level: " + int(score) + "\nHighscore: " + round(highscoreTim), 20, 20);
    timed.display(width/16, width - 20, width/16, color(255));
    
    
    if(halfsecond.isOut()) {
      stage  = 1;
      
      if((drawnPolygon.area() * 100) / randomPolygon.area() < 90 || (drawnPolygon.area() * 100) / randomPolygon.area() > 110) {
        mouseX = width/2;
        mouseY = height/2;
        timed.Add(-2500);
        stage  = 0;
      }else {
        mouseX = width/2;
        mouseY = height/2;
        score  ++;
        timed.Add(3500);
        highscoreTim = max(score, highscoreTim);
        randomPolygon.randomise(min((int(score) + 3) / 2, 7));
        drawnPolygon.randomise(min((int(score) + 3) / 2, 7));
        stage = 0;
      }
    }
    
  } 
  
}
