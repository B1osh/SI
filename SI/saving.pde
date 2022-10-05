
float hs_original = 0;
float hs_irregular = 0;
float hs_sink = 0;

String shs[] = {"0", "0", "0"};
String pathHS = "highScores.txt";

String ss[] = {"0"};
String pathS = "config.txt";

void saveHS() {
  shs[0] = "ori:"+str(hs_original);
  shs[1] = "irr:"+str(hs_irregular);
  shs[2] = "sin:"+str(hs_sink);
  
  saveStrings(pathHS, shs);
}


void loadHS() {
  shs = loadStrings(pathHS);
  hs_original = float(split(shs[0], ":")[1]);
  hs_irregular = float(split(shs[1], ":")[1]);
  hs_sink = float(split(shs[2], ":")[1]);
}




void saveSettings() {
  ss[0] = "col:" + str(chosenTheme);
  
  saveStrings(pathS, ss);
}

void loadSettings() {
  ss = loadStrings(pathS);
  chosenTheme = int(split(ss[0], ":")[1]);
}
