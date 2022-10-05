//Polygon(int nsides, float radius, float rotation, PVector position, color colour)
//Ishapes(String type, float radius, float rotation, PVector position, color colour)

Polygon drawnPolygon;
Polygon randomPolygon;
Ishapes drawnI;
Ishapes randomI;
boolean touchIsEnded;
String[] shs = {"o:0", "p:0", "g:0", "m:0", "i:0", "t:0", "o:0", "h:0", "b:0"};
String path = "highScores.txt";

void setup() {

  size(displayWidth, displayHeight);
  surface.setSize(int(height * 0.4), int(height * 0.8));
  drawnPolygon = new Polygon(3, 50, 0, new PVector(width/2, height/2), color(25, 165, 250, 200));
  randomPolygon = new Polygon(3, 50, 0, new PVector(width/2, height/2), color(255));
  drawnI = new Ishapes("STAR", 100, 0, new PVector(width/2, height/2), color(25, 165, 250, 200));
  randomI = new Ishapes("CRESCENT", 100, 0, new PVector(width/2, height/2), color(255));
  timed = new Timer(10000);
  halfsecond = new Timer(500);
  second = new Timer(1000);
  noStroke();
  PImage icon = loadImage("ShoopLogo.png");
  surface.setIcon(icon);


  shs = loadStrings(path);
  highscoreOri = float(split(shs[0], ":")[1]);
  highscorePer = float(split(shs[1], ":")[1]);
  highscoreGam = float(split(shs[2], ":")[1]);
  highscoreMul = float(split(shs[3], ":")[1]);
  highscoreIrr = float(split(shs[4], ":")[1]);
  highscoreTim = float(split(shs[5], ":")[1]);
  highscoreOff = float(split(shs[6], ":")[1]);
  highscoreHar = float(split(shs[7], ":")[1]);
  highscoreBli = float(split(shs[8], ":")[1]);

}


void draw() {

  background(0);
  saveHS();
  mode();
  touchIsEnded = false;
}

void mouseClicked() {
  touchIsEnded = true;
}
