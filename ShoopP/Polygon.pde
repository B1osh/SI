
class Polygon {
  
  int n;
  float rad, rot;
  final PVector pos;
  color col;
  
  
  Polygon(int nsides, float radius, float rotation, final PVector position, color colour) {
    n = nsides;
    rad = radius;
    rot = rotation;
    pos = position;
    col = colour;
  }
  
  
  void display() {
    
    noStroke();
    fill(col);
    float ang = TWO_PI/n;
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(PI);
    rotate(radians(rot));
    
    if(n == 2) {
      ellipse(0, 0, rad*2, rad*2);
    }
    else {
      beginShape();
      for(float b = 0; b < TWO_PI; b += ang) {
        float m = cos(b) * rad;
        float n = sin(b) * rad;
        vertex(n, m);
      }
      endShape(CLOSE);
    }
    
    popMatrix();
    
    noStroke();
    fill(255);
    
  }
  
  
  void drawn() {
    
    rad = dist(pos.x, pos.y, mouseX, mouseY);
    rot = getAngle(new PVector(width/2, 0), new PVector(width/2, height/2), new PVector(mouseX, mouseY));
    if(mouseX < width/2) {
      rot *= -1;
    }
    
  }
  
  
  void randomise(int maxsides) {
    
    n = int(random(2, maxsides + 1));
    rad = random(width/4, width/2.2);
    rot = random(360);
    
  }
    
  
  float area() {
    
    if(n == 2) {
      return PI * rad * rad;
    }else {
      return pow(rad, 2) * sin(TWO_PI/float(n))*float(n)*0.5;
    }
  
  }
  
  
  float peri() {
    
    if(n == 2) {
      return PI * 2 * rad;
    }else {
      return 2 * n * rad * sin(PI / n);
    }
  
  }

}
