import controlP5.*;
ControlP5 cp;
int temp;
int originalTemp;
double spd;
double originalSpd;
Chemical c1;
Chemical c2;
String[] cations;
String[] anions;
boolean onChem1;
PImage beaker2;
PFont font2;
float concentration1;
float concentration2;
float volume1;
float volume2;
float totalVolume;
color rectColor;
ArrayList<precipitate> precipitateList = new ArrayList<precipitate>();
ArrayList<bubble> bubbleList = new ArrayList<bubble>();
ArrayList<smoke> smokeList = new ArrayList<smoke>();
boolean chemicalJustAdded = false;

void setup(){
    size(1200, 1000);
  setupChem();
}

void setupChem(){
  cp = new ControlP5(this);
  temp = 25;
  originalTemp = 25;
  spd = 30;
  originalSpd = 30;
  cations = new String[]{"Acetate", "Aluminum", "Ammonium", "Barium", "Calcium", "Cesium", "Chromium(VI)", "Copper(II)", "Iron(III)", "Hydronium", "Lead(II)", "Lithium", "Magnesium", "Manganese(II)", "Mercury", "Potassium", "Silver", "Sodium", "Strontium", "Zinc"};
  anions = new String[]{"Fluoride", "Chloride", "Bromide", "Iodide", "Hydroxide", "Sulfate", "Perchlorate", "Chlorate", "Chlorite", "Carbonate", "Bicarbonate", "Phosphate", "Nitrate", "Cyanide"};
  c1 = new Chemical(0, 0, "", "", 0, 0);
  c2 = new Chemical(0, 0, "", "", 0 , 0);
  onChem1 = true;
  font2 = loadFont("Constantia-36.vlw");
  textFont(font2, 36);
  rectColor = color(181, 225, 255, 220);
  beaker2 = loadImage("photos/chembeaker.jpeg");
  sliderschem();
  totalVolume = 0;
}

void draw(){
  background(255);
  image(beaker2, 237, 140, beaker2.width * 1.3, beaker2.height * 1.3);
  
  fill(0);
  rect(250, 98, 175, 85, 10); //black box for 1
  rect(975, 98, 175, 85, 10); //black box for 2
  textAlign(LEFT);
  textSize(28);
  fill(0);
  text("Chemical 1: " + c1.parts[2] + " + " + c1.parts[3], 100, 70);
  
  textSize(28);
  fill(0);
  text("Chemical 2: " + c2.parts[2] + " + " + c2.parts[3], 690, 70);
  
  fill(0);
  textSize(30);
  text("X: " + mouseX + " Y: " + mouseY, 50, 30);
  
  fill(207, 252, 129);
  rect(450, 99, 138, 80, 10);
  fill(0);
  textSize(20);
  fill(0);

  
  fill(160, 129, 252);
  rect(613, 99, 138, 80, 10);
  
  drawchem();
  
  waterHeight = 875 - totalVolume;
  if(waterHeight <= 254){
    waterHeight = 254;
  }
  fill(rectColor);
  rect(356, waterHeight, 489, 875 - waterHeight);
  
  fill(237, 171, 255);
  rect(1000, 735, 150, 90, 10);
  
  rect(1000, 840, 150, 90, 10);
  fill(0);
  if(onChem1){
    text("Switch, Now 1", 1075, 785);
  }
  else{
    text("Switch, Now 2", 1075, 785);
  }
  text("Reset", 1075, 890);
  text("Add Chem 1", 520, 145);
  text("Add Chem 2", 685, 145);
  textSize(30);
  text("Temperature: " + temp, width / 2, height - 50);
  if(chemicalJustAdded){
    updateRxn();
    chemicalJustAdded = false;
  }
  doRxn();
}

void mouseClicked() {
  if(onChem1){
    for (int i = 0; i < cations.length; i++) {
      float y = 200 + i * 38;
      if (mouseX >= 50 && mouseX <= 200 && mouseY >= y && mouseY <= y + 30) {
        c1.parts[2] = cations[i];
      }
    }
    for (int i = 0; i < anions.length; i++) {
      float y = 200 + i * 38;
      if (mouseX >= 1000 && mouseX <= 1150 && mouseY >= y && mouseY <= y + 30) {
        c1.parts[3] = anions[i];
      }
    }
  }
  else{
    for (int i = 0; i < cations.length; i++) {
      float y = 200 + i * 38;
      if (mouseX >= 50 && mouseX <= 200 && mouseY >= y && mouseY <= y + 30) {
        c2.parts[2] = cations[i];
      }
    }
    for (int i = 0; i < anions.length; i++) {
      float y = 200 + i * 38;
      if (mouseX >= 1000 && mouseX <= 1150 && mouseY >= y && mouseY <= y + 30) {
        c2.parts[3] = anions[i];
      }
    }
  }
  
  if(mouseX >= 450  && mouseX <= 588 && mouseY >= 99 && mouseY <= 179){
    addChem(1);
  }
  
  if(mouseX >= 613  && mouseX <= 613 + 138 && mouseY >= 99 && mouseY <= 179){
    addChem(2);
  }
  resetchem();

}

void resetchem(){
  if(mouseX >= 1000  && mouseX <= 1150 && mouseY >= 735 && mouseY <= 735+90){
    onChem1 = !onChem1;
  }
  if(mouseX >= 1000 && mouseX <= 1150 && mouseY >= 800 && mouseY <= 890){
    temp = 25;
    originalTemp = 25;
    spd = 30;
    originalSpd = 30;
    c1 = new Chemical(0, 0, "", "", 0, 0);
    c2 = new Chemical(0, 0, "", "", 0 , 0);
    onChem1 = true;
    totalVolume = 0;
    rectColor = color(181, 225, 255, 220);
    bubbleList = new ArrayList<bubble>();
    smokeList = new ArrayList<smoke>();
    precipitateList = new ArrayList<precipitate>();
  }
}

