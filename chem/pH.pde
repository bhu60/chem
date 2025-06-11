import java.util.ArrayList;
import controlP5.*;

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
float waterHeight = (float) vol;
PImage beaker;
PFont font;
ArrayList<hydrogen> hydrogenList = new ArrayList<hydrogen>();
int hydrogenCreated = 0;
ArrayList<hydroxide> hydroxideList = new ArrayList<hydroxide>();
int hydroxideCreated = 0;



void setuppH() {
  size(800, 800);
  cp5 = new ControlP5(this);
  acids = new String[]{"HNO2", "H2SO3", "H3PO4", "H2CO3", "CH3COOH", "HF", "HCN", "HCl", "HNO3", "HBr", "HI", "HClO3", "HClO4", "H2SO4"};
  bases = new String[]{"NH3", "Nicotine", "Pyridine", "LiOH", "NaOH", "KOH", "RbOH", "CaOH", "Ca(OH)2", "Sr(OH)2", "Ba(OH)2"};
  kaArr = new double[]{7.2 * Math.pow(10, -4), 1.2 * Math.pow(10, -2), 7.5 * Math.pow(10, -3), 4.2 * Math.pow(10, -7), 1.8 * Math.pow(10, -5), 7.1 * Math.pow(10, -4), 4.9 * Math.pow(10, -10), 100, 100, 100, 100, 100, 100, 200};
  kbArr = new double[]{-5.6 * Math.pow(10, -10), -1 * Math.pow(10, -8), -5.6 * Math.pow(10, -6), -100, -100, -100, -100, -100, -200, -200, -200};
  vol = 100;
  group = new ArrayList<double[]>();
  H = 0;
  numObj = 0;
  hasStrong = false;
  font = loadFont("Constantia-36.vlw");
  textFont(font, 36);
  sliderpH();
  if (!pHSlidersCreated) sliderpH();
  showPHSliders();
  hideChemSliders();
  beaker = loadImage("photos/pHbeaker.jpeg");
}

void drawpH() {
  background(255);
  image(beaker, 225, 210, beaker.width / 1.5, beaker.height / 1.5);
  textAlign(CENTER);
  textSize(12);
  for (int i = 0; i < acids.length; i++) {
    float y = 200 + i * 37;
    fill(255, 164, 150);
    rect(50, y, 150, 30, 10);
    fill(0);
    text(acids[i], 125, y + 19);
  }

  for (int i = 0; i < bases.length; i++) {
    float y = 200 + i * 37;
    fill(150, 170, 255);
    rect(600, y, 150, 30, 10);
    fill(0);
    text(bases[i], 675, y + 19);
  }
  fill(255);
  rect(10, 10, 150, 30);
  fill(0);
  textSize(30);
  textAlign(CENTER, CENTER);
  textSize(28);
  fill(0);
  text("pH: " + nf(pH, 1, 2), width / 2, height - 100);

  rect(300, 98, 175, 85, 10); //conc and vol black background

  fill(35, 134, 255, 230);
  noStroke();
  waterHeight = (float) vol;
  if (waterHeight >= 332) {
    waterHeight = 332;
  }
  rect(287, 493 + (100 - waterHeight), 250, 5 + (waterHeight - 100));

  rect(550, 610, 250, 100, 10);
  textSize(18);
  fill(0);
  text("Go to Chemical Simulator", 675, 660);
  fill(0, 199, 53);
  rect(770, 920, 100, 50, 10);

  resetButton();
  drawH();
  drawOH();
}

void drawH() {
  for (hydrogen h : hydrogenList) {
    h.move();
    h.bounce(waterHeight);
    h.display();
  }
}

void drawOH() {
  for (hydroxide h : hydroxideList) {
    h.move();
    h.bounce(waterHeight);
    h.display();
  }
}

void resetButton() {
  fill(125, 175, 255);
  rect(600, 100, 150, 50, 10);
  fill(0);
  textSize(16);
  textAlign(CENTER, CENTER);
  text("Reset", 675, 125);
}

void mouseClickedpH() {
  for (int i = 0; i < acids.length; i++) {
    float y = 200 + i * 37;
    if (mouseX >= 50 && mouseX <= 200 && mouseY >= y && mouseY <= y + 30) {
      addAcid(acids[i], volume, concentration);
      pH = (float) calculatepH();
    }
  }
  for (int i = 0; i < bases.length; i++) {
    float y = 200 + i * 37;
    if (mouseX >= 600 && mouseX <= 750 && mouseY >= y && mouseY <= y + 30) {
      addBase(bases[i], volume, concentration);
      pH = (float) calculatepH();
    }
  }
  rect(550, 610, 250, 100, 10);
  if (mouseX >= 550 && mouseX <= 800 && mouseY >= 610 && mouseY <= 710) {
    background(255);
    pHSim = false;
    reactionSim = true;
    surface.setSize(1200, 1000);
    setupChem();
  }
  reset();
}

