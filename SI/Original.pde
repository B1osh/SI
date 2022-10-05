
Shape dependent_shape, independent_shape;
float score;
int lives;
float delay = 0;
float hs_latest = 0;


void reset(int a) {
  switch(a) {
    case(ORI):
    reset_original();
    break;
    case(IRR):
    reset_irregular();
    break;
    case(SIN):
    reset_sink();
    break;
  }
}

void reset_original() {
  score = 0;
  lives = 3;
  int n = randomInt(2, 4);
  dependent_shape = new Shape(new PVector(halfWidth, halfHeight), n, random(width*0.3, width*0.4), random(TWO_PI), schemes.get(chosenTheme).light);
  independent_shape = new Shape(new PVector(halfWidth, halfHeight), n, 0, 0, schemes.get(chosenTheme).main);
  independent_shape.setAlpha(220);
  mouseX = halfWidth;
  mouseY = halfHeight;
}

void original() {

  if (delay > millis()) return;
  if (lives == 0) {
    mode = -1;
    latest_mode = ORI;
    hs_latest = hs_original;
  }
  independent_shape.update_one();
  dependent_shape.display();
  independent_shape.display();

  noStroke();
  fill(schemes.get(chosenTheme).light);
  textAlign(LEFT, CENTER);
  textSize(width*0.12);
  text(str(round(hs_original)), width*0.2, width*0.098);
  text(str(round(score)), width*0.2, width*0.238);
  text(str(round(lives)), width*0.2, width*0.388);
  textAlign(CENTER, CENTER);
  pushMatrix();
  fill(schemes.get(chosenTheme).tertiary);
  translate(width*0.1, width*0.1);
  rotate(PI);
  draw_star(width*0.065);
  rotate(-PI);
  translate(0, width*0.14);
  draw_tally(width*0.06);
  translate(0, width*0.15);
  rotate(HALF_PI+QUARTER_PI);
  draw_heart(width*0.04);
  popMatrix();

  if (touchIsEnded) {
    float percentage = 100*independent_shape.area()/dependent_shape.area();
    if (percentage < 10 || initY > height*0.9) {
      independent_shape.radius = 0;
      mouseX = int(independent_shape.position.x);
      mouseY = int(independent_shape.position.y);
      return;
    }
    float s = 100 - abs(100-percentage);
    if (s < 89.5 || s > 110.5) { 
      fill(schemes.get(chosenTheme).fail);
      lives--;
    } else {
      fill(schemes.get(chosenTheme).alternate);
      score += s;
      independent_shape.sides = randomInt(2, 6);
      dependent_shape.sides = randomInt(2, 6);
      dependent_shape.radius = random(width*0.3, width*0.4);
      dependent_shape.rotation = random(TWO_PI);
      if (score > hs_original) {
        hs_original = score;
        saveHS();
      }
    }
    textSize(width/8);
    text(round(percentage)+"%", halfWidth, halfHeight);
    textSize(width/18);
    independent_shape.radius = 0;
    mouseX = halfWidth;
    mouseY = halfHeight;
    delay = millis() + 1500;
  }
}



void reset_irregular() {
  score = 0;
  lives = 3;
  int n = randomInt(0, 5);
  dependent_shape = new Shape(new PVector(halfWidth, halfHeight), n, random(width*0.3, width*0.4), random(TWO_PI), schemes.get(chosenTheme).light, IRREGULAR);
  independent_shape = new Shape(new PVector(halfWidth, halfHeight), n, 0, 0, schemes.get(chosenTheme).main, IRREGULAR);
  independent_shape.setAlpha(220);
  mouseX = halfWidth;
  mouseY = halfHeight;
}


void irregular() {

  if (delay > millis()) return;
  if (lives == 0) {
    mode = -1;
    latest_mode = IRR;
    hs_latest = hs_irregular;
  }
  independent_shape.update_one();
  dependent_shape.display();
  independent_shape.display();

  noStroke();
  fill(schemes.get(chosenTheme).light);
  textAlign(LEFT, CENTER);
  textSize(width*0.12);
  text(str(round(hs_irregular)), width*0.2, width*0.098);
  text(str(round(score)), width*0.2, width*0.238);
  text(str(round(lives)), width*0.2, width*0.388);
  textAlign(CENTER, CENTER);
  pushMatrix();
  fill(schemes.get(chosenTheme).tertiary);
  translate(width*0.1, width*0.1);
  rotate(PI);
  draw_star(width*0.065);
  rotate(-PI);
  translate(0, width*0.14);
  draw_tally(width*0.06);
  translate(0, width*0.15);
  rotate(HALF_PI+QUARTER_PI);
  draw_heart(width*0.04);
  popMatrix();

  if (touchIsEnded) {
    float percentage = 100*independent_shape.area()/dependent_shape.area();
    if (percentage < 10 || initY > height*0.9) {
      independent_shape.radius = 0;
      mouseX = int(independent_shape.position.x);
      mouseY = int(independent_shape.position.y);
      return;
    }
    float s = 100 - abs(100-percentage);
    if (s < 89.5 || s > 110.5) { 
      fill(schemes.get(chosenTheme).fail);
      lives--;
    } else {
      fill(schemes.get(chosenTheme).alternate);
      score += s;
      independent_shape.sides = randomInt(0, 5);
      dependent_shape.sides = randomInt(0, 5);
      dependent_shape.radius = random(width*0.3, width*0.4);
      dependent_shape.rotation = random(TWO_PI);
      if (score > hs_irregular) {
        hs_irregular = score;
        saveHS();
      }
    }
    textSize(width/8);
    text(round(percentage)+"%", halfWidth, halfHeight);
    textSize(width/18);
    independent_shape.radius = 0;
    mouseX = halfWidth;
    mouseY = halfHeight;
    delay = millis() + 1500;
  }
}





