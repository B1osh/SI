package processing.test.si;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import android.app.Activity; 
import android.content.res.Resources; 
import android.content.res.Configuration; 
import android.Manifest.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class SI extends PApplet {






Configuration config;

// Shape(PVector pos, int sid, float rad, float rot, color col)
// Shape(PVector pos, int sid, float rad)

// Constants

int halfHeight, halfWidth;
final float ROOT10 = sqrt(10);
final float ROOT3 = sqrt(3);
final float HALF_ROOT3 = sqrt(3)*0.5f;
final float ROOT2 = sqrt(2);
final float HALF_ROOT2 = sqrt(2)*0.5f;
final float cos2PI5 = cos(0.4f*PI);
final float cosPI5 = cos(0.2f*PI);
final float c25c5 = cos2PI5/cosPI5;

final String stages[] = {"Main", "Play", "Settings", "Help", "Quit"};
final String game_modes[] = {"NULL", "Original", "Irregular", "Kitchen Sink", "Return to Menu"};
final String death_options[] = {"NULL", "Play Again", "Game Menu", "Main Menu"};

PFont mainFont;
PFont boldFont;

// Globals
int chosenTheme = 0;
int previousTheme = 0;
Shape menu_shape;
boolean touchIsEnded = false;
float initX, initY;

// Stages

// 0 = Main menu, 1 = Mode menu, 2 = Settings
int stage = 0;
final int MAIN = 0;
final int MODE = 1;
final int SETTINGS = 2;
final int HELP = 3;
final int QUIT = 4;
final int PLAY = 5;
// 0 = Original, 1 =
int mode = 0;
final int ORI = 1;
final int IRR = 2;
final int SIN = 3;

// -------



public void setRatio() { 
  halfWidth = PApplet.parseInt(width*0.5f);
  halfHeight = PApplet.parseInt(height*0.5f);
  mainFont = createFont("font/Montserrat-Regular.ttf", width/18, true);
  boldFont = createFont("font/Montserrat-Bold.ttf", width/18, true);
}

public void setup() {
  
  orientation(PORTRAIT);
  setRatio();
  config = getActivity().getResources().getConfiguration();
  
  textAlign(CENTER, CENTER);
  ellipseMode(RADIUS);
  rectMode(CENTER);
  colorMode(HSB, 360, 100, 100, 100);
  background(0);

  //  String[] fontList = PFont.list();
  //  printArray(fontList);
  mainFont = createFont("font/Montserrat-Regular.ttf", 48, true);
  boldFont = createFont("font/Montserrat-Bold.ttf", 48, true);
  create_palettes();
  textFont(mainFont);
  initX = halfWidth;
  initY = halfHeight;
  loadHS();
  loadSettings();

  // TESTING
  menu_shape = new Shape(new PVector(halfWidth, halfHeight), 0, 100, MISC);
}



public void draw() {
  if (millis() > delay) background(schemes.get(chosenTheme).dark);
  int choice;
  switch(stage) {
    case(MAIN):
    choice = main_menu();
    if (choice != -1) stage = choice;
    break;

    case(MODE):
    choice = game_menu();
    if (choice == -2) stage = MAIN;
    else if (choice != -1) {
      reset(choice);
      stage = PLAY;
      mode = choice;
    }
    break;

    case(PLAY):
    switch(mode) {
      case(ORI):
        original();
        break;
      case(IRR):
        irregular();
        break;
      case(SIN):
        sink();
        break;
      case(-1):
        choice = death_menu();
        switch(choice) {
          case(1):
            reset(latest_mode);
            mode = latest_mode;
            break;
          case(2):
            stage = MODE;
            break;
          case(3):
            stage = MAIN;
            break;
        }
      break;

      default:
        println("NO GAME TYPE ERROR");
        noLoop();
    }
    break;

    case(SETTINGS):
    settings_menu();
    break;
    
    case(HELP):
      text("Help yourself", halfWidth, halfHeight);
      break;
    
    case(QUIT):
      System.exit(0);
      break;

  default:
    text(stages[stage], halfWidth, halfHeight);
  }

  if (chosenTheme == 0) checkTheme();
  touchIsEnded = false;
}

// END DRAW

public void touchEnded() {
  if (dist(initX, initY, halfWidth, halfHeight) > 0.9f*dist(0, 0, halfWidth, halfHeight)) return;
  initX = halfWidth;
  initY = halfHeight;
  touchIsEnded = true;
}

public void touchStarted() {
  initX = mouseX;
  initY = mouseY;
}

public void onBackPressed() {
  delay = 0;
  switch(stage) {
    case(MAIN):
    System.exit(0);
    break;
    case(MODE):
    case(SETTINGS):
    case(HELP):
    stage = MAIN;
    break;
    case(PLAY):
    stage = MODE;
    mode = 0;
    break;
  default:
    println("ERROR. INVALID BACK BUTTON");
  }
}

Shape dependent_shape, independent_shape;
float score;
int lives;
float delay = 0;
float hs_latest = 0;


public void reset(int a) {
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

public void reset_original() {
  score = 0;
  lives = 3;
  int n = randomInt(2, 4);
  dependent_shape = new Shape(new PVector(halfWidth, halfHeight), n, random(width*0.3f, width*0.4f), random(TWO_PI), schemes.get(chosenTheme).light);
  independent_shape = new Shape(new PVector(halfWidth, halfHeight), n, 0, 0, schemes.get(chosenTheme).main);
  independent_shape.setAlpha(220);
  mouseX = halfWidth;
  mouseY = halfHeight;
}

public void original() {

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
  textSize(width*0.12f);
  text(str(round(hs_original)), width*0.2f, width*0.098f);
  text(str(round(score)), width*0.2f, width*0.238f);
  text(str(round(lives)), width*0.2f, width*0.388f);
  textAlign(CENTER, CENTER);
  pushMatrix();
  fill(schemes.get(chosenTheme).tertiary);
  translate(width*0.1f, width*0.1f);
  rotate(PI);
  draw_star(width*0.065f);
  rotate(-PI);
  translate(0, width*0.14f);
  draw_tally(width*0.06f);
  translate(0, width*0.15f);
  rotate(HALF_PI+QUARTER_PI);
  draw_heart(width*0.04f);
  popMatrix();

  if (touchIsEnded) {
    float percentage = 100*independent_shape.area()/dependent_shape.area();
    fill(schemes.get(chosenTheme).alternate);
    textSize(width/8);
    text(round(percentage)+"%", halfWidth, halfHeight);
    textSize(width/18);
    float s = 100 - abs(100-percentage);
    if (s < 89.5f || s > 110.5f) { 
      lives--;
    } else {
      score += s;
      independent_shape.sides = randomInt(2, 6);
      dependent_shape.sides = randomInt(2, 6);
      dependent_shape.radius = random(width*0.3f, width*0.4f);
      dependent_shape.rotation = random(TWO_PI);
      if (score > hs_original) {
        hs_original = score;
        saveHS();
      }
    }
    independent_shape.radius = 0;
    mouseX = halfWidth;
    mouseY = halfHeight;
    delay = millis() + 1500;
  }
}



public void reset_irregular() {
  score = 0;
  lives = 3;
  int n = randomInt(0, 5);
  dependent_shape = new Shape(new PVector(halfWidth, halfHeight), n, random(width*0.3f, width*0.4f), random(TWO_PI), schemes.get(chosenTheme).light, IRREGULAR);
  independent_shape = new Shape(new PVector(halfWidth, halfHeight), n, 0, 0, schemes.get(chosenTheme).main, IRREGULAR);
  independent_shape.setAlpha(220);
  mouseX = halfWidth;
  mouseY = halfHeight;
}


public void irregular() {

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
  textSize(width*0.12f);
  text(str(round(hs_irregular)), width*0.2f, width*0.098f);
  text(str(round(score)), width*0.2f, width*0.238f);
  text(str(round(lives)), width*0.2f, width*0.388f);
  textAlign(CENTER, CENTER);
  pushMatrix();
  fill(schemes.get(chosenTheme).tertiary);
  translate(width*0.1f, width*0.1f);
  rotate(PI);
  draw_star(width*0.065f);
  rotate(-PI);
  translate(0, width*0.14f);
  draw_tally(width*0.06f);
  translate(0, width*0.15f);
  rotate(HALF_PI+QUARTER_PI);
  draw_heart(width*0.04f);
  popMatrix();

  if (touchIsEnded) {
    float percentage = 100*independent_shape.area()/dependent_shape.area();
    fill(schemes.get(chosenTheme).alternate);
    textSize(width/8);
    text(round(percentage)+"%", halfWidth, halfHeight);
    textSize(width/18);
    float s = 100 - abs(100-percentage);
    if (s < 89.5f || s > 110.5f) { 
      lives--;
    } else {
      score += s;
      independent_shape.sides = randomInt(0, 5);
      dependent_shape.sides = randomInt(0, 5);
      dependent_shape.radius = random(width*0.3f, width*0.4f);
      dependent_shape.rotation = random(TWO_PI);
      if (score > hs_irregular) {
        hs_irregular = score;
        saveHS();
      }
    }
    independent_shape.radius = 0;
    mouseX = halfWidth;
    mouseY = halfHeight;
    delay = millis() + 1500;
  }
}





public void reset_sink() {
  score = 0;
  lives = 3;
  int c = randomInt(0, 15);
  if (c < 5) {
    int n = randomInt(2, 6);
    dependent_shape = new Shape(new PVector(halfWidth, halfHeight), n, random(width*0.3f, width*0.4f), random(TWO_PI), schemes.get(chosenTheme).light);
    independent_shape = new Shape(new PVector(halfWidth, halfHeight), n, 0, 0, schemes.get(chosenTheme).main);
  } else if (c < 11) {
    int n = randomInt(0, 5);
    dependent_shape = new Shape(new PVector(halfWidth, halfHeight), n, random(width*0.3f, width*0.4f), random(TWO_PI), schemes.get(chosenTheme).light, IRREGULAR);
    independent_shape = new Shape(new PVector(halfWidth, halfHeight), n, 0, 0, schemes.get(chosenTheme).main, IRREGULAR);
  } else {
    int n = randomInt(0, 4);
    dependent_shape = new Shape(new PVector(halfWidth, halfHeight), n, random(width*0.3f, width*0.4f), random(TWO_PI), schemes.get(chosenTheme).light, MISC);
    independent_shape = new Shape(new PVector(halfWidth, halfHeight), n, 0, 0, schemes.get(chosenTheme).main, MISC);
  }


  independent_shape.setAlpha(220);
  mouseX = halfWidth;
  mouseY = halfHeight;
}


public void sink() {

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
  textSize(width*0.12f);
  text(str(round(hs_irregular)), width*0.2f, width*0.098f);
  text(str(round(score)), width*0.2f, width*0.238f);
  text(str(round(lives)), width*0.2f, width*0.388f);
  textAlign(CENTER, CENTER);
  pushMatrix();
  fill(schemes.get(chosenTheme).tertiary);
  translate(width*0.1f, width*0.1f);
  rotate(PI);
  draw_star(width*0.065f);
  rotate(-PI);
  translate(0, width*0.14f);
  draw_tally(width*0.06f);
  translate(0, width*0.15f);
  rotate(HALF_PI+QUARTER_PI);
  draw_heart(width*0.04f);
  popMatrix();

  if (touchIsEnded) {
    float percentage = 100*independent_shape.area()/dependent_shape.area();
    fill(schemes.get(chosenTheme).alternate);
    textSize(width/8);
    text(round(percentage)+"%", halfWidth, halfHeight);
    textSize(width/18);
    float s = 100 - abs(100-percentage);
    if (s < 89.5f || s > 110.5f) { 
      lives--;
    } else {
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


      dependent_shape.radius = random(width*0.3f, width*0.4f);
      dependent_shape.rotation = random(TWO_PI);
      if (score > hs_sink) {
        hs_sink = score;
        saveHS();
      }
    }
    independent_shape.radius = 0;
    mouseX = halfWidth;
    mouseY = halfHeight;
    delay = millis() + 1500;
  }
}


// These are in RGB because

// dark, neutral, light, main, secondary
ArrayList<Palette> schemes = new ArrayList<Palette>();
//Palette scheme = new Palette(color(51), color(70), color(198, 197, 185), color(98, 146, 158), color(245, 112, 41), color(101, 175, 255));
//Palette scheme = new Palette( color(200), color(133), color(54), color(214, 88, 88), color(97, 189, 94), color(68, 130, 207));


class Palette {
  
  int dark, neutral, light, main, secondary, tertiary, alternate;
  
  Palette(int d, int n, int l, int m, int s, int t, int a) {
    dark = d;
    neutral = n;
    light = l;
    main = m;
    secondary = s;
    tertiary = t;
    alternate = a;
  }
  
}


public void create_palettes() {
  
  schemes.add(new Palette(color(0, 0, 20), color(0, 0, 27), color(55, 7, 78), color(192, 38, 62), color(21, 83, 96), color(211, 60, 100), color(151, 65, 86)));
  schemes.add(new Palette(color(0, 0, 20), color(0, 0, 27), color(55, 7, 78), color(192, 38, 62), color(21, 83, 96), color(211, 60, 100), color(151, 65, 86)));
  schemes.add(new Palette(color(0, 0, 89), color(0, 0, 52), color(0, 0, 21), color(0, 59, 84), color(118, 50, 74), color(213, 67, 81), color(50, 79, 100)));
  
}

final boolean IRREGULAR = true;
final boolean MISC = false;
class Shape {

  PVector position;
  // 2 = circle
  // 0 = SI, 1 =
  int sides;
  float radius, diameter;
  float rotation;
  int colour;
  boolean is_irregular;
  boolean is_misc;


  // CONSTRUCTORS

  Shape() {
  }

  Shape(PVector pos, int sid, float rad, float rot, int col) {
    position = pos;
    sides = sid;
    radius = rad;
    diameter = rad*2;
    rotation = rot*PI/180;
    colour = col;
    is_irregular = false;
    is_misc = false;
  }

  Shape(PVector pos, int sid, float rad) {
    position = pos;
    sides = sid;
    radius = rad;
    diameter = rad*2;
    rotation = 0;
    colour = color(200, 50, 50);
    is_irregular = false;
    is_misc = false;
  }

  Shape(PVector pos, int sid, float rad, float rot, int col, boolean isi) {
    position = pos;
    sides = sid;
    radius = rad;
    diameter = rad*2;
    rotation = rot*PI/180;
    colour = col;
    is_irregular = isi;
    is_misc = !isi;
  }

  Shape(PVector pos, int sid, float rad, boolean isi) {
    position = pos;
    sides = sid;
    radius = rad;
    diameter = rad*2;
    rotation = 0;
    colour = color(200, 50, 50);
    is_irregular = isi;
    is_misc = !isi;
  }


  // METHODS

  public void print_details(String title) {
    println(title);
    println("===============================");
    println("Sides: " + sides);
    println("Radius: " + radius);
    println("Colour: " + red(colour), green(colour), blue(colour));
    println("Rotation: " + rotation);
    println();
  }

  public void setAlpha(int a) {
    colour = (colour & 0xffffff) | (a << 24);
  }

  public void display() {
    if (is_irregular) display_irregular();
    else if (is_misc) display_misc();
    else display_regular();
  }

  public void display_regular() {

    fill(colour);
    noStroke();

    if (sides == 2) {
      ellipse(position.x, position.y, radius, radius);
      return;
    }

    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation);
    beginShape();
    float ang = TWO_PI/sides;
    for (float b = 0; b < TWO_PI; b += ang) {
      float m = -cos(b) * radius;
      float n = sin(b) * radius;
      vertex(n, m);
    }
    endShape(CLOSE);
    popMatrix();
  }


  public void display_irregular() {
    fill(colour);
    noStroke();
    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation);
    switch(sides) {
    case 0:
      rotate(7*PI/6);
      draw_crescent(radius);
      break;
    case 1:
      draw_rhombus(radius);
      break;
    case 2:
      draw_ring(radius, colour);
      break;
    case 3:
      rotate(QUARTER_PI);
      draw_chevron(radius);
      break;
    case 4:
      rotate(QUARTER_PI);
      draw_L(radius);
      break;
    case 5:
      rotate(QUARTER_PI);
      draw_right(radius);
      break;
    default:
      println("Invalid shape");
      noLoop();
    }
    popMatrix();
  }

  public void display_misc() {
    fill(colour);
    noStroke();
    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation);
    switch(sides) {

    case 0:
      rotate(PI/6);
      draw_SI(radius);
      break;
    case 1:
      rotate(PI);
      draw_star(radius);
      break;
    case 2:
      rotate(0.6632f);
      draw_tally(radius);
      break;
    case 3:
      rotate(-QUARTER_PI);
      draw_heart(radius);
      break;
    case 4:
      rotate(0.32175055f);
      draw_cross(radius);
      break;
    default:
      println("Invalid shape");
      noLoop();
    }
    popMatrix();
  }

  public void update_one() {
    if (dist(initX, initY, halfWidth, halfHeight) > 0.9f*dist(0, 0, halfWidth, halfHeight)) {
      radius = 0;
      return;
    }    
    radius = dist(position.x, position.y, mouseX, mouseY);
    diameter = radius*2;
    rotation = get_angle(new PVector(position.x, 0), position, new PVector(mouseX, mouseY));
  }

  public float area() {
    if (is_irregular) return area_irregular();
    else if (is_misc) return area_misc();
    else return area_regular();
  }

  public float area_regular() {
    return sides == 2 ? radius*radius*PI: radius*radius*sides*sin(TWO_PI/sides)*0.5f;
  }

  public float area_irregular() {
    switch(sides) {
    case 0:
      return radius*radius*1.913224654f;
    case 1:
      return radius*radius;
    case 2:
      return radius*radius*0.75f*PI;
    case 3:
      return radius*radius*ROOT2;
    case 4:
      return radius*radius*1.5f;
    case 5:
      return radius*radius;
    default:
      return -1;
    }
  }

  public float area_misc() {
    switch(sides) {
    case 0:
      return radius*radius*(ROOT3*1.08f-0.06f);
      //return radius*radius*(0.398*ROOT3+0.48);
    case 1:
      return radius*radius*1.122569941f;
    case 2:
      return radius*radius*1.352825488f;
    case 3:
      return radius*radius*(2+HALF_PI);
    case 4:
      return radius*radius*2;
    default:
      return -1;
    }
  }
}


