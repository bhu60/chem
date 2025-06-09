class main{
int temp;
int originalTemp;
float spd;
float originalSpd;
chemical c1;
chemical c2;
String[] cations;
String[] anions;
boolean onChem1;

void setup(){
  temp = 293;
  originalTemp = 293;
  spd = 30;
  originalSpd = 30;
  cations = new String[]{"Acetate", "Aluminum", "Ammonium", "Barium", "Calcium", "Chromium(I)", "Copper(II)", "Iron(III)", "Hydronium", "Lead(II)", "Lithium", "Magnesium", "Manganese(II)", "Mercury", "Potassium", "Silver", "Sodium", "Strontium", "Zinc"};
  anions = new String[]{"Fluoride", "Chloride", "Bromide", "Iodide", "Sulfate", "Perchlorate", "Chlorate", "Chlorite", "Carbonate", "Bicarbonate", "Phosphate", "Nitrate", "Cyanide"};
  c1 = new chemical(0, 0, "nothing", "nothing");
  c2 = new chemical(0, 0, "nothing", "nothing");
  onChem1 = true;
}

void speedRxn(){
  spd = orignalSpd * (Math.exp(2, originalTemp - temp));
  if(frameCount % spd == 0){
    updateRxn();
  }
}

void draw(){
   for (int i = 0; i < cations.length; i++) {
    float y = 200 + i * 30;
    fill(200);
    rect(50, y, 100, 20);
    fill(0);
    text(acids[i], 100, y + 14);
  }

  for (int i = 0; i < anions.length; i++) {
    float y = 200 + i * 30;
    fill(200);
    rect(650, y, 100, 20);
    fill(0);
    text(bases[i], 700, y + 14);
  }
}

void keyPressed(){
  if(key == CODED){
    if(keyCode == UP)
      temp ++;
    if(keyCode == DOWN)
      temp --;
  }
}

void mousePressed(){
  //if mouse in this range change onChem1 to true or false
  if(onChem1){
      for (int i = 0; i < cations.length; i++) {
        float y = 200 + i * 30;
        //if it is H or NaOH, 
        if (mouseX >= 50 && mouseX <= 150 && mouseY >= y && mouseY <= y + 20) {
          c1.parts[2] = cations[i];
        }
      }
      for (int i = 0; i < anions.length; i++) {
        float y = 200 + i * 30;
        if (mouseX >= 650 && mouseX <= 750 && mouseY >= y && mouseY <= y + 20) {
          c1.parts[3] = anions[i];
        }
      }
  }
  else{
    for (int i = 0; i < cations.length; i++) {
        float y = 200 + i * 30;
        //if it is H or NaOH, 
        if (mouseX >= 50 && mouseX <= 150 && mouseY >= y && mouseY <= y + 20) {
          c1.parts[2] = cations[i];
        }
      }
      for (int i = 0; i < anions.length; i++) {
        float y = 200 + i * 30;
        if (mouseX >= 650 && mouseX <= 750 && mouseY >= y && mouseY <= y + 20) {
          c1.parts[3] = anions[i];
        }
      }
  }
  
}
//do like the first menu is cations then you press done to go to second menuand throughout this entire time there is a reset button
//if it is a cation that is not H+ then automatically move but if it is H+ then you can add as much as you want; it just changes pH
//same for naoh
//should display the chemical as it is being created lkke at the top have chemical1 and chemical2

void resetChem(){
  c1 = new chemical(0, 0, "nothing", "nothing");
  c2 = new chemical(0, 0, "nothing", "nothing");
}

void 
