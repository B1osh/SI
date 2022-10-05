
// These are in RGB because

// dark, neutral, light, main, secondary
ArrayList<Palette> schemes = new ArrayList<Palette>();
//Palette scheme = new Palette(color(51), color(70), color(198, 197, 185), color(98, 146, 158), color(245, 112, 41), color(101, 175, 255));
//Palette scheme = new Palette( color(200), color(133), color(54), color(214, 88, 88), color(97, 189, 94), color(68, 130, 207));


class Palette {

  color dark, neutral, light, main, secondary, tertiary, alternate, fail;

  Palette(color d, color n, color l, color m, color s, color t, color a, color f) {
    dark = d;
    neutral = n;
    light = l;
    main = m;
    secondary = s;
    tertiary = t;
    alternate = a;
    fail = f;
  }
}


void create_palettes() {

  schemes.add(new Palette(color(0, 0, 20), color(0, 0, 27), color(55, 7, 78), color(192, 38, 62), color(21, 83, 96), color(211, 60, 100), color(151, 65, 86), color(1, 59, 94)));
  schemes.add(new Palette(color(0, 0, 20), color(0, 0, 27), color(55, 7, 78), color(192, 38, 62), color(21, 83, 96), color(211, 60, 100), color(151, 65, 86), color(1, 59, 94)));
  schemes.add(new Palette(color(0, 0, 89), color(0, 0, 52), color(0, 0, 21), color(0, 59, 84), color(118, 50, 74), color(213, 67, 81), color(50, 79, 100), color(30, 93, 100)));
}