public void draw_SI(float rad) {
  float r = rad;
  float d = r*ROOT3*0.1f;
  float t = r*0.5f;
  float h = r*ROOT3*0.5f;

  for (int i = -1; i != 1; i++) {
    beginShape();
    vertex(d, -d);
    vertex(r*0.9f, -d);
    vertex(r, 0);

    vertex(t, h);
    vertex(-t, h);
    vertex(-r*0.7f, d*3);

    vertex(r*0.3f, d*3);
    vertex(r*0.5f, d);
    vertex(d, d);
    endShape(CLOSE);
    d *= i;
    t *= i;
    h *= i;
    r *= i;
  }
}

public void draw_star(float rad) {

  beginShape();
  float R = rad*c25c5;
  for (int i = 0; i < 5; i++) {
    vertex(rad*sin(i*0.4f*PI), rad*cos(i*0.4f*PI));
    vertex(R*sin(i*0.4f*PI+0.2f*PI), R*cos(i*0.4f*PI+0.2f*PI));
  }
  endShape(CLOSE);
}


// https://www.desmos.com/calculator/0fdcppe0sh
public void draw_tally(float rad) {
  float r = rad;
  beginShape();
  for (int i = -1; i != 1; i ++) {
    float a = r*0.6156f;
    float b = -r*0.788f;
    float c = r*0.4186f;
    float d = r*0.2709f;
    float e = r*0.0739f;
    vertex(a, b);
    vertex(c, b);
    vertex(c, -r*0.1052f);
    vertex(d, -r*0.029f);

    vertex(d, b);
    vertex(e, b);
    vertex(e, r*0.0727f);
    vertex(-e, r*0.149f);

    vertex(-e, b);
    vertex(-d, b);
    vertex(-d, r*0.2507f);
    vertex(-c, r*0.3269f);

    vertex(-c, b);
    vertex(-a, b);
    vertex(-a, r*0.4286f);
    vertex(-r*0.7985f, r*0.523f);

    vertex(-r*0.8889f, r*0.3479f);
    vertex(-a, r*0.2069f);
    r *= i;
  }
  endShape(CLOSE);
}


