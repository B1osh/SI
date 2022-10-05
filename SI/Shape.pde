
final boolean IRREGULAR = true;
final boolean MISC = false;
class Shape {

  PVector position;
  // 2 = circle
  // 0 = SI, 1 =
  int sides;
  float radius, diameter;
  float rotation;
  color colour;
  boolean is_irregular;
  boolean is_misc;


  // CONSTRUCTORS

  Shape() {
  }

  Shape(PVector pos, int sid, float rad, float rot, color col) {
    position = pos;
    sides = sid;
    radius = rad;
    diameter = rad*2;
    rotation = rot*PI/180;
    colour = col;
    is_irregular = false;
    is_misc = false;
  }

  Shape(PVector pos, int sid, float rad) {
    position = pos;
    sides = sid;
    radius = rad;
    diameter = rad*2;
    rotation = 0;
    colour = color(200, 50, 50);
    is_irregular = false;
    is_misc = false;
  }

  Shape(PVector pos, int sid, float rad, float rot, color col, boolean isi) {
    position = pos;
    sides = sid;
    radius = rad;
    diameter = rad*2;
    rotation = rot*PI/180;
    colour = col;
    is_irregular = isi;
    is_misc = !isi;
  }

  Shape(PVector pos, int sid, float rad, boolean isi) {
    position = pos;
    sides = sid;
    radius = rad;
    diameter = rad*2;
    rotation = 0;
    colour = color(200, 50, 50);
    is_irregular = isi;
    is_misc = !isi;
  }


  // METHODS

  void print_details(String title) {
    println(title);
    println("===============================");
    println("Sides: " + sides);
    println("Radius: " + radius);
    println("Colour: " + red(colour), green(colour), blue(colour));
    println("Rotation: " + rotation);
    println();
  }

  void setAlpha(int a) {
    colour = (colour & 0xffffff) | (a << 24);
  }

  void display() {
    if (is_irregular) display_irregular();
    else if (is_misc) display_misc();
    else display_regular();
  }

  void display_regular() {

    fill(colour);
    noStroke();

    if (sides == 2) {
      ellipse(position.x, position.y, radius, radius);
      return;
    }

    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation);
    beginShape();
    float ang = TWO_PI/sides;
    for (float b = 0; b < TWO_PI; b += ang) {
      float m = -cos(b) * radius;
      float n = sin(b) * radius;
      vertex(n, m);
    }
    endShape(CLOSE);
    popMatrix();
  }


  void display_irregular() {
    fill(colour);
    noStroke();
    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation);
    switch(sides) {
    case 0:
      rotate(7*PI/6);
      draw_crescent(radius);
      break;
    case 1:
      draw_rhombus(radius);
      break;
    case 2:
      draw_ring(radius, colour);
      break;
    case 3:
      rotate(QUARTER_PI);
      draw_chevron(radius);
      break;
    case 4:
      rotate(QUARTER_PI);
      draw_L(radius);
      break;
    case 5:
      rotate(QUARTER_PI);
      draw_right(radius);
      break;
    default:
      println("Invalid shape");
      noLoop();
    }
    popMatrix();
  }

  void display_misc() {
    fill(colour);
    noStroke();
    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation);
    switch(sides) {

    case 0:
      rotate(PI/6);
      draw_SI(radius);
      break;
    case 1:
      rotate(PI);
      draw_star(radius);
      break;
    case 2:
      rotate(0.6632);
      draw_tally(radius);
      break;
    case 3:
      rotate(-QUARTER_PI);
      draw_heart(radius);
      break;
    case 4:
      rotate(0.32175055);
      draw_cross(radius);
      break;
    default:
      println("Invalid shape");
      noLoop();
    }
    popMatrix();
  }

  void update_one() {
    if (initY > 0.9*height || initY < 0.1*height) {
      radius = 0;
      return;
    }    
    radius = dist(position.x, position.y, mouseX, mouseY);
    diameter = radius*2;
    rotation = get_angle(new PVector(position.x, 0), position, new PVector(mouseX, mouseY));
  }

  float area() {
    if (is_irregular) return area_irregular();
    else if (is_misc) return area_misc();
    else return area_regular();
  }

  float area_regular() {
    return sides == 2 ? radius*radius*PI: radius*radius*sides*sin(TWO_PI/sides)*0.5;
  }

  float area_irregular() {
    switch(sides) {
    case 0:
      return radius*radius*1.913224654;
    case 1:
      return radius*radius;
    case 2:
      return radius*radius*0.75*PI;
    case 3:
      return radius*radius*ROOT2;
    case 4:
      return radius*radius*1.5;
    case 5:
      return radius*radius;
    default:
      return -1;
    }
  }

  float area_misc() {
    switch(sides) {
    case 0:
      return radius*radius*1.71597;
      //return radius*radius*(ROOT3*1.08-0.06);
      //return radius*radius*(0.398*ROOT3+0.48);
    case 1:
      return radius*radius*1.122569941;
    case 2:
      return radius*radius*1.352825488;
    case 3:
      return radius*radius*(2+HALF_PI);
    case 4:
      return radius*radius*2;
    default:
      return -1;
    }
  }
}