void addAcid(String sub, double volume, double conc) {
  int i = 0;
  while (i < acids.length && !sub.equals(acids[i])) {
    i++;
  }
  double[] curr = new double[3];
  curr[0] = kaArr[i];
  curr[1] = volume;
  curr[2] = conc;
  vol += volume;
  group.add(curr);
  int originalObj = numObj;
  int newCreated = 0;
  if (isStrong(curr)) {
    newCreated =  (int) (conc * volume * 3);
    numObj += (int) (conc * volume * 3);
  } else {
    newCreated =  (int) (conc * volume);
    numObj += (int) (conc * volume);
  }
  if (hydroxideList.size() > 0) {
    int toRemove = min(hydroxideList.size(), newCreated);
    for (int n = 0; n < toRemove; n++) {
      hydroxideList.remove(0);
      numObj++;
    }
  } else if (pH < 7) {
    numObj += newCreated;
    float maxWaterHeight = max(waterHeight, 150);
    for (int j = 0; j < newCreated; j++) {
      float yMin = 493 + (100 - waterHeight);
      float yMax = 585;
      if (yMin < yMax)
        hydrogenList.add(new hydrogen(random(285, 545), random(yMin, yMax), maxWaterHeight));
    }
  }
}

void addBase(String sub, double volume, double conc) {
  int i = 0;
  while (i < bases.length && !sub.equals(bases[i])) {
    i++;
  }
  double[] curr = new double[3];
  curr[0] = kbArr[i];
  curr[1] = volume;
  curr[2] = conc;
  vol += volume;
  group.add(curr);
  int originalObj = numObj;
  int newCreated = 0;
  if (isStrong(curr)) {
    newCreated =  (int) (conc * volume * 3);
    numObj -= (int) (conc * volume * 3);
  } else {
    newCreated =  (int) (conc * volume);
    numObj -= (int) (conc * volume);
  }
  if (hydrogenList.size() > 0) {
    int toRemove = min(hydrogenList.size(), newCreated);
    for (int n = 0; n < toRemove; n++) {
      hydrogenList.remove(0);
      numObj--;
    }
  } else if (pH > 7) {
    numObj -= newCreated;
    float maxWaterHeight = max(waterHeight, 150);
    for (int j = 0; j < newCreated; j++) {
      float yMin = 493 + (100 - waterHeight);
      float yMax = 585;
      if (yMin < yMax)
        hydroxideList.add(new hydroxide(random(285, 545), random(yMin, yMax), maxWaterHeight));
    }
  }
}

boolean isStrong(double[] curr) {
  return Math.abs(curr[0]) >= 100;
}

double calculatepH() {
  if (group.size() == 0) {
    return 7.0;
  }

  double H = 0;
  double OH = 0;

  for (double[] curr : group) {
    double kaOrKb = curr[0];
    double volume = curr[1] / 1000.0;
    double conc = curr[2];

    if (isStrong(curr)) {
      if (kaOrKb == 200) {
        H += conc * volume / vol;
      } else if (kaOrKb == -200) {
        OH += conc * volume / vol;
      } else if (kaOrKb == -300) {
        OH += 2 * conc * volume / vol;
      } else {
        if (kaOrKb > 0) {
          H += conc * volume / vol;
        } else {
          OH += conc * volume / vol;
        }
      }
    } else {
      double ka = Math.abs(kaOrKb);
      double C = conc * volume / vol;
      double a = 1;
      double b = ka;
      double c = -ka * C;
      double discriminant = b * b - 4 * a * c;

      if (discriminant < 0) {
        continue;
      }

      double x = (-b + Math.sqrt(discriminant)) / (2 * a);
      if (kaOrKb >= 0) {
        H += x;
      } else {
        OH += x;
      }
    }
  }

  double netH = H - OH;
  if (Math.abs(netH) < 1e-12) {
    return 7.0;
  } else if (netH > 0) {
    if (netH < 1e-12) netH = 1e-12;
    return -Math.log10(netH);
  } else {
    double netOH = -netH;
    if (netOH < 1e-12) netOH = 1e-12;
    return 14 + Math.log10(netOH);
  }
}
void reset() {
  if (mouseX >= 600  && mouseX <= 750 && mouseY >= 100 && mouseY <= 150) {
    vol = 100;
    group = new ArrayList<double[]>();
    H = 0;
    numObj = 0;
    hydrogenList = new ArrayList<hydrogen>();
    hydroxideList = new ArrayList<hydroxide>();
    waterHeight = 100;
    hasStrong = false;
    pH = (float) calculatepH();
  }
}