void doRxn(){
  for (int i = bubbleList.size() - 1; i >= 0; i--) {
    bubble b = bubbleList.get(i);
    b.move();
    b.floatUp(waterHeight);
    b.display();
    if (b.location.y <= waterHeight + 15) {
      bubbleList.remove(i);
    }
}
  for (int i = precipitateList.size() - 1; i >= 0; i--) {
    precipitate p = precipitateList.get(i);
    p.move();
    p.bounce();
    p.display();
    p.temp = temp;
    p.originalTemp = originalTemp;
  }
  for (int i = smokeList.size() - 1; i >= 0; i--) {
    smoke s = smokeList.get(i);
    s.move();
    s.display();
    if (s.time <= 0) {
      smokeList.remove(i);
    }
  }
}

void drawchem(){
  textAlign(CENTER);
  textSize(20);
   for (int i = 0; i < cations.length; i++) {
    float y = 200 + i * 38;
    fill(255, 164, 150);
    rect(50, y, 150, 30, 10);
    fill(0);
    text(cations[i], 125, y + 19);
  }

  for (int i = 0; i < anions.length; i++) {
    float y = 200 + i * 38;
    fill(150, 170, 255);
    rect(1000, y, 150, 30, 10);
    fill(0);
    text(anions[i], 1075, y + 19);
  }
}

void addChem(int c){
  if(c == 1){
    totalVolume += volume1;
  }
  else{
    totalVolume += volume2;
  }
  chemicalJustAdded = true;
}

void keyPressed(){
  if(key == CODED){
    if(keyCode == UP)
      temp ++;
    if(keyCode == DOWN)
      temp --;
  }
}

//do like the first menu is cations then you press done to go to second menuand throughout this entire time there is a reset button
//if it is a cation that is not H+ then automatically move but if it is H+ then you can add as much as you want; it just changes pH
//same for naoh
//should display the chemical as it is being created lkke at the top have chemical1 and chemical2

void updateRxn(){
  if(c1.canFormPrecipitate(c1, c2) || c1.isSolid(c1) || c1.isSolid(c2)){
    int numObj = (int) min(volume1 * concentration1, volume2 * concentration2);
    for(int a = 0; a < numObj; a ++){
      precipitateList.add(new precipitate(random(360, 841), random(waterHeight, 857), temp, originalTemp));
    }
  }
  if(c1.formBubbles(c1, c2) || c1.itselfBubbles(c1) || c2.itselfBubbles(c2)){
    int numObj = (int) min(volume1 * concentration1, volume2 * concentration2);
    for(int a = 0; a < numObj; a ++){
      bubbleList.add(new bubble(random(360, 841), random(waterHeight, 857), waterHeight));
    }

  }
  if(c1.parts[2].equals("Cesium") || c2.parts[2].equals("Cesium")){
    int numObj = (int) min(volume1 * concentration1, volume2 * concentration2);
    if(numObj > 20)
      numObj = 20;
    for(int a = 0; a < numObj; a ++){
      smokeList.add(new smoke(random(360, 841), random(waterHeight, waterHeight - 80)));
    }
  }
  if (onChem1) {
  rectColor = lerpColor(rectColor, c1.colorChange(c1, c2), 0.1);
  } else {
    rectColor = lerpColor(rectColor, c2.colorChange(c1, c2), 0.1);
    println(c1.parts[2] + " " + c1.parts[3] + " " + c2.parts[2] + " " + c2.parts[3] + " " + c2.colorChange(c1, c2));
  }
}


void sliderschem(){
    Slider concentrationSlider1 = cp.addSlider("concentration1")
     .setPosition(50, 100)
     .setCaptionLabel("Concentration (M)")
     .setColorBackground(color(140, 177, 255))
     .setSize(200, 30)
     .setRange(0.1, 5)
     .setValue(0.1);
concentrationSlider1.getValueLabel()
     .setFont(font2)
     .setColor(color(0))
     .setSize(18);
concentrationSlider1.getCaptionLabel().setFont(font2)
     .setColor(color(255))
     .setSize(15);

  Slider volSlider1 = cp.addSlider("volume1")
     .setPosition(50, 150)
     .setCaptionLabel("Volume (mL)")
     .setSize(200, 30)
     .setRange(10, 50)
     .setValue(10)
     .setColorBackground(color(140, 177, 255));
volSlider1.getCaptionLabel().setFont(font2)
     .setColor(color(255))
     .setSize(15);
volSlider1.getValueLabel()
      .setFont(font2)
     .setColor(color(0))
     .setSize(18);
     
Slider concentrationSlider2 = cp.addSlider("concentration2")
     .setPosition(775, 100)
     .setCaptionLabel("Concentration (M)")
     .setColorBackground(color(255, 166, 254))
     .setSize(200, 30)
     .setRange(0.1, 5)
     .setValue(0.1);
concentrationSlider2.getValueLabel()
     .setFont(font2)
     .setColor(color(0))
     .setSize(18);
concentrationSlider2.getCaptionLabel().setFont(font2)
     .setColor(color(255))
     .setSize(15);

  Slider volSlider2 = cp.addSlider("volume2")
     .setPosition(775, 150)
     .setCaptionLabel("Volume (mL)")
     .setSize(200, 30)
     .setRange(10, 50)
     .setValue(10)
     .setColorBackground(color(255, 166, 254));
volSlider2.getCaptionLabel().setFont(font2)
     .setColor(color(255))
     .setSize(15);
volSlider2.getValueLabel()
      .setFont(font2)
     .setColor(color(0))
     .setSize(18);
}

