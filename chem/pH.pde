import java.util.ArrayList;
import controlP5.*;

ControlP5 cp5;
boolean hasStrong;
String[] acids;
String[] bases;
double[] kaArr;
double[] kbArr;
double H;
double vol;
ArrayList<double[]> group;
int numObj;
float concentration = 0.1;
float volume = 10;
float pH = 7.0;

void setup() {
  size(800, 1200);
  cp5 = new ControlP5(this);
  acids = new String[]{"HNO2", "H2SO3", "H3PO4", "H2CO3", "CH3COOH", "HF", "HCN", "HCl", "HNO3", "HBr", "HI", "HClO3", "HClO4", "H2SO4"};
  bases = new String[]{"NH3", "Nicotine", "Pyridine", "LiOH", "NaOH", "KOH", "RbOH", "CaOH", "Ca(OH)2", "Sr(OH)2", "Ba(OH)2"};
  kaArr = new double[]{7.2 * Math.pow(10, -4), 1.2 * Math.pow(10, -2), 7.5 * Math.pow(10, -3), 4.2 * Math.pow(10, -7), 1.8 * Math.pow(10, -5), 7.1 * Math.pow(10, -4), 4.9 * Math.pow(10, -10), 100, 100, 100, 100, 100, 100, 200};
  kbArr = new double[]{-1 * 1.8 * Math.pow(10, -5), -1 * Math.pow(10, -6), -1 * 1.8 * Math.pow(10, -9), -100, -100, -100, -100, -100, -200, -200, -200};
  vol = 100;
  group = new ArrayList<double[]>();
  H = 0;
  numObj = 0;
  hasStrong = false;

  cp5.addSlider("concentration")
     .setPosition(100, 100)
     .setSize(200, 20)
     .setRange(0.1, 10)
     .setValue(0.1)
     .setCaptionLabel("Concentration (M)");

  cp5.addSlider("volume")
     .setPosition(100, 130)
     .setSize(200, 20)
     .setRange(10, 50)
     .setValue(10)
     .setCaptionLabel("Volume (mL)");
}

void draw() {
  background(255);
  textAlign(CENTER);
  textSize(12);
  for (int i = 0; i < acids.length; i++) {
    float y = 200 + i * 30;
    fill(200);
    rect(50, y, 100, 20);
    fill(0);
    text(acids[i], 100, y + 14);
  }

  for (int i = 0; i < bases.length; i++) {
    float y = 200 + i * 30;
    fill(200);
    rect(650, y, 100, 20);
    fill(0);
    text(bases[i], 700, y + 14);
  }

  textAlign(CENTER, CENTER);
  textSize(28);
  fill(0);
  text("pH: " + nf(pH, 1, 2), width / 2, height / 2);
}

void mouseClicked() {
  for (int i = 0; i < acids.length; i++) {
    float y = 200 + i * 30;
    if (mouseX >= 50 && mouseX <= 150 && mouseY >= y && mouseY <= y + 20) {
      addAcid(acids[i], volume, concentration);
      pH = (float) calculatepH();
    }
  }
  for (int i = 0; i < bases.length; i++) {
    float y = 200 + i * 30;
    if (mouseX >= 650 && mouseX <= 750 && mouseY >= y && mouseY <= y + 20) {
      addBase(bases[i], volume, concentration);
      pH = (float) calculatepH();
    }
  }
}

void addAcid(String sub, double volume, double conc) {
  int i = 0;
  while (i < acids.length && !sub.equals(acids[i])) {
    i++;
  }
  if (i >= acids.length) {
    println("Acid not found: " + sub);
    return;
  }
  double[] curr = new double[3];
  curr[0] = kaArr[i];
  curr[1] = volume;
  curr[2] = conc;
  numObj += (int) (conc * volume * 10);
  group.add(curr);
}

void addBase(String sub, double volume, double conc) {
  int i = 0;
  while (i < bases.length && !sub.equals(bases[i])) {
    i++;
  }
  if (i >= bases.length) {
    println("Base not found: " + sub);
    return;
  }
  double[] curr = new double[3];
  curr[0] = kbArr[i];
  curr[1] = volume;
  curr[2] = conc;
  numObj -= (int) (conc * volume * 10);
  group.add(curr);
}

boolean isStrong(double[] curr) {
  return Math.abs(curr[0]) >= 100;
}

double calculatepH() {
  if (group.size() == 0) {
    return 7;
  }
  double[] curr = group.remove(0);
  if (isStrong(curr)) {
    hasStrong = true;
    if (curr[0] > 0) {
      H += curr[2] * curr[1];
    } else {
      H -= curr[2] * curr[1];
    }
  } else {
    double a = 1;
    double b = Math.abs(curr[0]);
    double c = -Math.abs(curr[0]) * curr[2];
    double discriminant = b * b - 4 * a * c;
    double x = (-b + Math.sqrt(discriminant)) / (2 * a);
    if (curr[0] >= 0) {
      H += x;
    } else {
      H -= x;
    }
  }
  if (H <= 0) {
    double OH = -H;
    return 14 - Math.log10(OH);
  }
  return -Math.log10(H);
}
