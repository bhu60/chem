import controlP5.*;

ControlP5 cp5;
boolean pHSlidersCreated = false;
boolean chemSlidersCreated = false;
boolean pHSim = false;
boolean reactionSim = false;
boolean firstScreen = true;
Slider concentrationSlider;
Slider volSlider;
Slider concentrationSlider1;
Slider concentrationSlider2;
Slider volSlider1;
Slider volSlider2;
PFont font3;

void setup(){
  background(255);
  size(800, 800);
  fill(0, 199, 53);
  rect(100, 300, 250, 250, 20);
  rect(400, 300, 250, 250, 20);
  fill(0);
  font3 = loadFont("Constantia-36.vlw");
  textFont(font3, 24);
  text("pH Simulator", 145, 400);
  text("reaction Simulator", 425, 400);
  if(pHSim)
    setuppH();
  if(reactionSim)
    setupChem();
   cp5 = new ControlP5(this);
}

void mouseClicked(){
  if(!pHSim && !reactionSim){
    if(mouseX >= 100 && mouseX <= 350 && mouseY >= 300 && mouseY <=550){
      firstScreen = false;
      pHSim = true;
      setuppH();
      mouseClickedpH();
    }
    if(mouseX >= 400 && mouseX <= 750 && mouseY >= 300 && mouseY <=550){
      firstScreen = false;
      surface.setSize(1200, 1000);
      reactionSim = true;
      setupChem();
      mouseClickedChem();
    }
  }
  if(pHSim){
    mouseClickedpH();
  }
  if(reactionSim){
    mouseClickedChem();
  }
}


void draw(){
  if(!firstScreen){
    background(255);
  }
  if(pHSim){
    drawpH();
    showPHSliders();
    hideChemSliders();
  }
  if(reactionSim){
    drawChem();
    showChemSliders();
    hidePHSliders();
  }
}

void sliderpH() {
  if (concentrationSlider == null) {
  concentrationSlider = cp5.addSlider("concentration")
    .setPosition(100, 100)
    .setCaptionLabel("Concentration (M)")
    .setColorBackground(color(105, 219, 157))
    .setSize(200, 30)
    .setRange(0.1, 5)
    .setValue(0.1);
  concentrationSlider.getValueLabel().setFont(font3).setColor(color(0)).setSize(18);
  concentrationSlider.getCaptionLabel().setFont(font3).setColor(color(255)).setSize(15);
  volSlider = cp5.addSlider("volume")
    .setPosition(100, 150)
    .setCaptionLabel("Volume (mL)")
    .setSize(200, 30)
    .setRange(10, 50)
    .setValue(10)
    .setColorBackground(color(105, 219, 157));
  volSlider.getCaptionLabel().setFont(font3).setColor(color(255)).setSize(15);
  volSlider.getValueLabel().setFont(font3).setColor(color(0)).setSize(18);
  pHSlidersCreated = true;
  }
}

void sliderchem() {
  if (concentrationSlider1 == null) {
  concentrationSlider1 = cp5.addSlider("concentration1")
    .setPosition(50, 100)
    .setCaptionLabel("Concentration (M)")
    .setColorBackground(color(140, 177, 255))
    .setSize(200, 30)
    .setRange(0.1, 5)
    .setValue(0.1);
  concentrationSlider1.getValueLabel().setFont(font3).setColor(color(0)).setSize(18);
  concentrationSlider1.getCaptionLabel().setFont(font3).setColor(color(255)).setSize(15);
  volSlider1 = cp5.addSlider("volume1")
    .setPosition(50, 150)
    .setCaptionLabel("Volume (mL)")
    .setSize(200, 30)
    .setRange(10, 50)
    .setValue(10)
    .setColorBackground(color(140, 177, 255));
  volSlider1.getCaptionLabel().setFont(font3).setColor(color(255)).setSize(15);
  volSlider1.getValueLabel().setFont(font3).setColor(color(0)).setSize(18);
  concentrationSlider2 = cp5.addSlider("concentration2")
    .setPosition(775, 100)
    .setCaptionLabel("Concentration (M)")
    .setColorBackground(color(255, 166, 254))
    .setSize(200, 30)
    .setRange(0.1, 5)
    .setValue(0.1);
  concentrationSlider2.getValueLabel().setFont(font3).setColor(color(0)).setSize(18);
  concentrationSlider2.getCaptionLabel().setFont(font3).setColor(color(255)).setSize(15);
  volSlider2 = cp5.addSlider("volume2")
    .setPosition(775, 150)
    .setCaptionLabel("Volume (mL)")
    .setSize(200, 30)
    .setRange(10, 50)
    .setValue(10)
    .setColorBackground(color(255, 166, 254));
  volSlider2.getCaptionLabel().setFont(font3).setColor(color(255)).setSize(15);
  volSlider2.getValueLabel().setFont(font3).setColor(color(0)).setSize(18);
  chemSlidersCreated = true;
  }
}

void showPHSliders() {
  concentrationSlider.show();
  volSlider.show();
}

void hidePHSliders() {
  if (concentrationSlider != null) concentrationSlider.hide();
  if (volSlider != null) volSlider.hide();
}

void showChemSliders() {
  concentrationSlider1.show();
  concentrationSlider2.show();
  volSlider1.show();
  volSlider2.show();
}

void hideChemSliders() {
  if (concentrationSlider1 != null) concentrationSlider1.hide();
  if (concentrationSlider2 != null) concentrationSlider2.hide();
  if (volSlider1 != null) volSlider1.hide();
  if (volSlider2 != null) volSlider2.hide();
}
