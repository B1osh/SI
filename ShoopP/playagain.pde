int hs = 0;
int PAscore = 0;

void playagain(String mod) {
  
  textAlign(CENTER, CENTER);
  textSize(width/8);
  fill(255);
  text("Score: " + PAscore + "\nHighscore: " + hs, width/2, height/4);
  
  if(buttonPressed(width*0.4, height*0.5, width*0.4, width/12, "Play Again?")) {
    mode = mod;
  }else if(buttonPressed(width*0.6, height*0.6, width*0.4, width/12, "Back to Menu")) {
    mode = "mainmenu";
  }
  
}