public void draw_heart(float rad) {
  float x = rad*HALF_ROOT2;
  float w = x*2;
  rect(0, 0, w, w);
  arc(-x, 0, x, x, HALF_PI, PI+HALF_PI, PIE);
  arc(0, x, x, x, 0, PI, PIE);
}

public void draw_cross(float rad) {
  float w = rad*ROOT10*0.1f;
  beginShape();
  vertex(-w, 3*w);
  vertex(w, 3*w);
  vertex(w, w);

  vertex(3*w, w);
  vertex(3*w, -w);
  vertex(w, -w);

  vertex(w, -3*w);
  vertex(-w, -3*w);
  vertex(-w, -w);

  vertex(-3*w, -w);
  vertex(-3*w, w);
  vertex(-w, w);
  endShape(CLOSE);
}



public void draw_crescent(float rad) {

  beginShape();
  for (float a = PI/3; a < 5*PI/3; a += 10/rad) {
    vertex(rad*cos(a), rad*sin(a));
  }
  for (float a = 4*PI/3; a > 2*PI/3; a -= 10/rad) {
    vertex(rad*(cos(a)+1), rad*sin(a));
  }
  endShape(CLOSE);
}

public void draw_rhombus(float rad) {
  beginShape();
  vertex(0, rad);
  vertex(0.5f*rad, 0);
  vertex(0, -rad);
  vertex(-0.5f*rad, 0);
  endShape(CLOSE);
}

