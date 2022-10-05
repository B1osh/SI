//FINDS ANGLE abc

float get_angle(PVector a, PVector b, PVector c) {

  /*
  stroke(100);
   line(a.x, a.y, b.x, b.y);
   line(b.x, b.y, c.x, c.y);
   */

  float angle = PVector.angleBetween(a.sub(b), c.sub(b));
  a.add(b);
  c.add(b);
  if (orientation(a, b, c) == -1) {
    angle = TWO_PI - angle;
  }

  return angle;
}

// Inclusive
int randomInt(int min, int max) {
  return min+floor(random(1+max-min));
}

int orientation(PVector a, PVector b, PVector c) {
  float val = (b.y - a.y) * (c.x - b.x) - (b.x - a.x) * (c.y - b.y);
  if (val == 0) return 0;
  return (val > 0)? 1: -1;
}

boolean mouseIn(float x, float y, float w, float h) {
  return !(mouseX < x-w*0.5 || mouseX > x+w*0.5 || mouseY < y-h*0.5 || mouseY > y+h*0.5);
}



void checkTheme() {
  int mode = config.uiMode & Configuration.UI_MODE_NIGHT_MASK;
  if (mode == previousTheme) return;
  previousTheme = mode;
  switch (mode) {
  case Configuration.UI_MODE_NIGHT_YES:
    schemes.set(0, new Palette(color(0, 0, 20), color(0, 0, 27), color(55, 7, 78), color(192, 38, 62), color(21, 83, 96), color(211, 60, 100), color(151, 65, 86), color(1, 59, 94)));
    break;
  case Configuration.UI_MODE_NIGHT_NO:
    schemes.set(0, new Palette(color(0, 0, 89), color(0, 0, 52), color(0, 0, 21), color(0, 59, 84), color(118, 50, 74), color(213, 67, 81), color(50, 79, 100), color(30,93,100)));
    break;
  }
}


void drawWindows(float x, float y, float w, color a, color b, color c, color d, color s) {

  noStroke();
  fill(a);
  rect(x-w*0.25, y-w*0.25, w*0.5, w*0.5);
  fill(b);
  rect(x+w*0.25, y-w*0.25, w*0.5, w*0.5);
  fill(c);
  rect(x-w*0.25, y+w*0.25, w*0.5, w*0.5);
  fill(d);
  rect(x+w*0.25, y+w*0.25, w*0.5, w*0.5);

  stroke(s);
  strokeWeight(width*0.01);
  line(x-w*0.5, y-w*0.5, x+w*0.5, y-w*0.5);
  line(x+w*0.5, y+w*0.5, x+w*0.5, y-w*0.5);
  line(x+w*0.5, y+w*0.5, x-w*0.5, y+w*0.5);
  line(x-w*0.5, y-w*0.5, x-w*0.5, y+w*0.5);
}
