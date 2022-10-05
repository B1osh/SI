
// buttonPressed RETURNS TRUE IF BUTTON IS TOUCHED AND RELEASED

boolean buttonPressed(float xpos, float ypos, float xrad, float yrad, String title) {

  //TESTS IF BUTTON HAS BEEN RELEASED
  if(touchIsEnded && mouseX < xpos + xrad && mouseX > xpos - xrad && mouseY < ypos + yrad && mouseY > ypos - yrad) {
    touchIsEnded = false;
    return true;
  }
  
  //TEST TO SEE IF BUTTON HAS BEEN PRESSED DOWN AND DRAWS BUTTON
  if(mouseX < xpos + xrad && mouseX > xpos - xrad && mouseY < ypos + yrad && mouseY > ypos - yrad) {
    fill(0);
    rectMode(RADIUS);
    rect(xpos, ypos, xrad, yrad);
    fill(255);
  }else{
    fill(255);
    rectMode(RADIUS);
    rect(xpos, ypos, xrad, yrad);
    fill(0);
  }
  textSize(min(xrad,yrad));
  textAlign(CENTER, CENTER);
  text(title, xpos, ypos);
  
  return false;
  
}