public void draw_ring(float rad, int col) {
  noFill();
  stroke(col);
  strokeWeight(rad*0.5f);
  ellipse(0, 0, rad*0.75f, rad*0.75f);
}

public void draw_chevron(float rad) {
  beginShape();
  vertex(0, rad);
  vertex(rad*HALF_ROOT2, rad*(1-HALF_ROOT2));
  vertex(rad*HALF_ROOT2, -rad*HALF_ROOT2);
  vertex(0, 0);
  vertex(-rad*HALF_ROOT2, -rad*HALF_ROOT2);
  vertex(-rad*HALF_ROOT2, rad*(1-HALF_ROOT2));
  endShape(CLOSE);
}

public void draw_L(float rad) {
  float x = HALF_ROOT2*rad;
  beginShape();
  vertex(0, x);
  vertex(x,x);
  vertex(x, -x);
  vertex(-x,-x);
  vertex(-x,0);
  vertex(0,0);
  endShape(CLOSE);
}

public void draw_right(float rad) {
  float R = rad*HALF_ROOT2;
  beginShape();
    vertex(R,R);
    vertex(-R, R);
    vertex(-R, -R);
  endShape(CLOSE);
}
  


public int main_menu() {
  menu_shape.update_one();

  float dw = halfWidth*0.16f;
  float dh = dw*ROOT3;
  float dr = dw*2;
  float dl = dr;
  float dt = dw*0.1f;
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
    line(p.x, p.y, p.x+dl*0.5f, p.y-dl*HALF_ROOT3);

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


public int game_menu() {
  menu_shape.update_one();
  float dw = halfWidth*0.16f;
  float dh = dw*ROOT3;
  float dr = dw*2;
  float dl = dr;
  float dt = dw*0.1f;
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
    line(p.x, p.y, p.x+dl*0.5f, p.y-dl*HALF_ROOT3);

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


public void settings_menu() {

  textAlign(CENTER, CENTER);
  textSize(width*0.1f);
  fill(schemes.get(chosenTheme).light);
  text("THEME", halfWidth, height*0.06f);

  // MATCH SYSTEM
  fill(0, 0, 95);
  int temp = (chosenTheme == 0) ? schemes.get(chosenTheme).light : schemes.get(chosenTheme).neutral;
  stroke(temp);
  strokeWeight(width*0.01f);
  rect(width*0.17f, width*0.33f, width*0.2f, width*0.2f);
  fill(0, 0, 15);
  textSize(width*0.04f);
  text("MATCH\nSYSTEM", width*0.17f, width*0.33f);
  if (touchIsEnded && mouseIn(width*0.17f, width*0.33f, width*0.2f, width*0.2f)) {
    chosenTheme = 0;
    saveSettings();
  }


  for (int i = 1; i < 3; i++) {
    int s = (chosenTheme == i) ? schemes.get(chosenTheme).light : schemes.get(chosenTheme).neutral;
    drawWindows(width*(i*0.33f+0.17f), width*0.33f, width*0.2f, schemes.get(i).dark, schemes.get(i).main, schemes.get(i).secondary, schemes.get(i).tertiary, s); 

    if (touchIsEnded && mouseIn(width*(i*0.33f+0.17f), width*0.33f, width*0.2f, width*0.2f)) {
      chosenTheme = i;
      saveSettings();
    }
  }



  textSize(width/18);
}


int latest_mode;
public int death_menu() {

  fill(schemes.get(chosenTheme).light);
  textAlign(LEFT, CENTER);
  textSize(width*0.18f);
  text(str(round(hs_latest)), width*0.38f, width*0.3f);
  text(str(round(score)), width*0.38f, width*0.6f);
  textAlign(CENTER, CENTER);
  noStroke();
  pushMatrix();
  fill(schemes.get(chosenTheme).tertiary);
  translate(width*0.26f, width*0.3f);
  rotate(PI);
  draw_star(width*0.1f);
  rotate(-PI);
  translate(0, width*0.3f);
  draw_tally(width*0.1f);
  popMatrix();




  menu_shape.update_one();
  float dw = halfWidth*0.16f;
  float dh = dw*ROOT3;
  float dr = dw*2;
  float dl = dr;
  float dt = dw*0.1f;
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
    line(p.x, p.y, p.x+dl*0.5f, p.y-dl*HALF_ROOT3);

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


float hs_original = 0;
float hs_irregular = 0;
float hs_sink = 0;

String shs[] = {"0", "0", "0"};
String pathHS = "highScores.txt";

String ss[] = {"0"};
String pathS = "config.txt";

public void saveHS() {
  shs[0] = "ori:"+str(hs_original);
  shs[1] = "irr:"+str(hs_irregular);
  shs[2] = "sin:"+str(hs_sink);
  
  saveStrings(pathHS, shs);
}


public void loadHS() {
  shs = loadStrings(pathHS);
  hs_original = PApplet.parseFloat(split(shs[0], ":")[1]);
  hs_irregular = PApplet.parseFloat(split(shs[1], ":")[1]);
  hs_sink = PApplet.parseFloat(split(shs[2], ":")[1]);
}




public void saveSettings() {
  ss[0] = "col:" + str(chosenTheme);
  
  saveStrings(pathS, ss);
}

public void loadSettings() {
  ss = loadStrings(pathS);
  chosenTheme = PApplet.parseInt(split(ss[0], ":")[1]);
}
//FINDS ANGLE abc

public float get_angle(PVector a, PVector b, PVector c) {

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
public int randomInt(int min, int max) {
  return min+floor(random(1+max-min));
}

public int orientation(PVector a, PVector b, PVector c) {
  float val = (b.y - a.y) * (c.x - b.x) - (b.x - a.x) * (c.y - b.y);
  if (val == 0) return 0;
  return (val > 0)? 1: -1;
}

public boolean mouseIn(float x, float y, float w, float h) {
  return !(mouseX < x-w*0.5f || mouseX > x+w*0.5f || mouseY < y-h*0.5f || mouseY > y+h*0.5f);
}



public void checkTheme() {
  int mode = config.uiMode & Configuration.UI_MODE_NIGHT_MASK;
  if (mode == previousTheme) return;
  previousTheme = mode;
  switch (mode) {
  case Configuration.UI_MODE_NIGHT_YES:
    schemes.set(0, new Palette(color(0, 0, 20), color(0, 0, 27), color(55, 7, 78), color(192, 38, 62), color(21, 83, 96), color(211, 60, 100), color(151, 65, 86)));
    break;
  case Configuration.UI_MODE_NIGHT_NO:
    schemes.set(0, new Palette(color(0, 0, 89), color(0, 0, 52), color(0, 0, 21), color(0, 59, 84), color(118, 50, 74), color(213, 67, 81), color(50, 79, 100)));
    break;
  }
}


public void drawWindows(float x, float y, float w, int a, int b, int c, int d, int s) {
  
  noStroke();
  fill(a);
  rect(x-w*0.25f, y-w*0.25f, w*0.5f, w*0.5f);
  fill(b);
  rect(x+w*0.25f, y-w*0.25f, w*0.5f, w*0.5f);
  fill(c);
  rect(x-w*0.25f, y+w*0.25f, w*0.5f, w*0.5f);
  fill(d);
  rect(x+w*0.25f, y+w*0.25f, w*0.5f, w*0.5f);
  
  stroke(s);
  strokeWeight(width*0.01f);
  line(x-w*0.5f, y-w*0.5f, x+w*0.5f, y-w*0.5f);
  line(x+w*0.5f, y+w*0.5f, x+w*0.5f, y-w*0.5f);
  line(x+w*0.5f, y+w*0.5f, x-w*0.5f, y+w*0.5f);
  line(x-w*0.5f, y-w*0.5f, x-w*0.5f, y+w*0.5f);
  
}
  public void settings() {  fullScreen(); }
}
