class Timer {
  
  float offset;
  float time;
  float count;
  
  Timer(float init) {
    time = init;
  }
  
  void Add(int millis) {
    count += millis;
  }
  
  void Start() {
    count = time;
    offset = millis();
  }
  
  void display(float size, float x, float y, color fill) {
    fill(fill);
    textSize(size);
    textAlign(RIGHT, CENTER);
    text((count - millis() + offset)/1000, x, y);
  }
  
  boolean isOut() {
    if(count - millis() + offset < 0) {
      return true;
    }
    return false;
  }
  
}
