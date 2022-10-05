String mode = "home";
String mo = "menu";

void mode() {
  
  if(mode == "home") {
    if(flashWords("Tap to continue", width/2, height - height/6, width/8)) {
      mode = "mainmenu";
    }
  }
  
  if(mode == "mainmenu") {
    if(buttonPressed(width*0.4, height*0.3, width*0.4, width/12, "Play")) {
      mode = "gamemenu";
    }else if(buttonPressed(width*0.6, height*0.4, width*0.4, width/12, "Settings")) {
      //mode = "settings";
    }
  }
  
  if(mode == "gamemenu") {
    
    if(buttonPressed(width*0.4, height*0.1, width*0.4, width/12, "Original")) {
      resetOri();
      mode = "original";
    }else if(buttonPressed(width*0.6, height*0.2, width*0.4, width/12, "Perimeter")) {
      resetPer();
      mode = "perimeter";
    }else if(buttonPressed(width*0.4, height*0.3, width*0.4, width/12, "Gamble")) {
      resetGam();
      mode = "gamble";
    }else if(buttonPressed(width*0.6, height*0.4, width*0.4, width/12, "Multiplier")) {
      resetMul();
      mode = "multiplier";
    }else if(buttonPressed(width*0.4, height*0.5, width*0.4, width/12, "Irregular")) {
      resetIrr();
      mode = "irregular";
    }else if(buttonPressed(width*0.6, height*0.6, width*0.4, width/12, "Timed")) {
      resetTim();
      mode = "timed";
    }else if(buttonPressed(width*0.4, height*0.7, width*0.4, width/12, "Off Centred")) {
      resetOff();
      mode = "offcentre";
    }else if(buttonPressed(width*0.6, height*0.8, width*0.4, width/12, "Hardcore")) {
      resetHar();
      mode = "hardcore";
    }else if(buttonPressed(width*0.4, height*0.9, width*0.4, width/12, "Blind")) {
      resetBli();
      mode = "blind";
    }
    
  }
  
  if(mode == "playagain") {
    playagain(mo);
  }
  
  if(mode == "original") {
    original();
  }
  
  if(mode == "perimeter") {
    perimeter();
  }
  
  if(mode == "gamble") {
    gamble();
  }    
  
  if(mode == "multiplier") {
    multiplier();
  }
  
  if(mode == "irregular") {
    irregular();
  }
  
  if(mode == "timed") {
    timed();
  }
  
  if(mode == "offcentre") {
    offcentre();
  }
  
  if(mode == "hardcore") {
    hardcore();
  }
  
  if(mode == "blind") {
    blind();
  }   
  
}
