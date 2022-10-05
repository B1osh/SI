//FINDS ANGLE abc

float getAngle(PVector a, PVector b, PVector c) {
  
  float angle = degrees(PVector.angleBetween(a.sub(b), c.sub(b)));
  a.add(b);
  c.add(b);
  if(angle > 180) {
    angle = 360 - angle;
  }
  
  return angle;
  
}
