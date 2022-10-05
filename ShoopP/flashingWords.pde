float alpha = 0;

boolean flashWords(String title, float x, float y, float size) {
  
  
  if(alpha > 360) {
    alpha -= 360;
  }
  
  alpha ++;
  
  if(touchIsEnded) {
    touchIsEnded = false;
    return true;
  }
  
  if(mousePressed) {
    fill(25, 165, 250);
  }else {
    fill(255, abs(sin(radians(alpha))*510));
  }
  textSize(size);
  textAlign(CENTER, CENTER);
  text(title, x, y);
  
  return false;
  
}