void reset_sink() {
  score = 0;
  lives = 3;
  int c = randomInt(0, 15);
  if (c < 5) {
    int n = randomInt(2, 6);
    dependent_shape = new Shape(new PVector(halfWidth, halfHeight), n, random(width*0.3, width*0.4), random(TWO_PI), schemes.get(chosenTheme).light);
    independent_shape = new Shape(new PVector(halfWidth, halfHeight), n, 0, 0, schemes.get(chosenTheme).main);
  } else if (c < 11) {
    int n = randomInt(0, 5);
    dependent_shape = new Shape(new PVector(halfWidth, halfHeight), n, random(width*0.3, width*0.4), random(TWO_PI), schemes.get(chosenTheme).light, IRREGULAR);
    independent_shape = new Shape(new PVector(halfWidth, halfHeight), n, 0, 0, schemes.get(chosenTheme).main, IRREGULAR);
  } else {
    int n = randomInt(0, 4);
    dependent_shape = new Shape(new PVector(halfWidth, halfHeight), n, random(width*0.3, width*0.4), random(TWO_PI), schemes.get(chosenTheme).light, MISC);
    independent_shape = new Shape(new PVector(halfWidth, halfHeight), n, 0, 0, schemes.get(chosenTheme).main, MISC);
  }


  independent_shape.setAlpha(220);
  mouseX = halfWidth;
  mouseY = halfHeight;
}


void sink() {

  if (delay > millis()) return;
  if (lives == 0) {
    mode = -1;
    latest_mode = SIN;
    hs_latest = hs_sink;
  }
  independent_shape.update_one();
  dependent_shape.display();
  independent_shape.display();

  noStroke();
  fill(schemes.get(chosenTheme).light);
  textAlign(LEFT, CENTER);
  textSize(width*0.12);
  text(str(round(hs_sink)), width*0.2, width*0.098);
  text(str(round(score)), width*0.2, width*0.238);
  text(str(round(lives)), width*0.2, width*0.388);
  textAlign(CENTER, CENTER);
  pushMatrix();
  fill(schemes.get(chosenTheme).tertiary);
  translate(width*0.1, width*0.1);
  rotate(PI);
  draw_star(width*0.065);
  rotate(-PI);
  translate(0, width*0.14);
  draw_tally(width*0.06);
  translate(0, width*0.15);
  rotate(HALF_PI+QUARTER_PI);
  draw_heart(width*0.04);
  popMatrix();

  if (touchIsEnded) {
    float percentage = 100*independent_shape.area()/dependent_shape.area();
    if (percentage < 10 || initY > height*0.9) {
      independent_shape.radius = 0;
      mouseX = int(independent_shape.position.x);
      mouseY = int(independent_shape.position.y);
      return;
    }
    float s = 100 - abs(100-percentage);
    if (s < 89.5 || s > 110.5) { 
      fill(schemes.get(chosenTheme).fail);
      lives--;
    } else {
      fill(schemes.get(chosenTheme).alternate);
      score += s;
      independent_shape.is_irregular = false;
      independent_shape.is_misc = false;
      dependent_shape.is_irregular = false;
      dependent_shape.is_misc = false;
      int c = randomInt(0, 15);
      if (c < 5) {
        independent_shape.sides = randomInt(2, 6);
      } else if (c < 11) {
        independent_shape.sides = randomInt(0, 5);
        independent_shape.is_irregular = true;
      } else {
        independent_shape.sides = randomInt(0, 4);
        independent_shape.is_misc = true;
      }

      c = randomInt(0, 15);
      if (c < 5) {
        dependent_shape.sides = randomInt(2, 6);
      } else if (c < 11) {
        dependent_shape.sides = randomInt(0, 5);
        dependent_shape.is_irregular = true;
      } else {
        dependent_shape.sides = randomInt(0, 4);
        dependent_shape.is_misc = true;
      }


      dependent_shape.radius = random(width*0.3, width*0.4);
      dependent_shape.rotation = random(TWO_PI);
      if (score > hs_sink) {
        hs_sink = score;
        saveHS();
      }
    }
    textSize(width/8);
    text(round(percentage)+"%", halfWidth, halfHeight);
    textSize(width/18);
    independent_shape.radius = 0;
    mouseX = halfWidth;
    mouseY = halfHeight;
    delay = millis() + 1500;
  }
}
