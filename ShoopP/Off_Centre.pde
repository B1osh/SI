
float highscoreOff;
float offx, offy;

void resetOff() {
  level = 1;
  score = 0;
  lives = 3;
  stage = 0;
  randomPolygon.randomise(min((level + 3) / 2, 7));
  drawnPolygon.randomise(min((level + 3) / 2, 7));
  mouseX = width/2;
  mouseY = height/2;
  offx = 0.2;
  offy = 0.2;
  println(offx);
  println(offy);
}

void offcentre() {
  
  //println(offx);
  //println(offy);
  
  if(stage == 0) {
    
    pushMatrix();
    translate(offx * width, offy * width);
    randomPolygon.display();
    popMatrix();
    drawnPolygon.drawn();
    drawnPolygon.display();
    textSize(width/16);
    fill(255);
    textAlign(LEFT, TOP);
    text("Level: " + level + "\nLives: " + lives + "\nScore: " + round(score) + "\nHighscore: " + round(highscoreOff), 20, 20);
    if(touchIsEnded) {
      stage = 1;
    }
  }

  
  if(stage == 1) {
    
    pushMatrix();
    translate(offx * width, offy * width);
    randomPolygon.display();
    popMatrix();
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
    text("Level: " + level + "\nLives: " + lives + "\nScore: " + round(score ) + "\nHighscore: " + round(highscoreOff), 20, 20);
    
    wait  ++;
    
    if(wait  > 100) {
      stage  = 1;
      wait  = 0;
      
      if((drawnPolygon.area() * 100) / randomPolygon.area() < 90 || (drawnPolygon.area() * 100) / randomPolygon.area() > 110) {
        mouseX = width/2;
        mouseY = height/2;
        lives  -= 1;
        stage  = 0;
        if(lives  <= 0) {
          PAscore = round(score);
          resetOff ();
          mo = "offcentre";
          hs = round(highscoreOff);
          mode = "playagain";
        }
      }else {
        mouseX = width/2;
        mouseY = height/2;
        offx = random(-0.2, 0.2);
        offy = random(-0.2, 0.2);
        score += 100 - abs(100 - (drawnPolygon.area() * 100) / randomPolygon.area());
        highscoreOff = max(score, highscoreOff);
        level ++;
        randomPolygon.randomise(min((level + 3) / 2, 7));
        drawnPolygon.randomise(min((level + 3) / 2, 7));
        stage = 0;
      }
    }
    
  } 
  
}
