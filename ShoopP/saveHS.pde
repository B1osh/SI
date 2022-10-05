
void saveHS() {
  shs[0] = "original:" + str(highscoreOri);
  shs[1] = "perimeter:" + str(highscorePer);
  shs[2] = "gamble:" + str(highscoreGam);
  shs[3] = "multiplier:" + str(highscoreMul);
  shs[4] = "irregular:" + str(highscoreIrr);
  shs[5] = "timed:" + str(highscoreTim);
  shs[6] = "offcentred:" + str(highscoreOff);
  shs[7] = "hardcore:" + str(highscoreHar);
  shs[8] = "blind:" + str(highscoreBli);
  saveStrings(path, shs);
}
