import android.app.Activity;
import android.content.res.Resources;
import android.content.res.Configuration;
import android.Manifest.*;

Configuration config;

// Shape(PVector pos, int sid, float rad, float rot, color col)
// Shape(PVector pos, int sid, float rad)

// Constants

int halfHeight, halfWidth;
final float ROOT10 = sqrt(10);
final float ROOT3 = sqrt(3);
final float HALF_ROOT3 = sqrt(3)*0.5;
final float ROOT2 = sqrt(2);
final float HALF_ROOT2 = sqrt(2)*0.5;
final float cos2PI5 = cos(0.4*PI);
final float cosPI5 = cos(0.2*PI);
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



void setRatio() { 
  halfWidth = int(width*0.5);
  halfHeight = int(height*0.5);
  mainFont = createFont("font/Montserrat-Regular.ttf", width/18, true);
  boldFont = createFont("font/Montserrat-Bold.ttf", width/18, true);
}

void setup() {
  fullScreen();
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
  try{
    loadHS();
    loadSettings();
  } catch(Exception e) {
     PrintWriter outputHS = createWriter(pathHS); 
     PrintWriter outputS = createWriter(pathS); 
     outputHS.println("ori:0\nirr:0\nsin:0"); 
     outputS.println("col:0");
     outputHS.flush();
     outputS.flush();
     outputHS.close();
     outputS.close();
    loadHS();
    loadSettings();
  }
  // TESTING
  menu_shape = new Shape(new PVector(halfWidth, halfHeight), 0, 100, MISC);
}



void draw() {
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

void touchEnded() {
  if (initY > 0.9*height || initY < 0.1*height) return;
  initX = halfWidth;
  initY = halfHeight;
  touchIsEnded = true;
}

void touchStarted() {
  initX = mouseX;
  initY = mouseY;
}

void onBackPressed() {
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
