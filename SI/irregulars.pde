
void draw_SI(float rad) {
  float r = rad;
  float d = r*ROOT3*0.1;
  float t = r*0.5;
  float h = r*ROOT3*0.5;

  for (int i = -1; i != 1; i++) {
    beginShape();
    vertex(d, -d);
    vertex(r*0.9, -d);
    vertex(r, 0);

    vertex(t, h);
    vertex(-t, h);
    vertex(-r*0.7, d*3);

    vertex(r*0.3, d*3);
    vertex(r*0.5, d);
    vertex(d, d);
    endShape(CLOSE);
    d *= i;
    t *= i;
    h *= i;
    r *= i;
  }
}

void draw_star(float rad) {

  beginShape();
  float R = rad*c25c5;
  for (int i = 0; i < 5; i++) {
    vertex(rad*sin(i*0.4*PI), rad*cos(i*0.4*PI));
    vertex(R*sin(i*0.4*PI+0.2*PI), R*cos(i*0.4*PI+0.2*PI));
  }
  endShape(CLOSE);
}


// https://www.desmos.com/calculator/0fdcppe0sh
void draw_tally(float rad) {
  float r = rad;
  beginShape();
  for (int i = -1; i != 1; i ++) {
    float a = r*0.6156;
    float b = -r*0.788;
    float c = r*0.4186;
    float d = r*0.2709;
    float e = r*0.0739;
    vertex(a, b);
    vertex(c, b);
    vertex(c, -r*0.1052);
    vertex(d, -r*0.029);

    vertex(d, b);
    vertex(e, b);
    vertex(e, r*0.0727);
    vertex(-e, r*0.149);

    vertex(-e, b);
    vertex(-d, b);
    vertex(-d, r*0.2507);
    vertex(-c, r*0.3269);

    vertex(-c, b);
    vertex(-a, b);
    vertex(-a, r*0.4286);
    vertex(-r*0.7985, r*0.523);

    vertex(-r*0.8889, r*0.3479);
    vertex(-a, r*0.2069);
    r *= i;
  }
  endShape(CLOSE);
}


void draw_heart(float rad) {
  float x = rad*HALF_ROOT2;
  float w = x*2;
  rect(0, 0, w, w);
  arc(-x, 0, x, x, HALF_PI, PI+HALF_PI, PIE);
  arc(0, x, x, x, 0, PI, PIE);
}

void draw_cross(float rad) {
  float w = rad*ROOT10*0.1;
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



void draw_crescent(float rad) {

  beginShape();
  for (float a = PI/3; a < 5*PI/3; a += 10/rad) {
    vertex(rad*cos(a), rad*sin(a));
  }
  for (float a = 4*PI/3; a > 2*PI/3; a -= 10/rad) {
    vertex(rad*(cos(a)+1), rad*sin(a));
  }
  endShape(CLOSE);
}

void draw_rhombus(float rad) {
  beginShape();
  vertex(0, rad);
  vertex(0.5*rad, 0);
  vertex(0, -rad);
  vertex(-0.5*rad, 0);
  endShape(CLOSE);
}

void draw_ring(float rad, color col) {
  noFill();
  stroke(col);
  strokeWeight(rad*0.5);
  ellipse(0, 0, rad*0.75, rad*0.75);
}

void draw_chevron(float rad) {
  beginShape();
  vertex(0, rad);
  vertex(rad*HALF_ROOT2, rad*(1-HALF_ROOT2));
  vertex(rad*HALF_ROOT2, -rad*HALF_ROOT2);
  vertex(0, 0);
  vertex(-rad*HALF_ROOT2, -rad*HALF_ROOT2);
  vertex(-rad*HALF_ROOT2, rad*(1-HALF_ROOT2));
  endShape(CLOSE);
}

void draw_L(float rad) {
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

void draw_right(float rad) {
  float R = rad*HALF_ROOT2;
  beginShape();
    vertex(R,R);
    vertex(-R, R);
    vertex(-R, -R);
  endShape(CLOSE);
}
  
