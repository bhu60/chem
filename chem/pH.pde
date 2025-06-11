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
float waterHeight = (float) vol;
PImage beaker;
PFont font;
ArrayList<hydrogen> hydrogenList = new ArrayList<hydrogen>();
int hydrogenCreated = 0;
ArrayList<hydroxide> hydroxideList = new ArrayList<hydroxide>();
int hydroxideCreated = 0;

void setup(){
    size(800, 800);
  setuppH();
}

void setuppH() {

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
  sliders();
     
  beaker = loadImage("photos/pHbeaker.jpeg");
}

void sliders(){
    Slider concentrationSlider = cp5.addSlider("concentration")
     .setPosition(100, 100)
     .setCaptionLabel("Concentration (M)")
     .setColorBackground(color(105, 219, 157))
     .setSize(200, 30)
     .setRange(0.1, 5)
     .setValue(0.1);
concentrationSlider.getValueLabel()
     .setFont(font)
     .setColor(color(0))
     .setSize(18);
concentrationSlider.getCaptionLabel().setFont(font)
     .setColor(color(255))
     .setSize(15);

  Slider volSlider = cp5.addSlider("volume")
     .setPosition(100, 150)
     .setCaptionLabel("Volume (mL)")
     .setSize(200, 30)
     .setRange(10, 50)
     .setValue(10)
     .setColorBackground(color(105, 219, 157));
volSlider.getCaptionLabel().setFont(font)
     .setColor(color(255))
     .setSize(15);

volSlider.getValueLabel()
      .setFont(font)
     .setColor(color(0))
     .setSize(18);
}

void draw() {
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
  text("X: " + mouseX + " Y: " + mouseY + " " + numObj, 50, 30);
  textAlign(CENTER, CENTER);
  textSize(28);
  fill(0);
  text("pH: " + nf(pH, 1, 2), width / 2, height - 100);
  
  rect(300, 98, 175, 85, 10); //conc and vol black background
  
  fill(35, 134, 255, 230);
  noStroke();
  waterHeight = (float) vol;
  if(waterHeight >= 332){
    waterHeight = 332;
  }
  rect(287, 493 + (100 - waterHeight), 250, 5 + (waterHeight - 100));
  resetButton();
  
  drawH();
  drawOH();
}

void drawH(){
  for(hydrogen h: hydrogenList){
    h.move();
    h.bounce(waterHeight);
    h.display();
  }
}

void drawOH(){
  for(hydroxide h: hydroxideList){
    h.move();
    h.bounce(waterHeight);
    h.display();
  }
}

void resetButton(){
  fill(125, 175, 255);
  rect(600, 100, 150, 50, 10);
  fill(0);
  textSize(16);
  textAlign(CENTER, CENTER);
  text("Reset", 675, 125);
}

void mouseClicked() {
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
  if(isStrong(curr)){
    newCreated =  (int) (conc * volume * 3);
    numObj += (int) (conc * volume * 3);
  }
  else{
    newCreated =  (int) (conc * volume);
    numObj += (int) (conc * volume);
  }
  if (hydroxideList.size() > 0) {
    int toRemove = min(hydroxideList.size(), newCreated);
    for (int n = 0; n < toRemove; n++) {
      hydroxideList.remove(0);
      numObj++;
    }
  } else {
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
  if(isStrong(curr)){
    newCreated =  (int) (conc * volume * 3);
    numObj -= (int) (conc * volume * 3);
  }
  else{
    newCreated =  (int) (conc * volume);
    numObj -= (int) (conc * volume);
  }
  if (hydrogenList.size() > 0) {
    int toRemove = min(hydrogenList.size(), newCreated);
    for (int n = 0; n < toRemove; n++) {
      hydrogenList.remove(0);
      numObj--;
    }
  } else {
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
    return 7;
  }
  double[] curr = group.remove(0);
  if (isStrong(curr)) {
    hasStrong = true;
    if(Math.abs(curr[0]) == 200){
      if (curr[0] > 0) {
        H += 2 * curr[2] * curr[1] / 1000;
      } else {
        H -= 2 * curr[2] * curr[1] / 1000;
      }
    }
    else{
      if (curr[0] > 0) {
        H += curr[2] * curr[1] / 1000;
      } else {
        H -= curr[2] * curr[1] / 1000;
      }
    }
  } else {
    double ka = Math.abs(curr[0]);
    double C = curr[2] * curr[1] / vol;
    double a = 1;
    double b = ka;
    double c = -ka * C;
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
    if (OH <= Math.pow(10, -12))
      return 7.00;
    return 14 + Math.log10(OH);
  }
  return -Math.log10(H);
}
void reset(){
  if(mouseX >= 600  && mouseX <= 750 && mouseY >= 100 && mouseY <= 150){
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
//4.3.2
