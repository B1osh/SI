


class Ishapes {

  String typ;
  float rad, rot;
  PVector pos;
  color col;

  Ishapes(String type, float radius, float rotation, PVector position, color colour) {
    typ = type;
    rad = radius;
    rot = rotation;
    pos = position;
    col = colour;
  }


  void display() {

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(radians(rot));
    fill(col);


    if (typ == "STAR") {

      rotate(PI);
      beginShape();
      for (float b = 0; b < 5; b ++) {
        float m = cos(b*2*TWO_PI/5) * rad;
        float n = sin(b*2*TWO_PI/5) * rad;
        vertex(n, m);
      }
      endShape(CLOSE);
    }

    if (typ == "CRESCENT") {

      rotate(-HALF_PI);
      beginShape();
      for (float i = 0; i < TWO_PI; i += 1 / rad) {
        vertex(cos(i) * rad, sin(i) * rad);
      }
      for (float i = 0; i > -TWO_PI; i -= 1 / rad) {
        vertex(cos(i) * (3*rad/4) + (rad/4), sin(i) * (3*rad/4));
      }
      endShape(CLOSE);
    }

    if (typ == "CROSS") {

      float y = rad * sqrt(3.6);
      rotate(atan(y/(3*y)));
      beginShape();
      vertex(y/2, y/6);
      vertex(y/6, y/6);
      vertex(y/6, y/2);

      vertex(-y/6, y/2);
      vertex(-y/6, y/6);
      vertex(-y/2, y/6);

      vertex(-y/2, -y/6);
      vertex(-y/6, -y/6);
      vertex(-y/6, -y/2);

      vertex(y/6, -y/2);
      vertex(y/6, -y/6);
      vertex(y/2, -y/6);
      endShape(CLOSE);
    }

    if (typ == "SEMI") {

      arc(0, 0, rad*2, rad*2, -HALF_PI, HALF_PI);
    }

    if (typ == "RHOMBUS") {

      beginShape();
      vertex(0, -rad);
      vertex(rad / sqrt(3), 0);
      vertex(0, rad);
      vertex(-rad / sqrt(3), 0);
      endShape(CLOSE);
    }

    if (typ == "HEART") {

      float offs;
      rotate(PI);
      if (alpha(col) == 255) {
        offs = 1;
      } else {
        offs = 0;
      }
      arc(rad/2-offs, -rad/2+offs, rad*sqrt(2), rad*sqrt(2), -PI*0.75, HALF_PI/2);
      arc(-rad/2+offs, -rad/2+offs, rad*sqrt(2), rad*sqrt(2), -PI*1.25, -HALF_PI/2);
      beginShape();
      vertex(0, -rad);
      vertex(rad, 0);
      vertex(0, rad);
      vertex(-rad, 0);
      endShape(CLOSE);
    }



    popMatrix();
  }


  void drawn() {

    rad = dist(pos.x, pos.y, mouseX, mouseY);
    rot = getAngle(new PVector(width/2, 0), new PVector(width/2, height/2), new PVector(mouseX, mouseY));
    if (mouseX < width/2) {
      rot *= -1;
    }
  }


  void randomise() {


    rad = random(width/4, width/2.2);
    rot = random(360);
    int ran = floor(random(0, 6));
    if (ran == 0) {
      typ = "STAR";
    } else if (ran == 1) {
      typ = "CRESCENT";
    } else if (ran == 2) {
      typ = "CROSS";
    } else if (ran == 3) {
      typ = "SEMI";
    } else if (ran == 4) {
      typ = "RHOMBUS";
    } else if (ran == 5) {
      typ = "HEART";
      rad *= 0.8;
    }
  }


  float area() {

    if (typ == "STAR") {
      return rad*rad*(1-cos(TWO_PI/5))*sqrt(2*sqrt(5));
    } else if (typ == "CRESCENT") {
      return PI*rad*rad - PI*(0.75*rad)*(0.75*rad);
    } else if (typ == "CROSS") {
      return rad*rad*2;
    } else if (typ == "SEMI") {
      return 0.5*PI*rad*rad;
    } else if (typ == "RHOMBUS") {
      return (2*rad*rad) / sqrt(3);
    } else if (typ == "HEART") {
      return 2*rad*rad + PI*rad*rad*0.5;
    } else {
      return 1;
    }
  }
}
