

int main_menu() {
  menu_shape.update_one();

  float dw = halfWidth*0.16;
  float dh = dw*ROOT3;
  float dr = dw*2;
  float dl = dr;
  float dt = dw*0.1;
  PVector p;
  int r = 0;

  //line(halfWidth, halfHeight, halfWidth+dw, halfHeight);
  //line(halfWidth, halfHeight, halfWidth, halfHeight+dh);
  //line(halfWidth, halfHeight, halfWidth+dw, halfHeight+dh);
  stroke(schemes.get(chosenTheme).light);
  strokeWeight(dt);
  textAlign(RIGHT, CENTER);

  menu_shape.colour = schemes.get(chosenTheme).light;
  for (int i = 1; i < 5; i++) {
    p = new PVector(halfWidth+i*dw, halfHeight+i*dh);

    line(p.x, p.y, p.x-dl, p.y);
    line(p.x, p.y, p.x+dl*0.5, p.y-dl*HALF_ROOT3);

    fill(schemes.get(chosenTheme).neutral);
    textFont(mainFont);
    if (menu_shape.radius > (i)*dr && (menu_shape.radius < (i+1)*dr || i == 4)) {
      menu_shape.colour = schemes.get(chosenTheme).main;
      menu_shape.setAlpha(200);
      r = i;
      if (touchIsStarted) {
        textFont(boldFont);
        fill(schemes.get(chosenTheme).secondary);
      }
    }

    text(stages[i], p.x+dt*7, p.y+dt*7);
  }

  textAlign(CENTER, CENTER);

  if (touchIsStarted) {
    menu_shape.display();
  }
  return touchIsEnded ? r: -1;
}


// --------------------------------------------------------------------------------------------


int game_menu() {
  menu_shape.update_one();
  float dw = halfWidth*0.16;
  float dh = dw*ROOT3;
  float dr = dw*2;
  float dl = dr;
  float dt = dw*0.1;
  PVector p;
  int r = -1;

  //line(halfWidth, halfHeight, halfWidth+dw, halfHeight);
  //line(halfWidth, halfHeight, halfWidth, halfHeight+dh);
  //line(halfWidth, halfHeight, halfWidth+dw, halfHeight+dh);
  stroke(schemes.get(chosenTheme).light);
  strokeWeight(dt);
  textAlign(RIGHT, CENTER);

  menu_shape.colour = schemes.get(chosenTheme).light;
  for (int i = 1; i < 5; i++) {
    p = new PVector(halfWidth+i*dw, halfHeight+i*dh);

    line(p.x, p.y, p.x-dl, p.y);
    line(p.x, p.y, p.x+dl*0.5, p.y-dl*HALF_ROOT3);

    fill(schemes.get(chosenTheme).neutral);
    textFont(mainFont);

    if (menu_shape.radius > (i)*dr && (menu_shape.radius < (i+1)*dr || i == 4)) {
      menu_shape.colour = schemes.get(chosenTheme).secondary;
      menu_shape.setAlpha(200);
      r = i;
      if (touchIsStarted) {
        textFont(boldFont);
        fill(schemes.get(chosenTheme).tertiary);
      }
    }
    text(game_modes[i], p.x+dt*7, p.y+dt*7);
  }

  textAlign(CENTER, CENTER);

  if (touchIsStarted) {
    menu_shape.display();
  }
  if (r == 4) r = -2;
  return touchIsEnded ? r: -1;
}



// --------------------------------------------------------------------------------------------


void settings_menu() {

  textAlign(CENTER, CENTER);
  textSize(width*0.1);
  fill(schemes.get(chosenTheme).light);
  text("THEME", halfWidth, height*0.06);

  // MATCH SYSTEM
  fill(0, 0, 95);
  color temp = (chosenTheme == 0) ? schemes.get(chosenTheme).light : schemes.get(chosenTheme).neutral;
  stroke(temp);
  strokeWeight(width*0.01);
  rect(width*0.17, width*0.33, width*0.2, width*0.2);
  fill(0, 0, 15);
  textSize(width*0.04);
  text("MATCH\nSYSTEM", width*0.17, width*0.33);
  if (touchIsEnded && mouseIn(width*0.17, width*0.33, width*0.2, width*0.2)) {
    chosenTheme = 0;
    saveSettings();
  }


  for (int i = 1; i < 3; i++) {
    color s = (chosenTheme == i) ? schemes.get(chosenTheme).light : schemes.get(chosenTheme).neutral;
    drawWindows(width*(i*0.33+0.17), width*0.33, width*0.2, schemes.get(i).dark, schemes.get(i).main, schemes.get(i).secondary, schemes.get(i).tertiary, s); 

    if (touchIsEnded && mouseIn(width*(i*0.33+0.17), width*0.33, width*0.2, width*0.2)) {
      chosenTheme = i;
      saveSettings();
    }
  }



  textSize(width/18);
}


int latest_mode;
int death_menu() {

  textFont(mainFont);
  fill(schemes.get(chosenTheme).light);
  textAlign(LEFT, CENTER);
  textSize(width*0.18);
  text(str(round(hs_latest)), width*0.38, width*0.3);
  text(str(round(score)), width*0.38, width*0.6);
  textAlign(CENTER, CENTER);
  noStroke();
  pushMatrix();
  fill(schemes.get(chosenTheme).tertiary);
  translate(width*0.26, width*0.3);
  rotate(PI);
  draw_star(width*0.1);
  rotate(-PI);
  translate(0, width*0.3);
  draw_tally(width*0.1);
  popMatrix();




  menu_shape.update_one();
  float dw = halfWidth*0.16;
  float dh = dw*ROOT3;
  float dr = dw*2;
  float dl = dr;
  float dt = dw*0.1;
  PVector p;
  int r = -1;

  //line(halfWidth, halfHeight, halfWidth+dw, halfHeight);
  //line(halfWidth, halfHeight, halfWidth, halfHeight+dh);
  //line(halfWidth, halfHeight, halfWidth+dw, halfHeight+dh);
  stroke(schemes.get(chosenTheme).light);
  strokeWeight(dt);
  textAlign(RIGHT, CENTER);

  menu_shape.colour = schemes.get(chosenTheme).light;
  for (int i = 1; i < 4; i++) {
    p = new PVector(halfWidth+i*dw, halfHeight+i*dh);

    line(p.x, p.y, p.x-dl, p.y);
    line(p.x, p.y, p.x+dl*0.5, p.y-dl*HALF_ROOT3);

    fill(schemes.get(chosenTheme).neutral);
    textFont(mainFont);

    if (menu_shape.radius > (i)*dr && (menu_shape.radius < (i+1)*dr || i == 3)) {
      menu_shape.colour = schemes.get(chosenTheme).secondary;
      menu_shape.setAlpha(200);
      r = i;
      if (touchIsStarted) {
        textFont(boldFont);
        fill(schemes.get(chosenTheme).tertiary);
      }
    }
    text(death_options[i], p.x+dt*7, p.y+dt*7);
  }

  textAlign(CENTER, CENTER);

  if (touchIsStarted) {
    menu_shape.display();
  }

  return touchIsEnded ? r: -1;
}
