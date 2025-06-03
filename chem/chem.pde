/*
private int temp;
private int originalTemp;
private float spd;
private float originalSpd;
private chemical c1;
private chemical c2;

void setup(){
  size(1200, 800);
  fill(255);
  temp = 293;
  originalTemp = 293;
  spd = 30;
  originalSpd = 30;
  hood();
  boxes();
}
/*
private void speedRxn(){
  spd = originalSpd * (Math.pow((double) 2, (double) (originalTemp - temp)));
  if(frameCount % spd == 0){
    updateRxn();
  }
}
*/
/*
void keyPressed(){
  if(key == CODED){
    if(keyCode == UP)
      temp ++;
    if(keyCode == DOWN)
      temp --;
  }
}

void mousePressed(){
  //if mouse x and mouse y is in this range; then chemical1's parts gets changed
}
//do like the first menu is cations then you press done to go to second menuand throughout this entire time there is a reset button
//if it is a cation that is not H+ then automatically move but if it is H+ then you can add as much as you want; it just changes pH
//same for naoh
//should display the chemical as it is being created lkke at the top have chemical1 and chemical2

void hood(){
    //quad(0, 800, 125, 625, 1075, 625, 1200, 800);
  fill(255);
  fill(0);

void setup(){
  size(1200, 800);
  hood();
}

void background(){
  fill(0, 800, 100);
}

void draw() {
   background(255);
   fill(0);
>>>>>>> 11053ddc59d576b08999f01d16148f838daa6879
   quad(0, 800, 200, 650, 1000, 650, 1200, 800);
   quad(0, 0, 200, 100, 1000, 100, 1200, 0);
   fill(255);
   quad(200, 650, 1000, 650, 1000, 100, 200, 100);
   fill(0,0,255);
<<<<<<< HEAD
   int y = 230;
   int x = 125;
   int w = 100;
   quad(200 + x, y, 200 + x + w, y, 200+x+w, y + 15, 200 + x, y + 15);
   //quad(200+2 * x+w, y, 200+2 * x+2 * w, 200+2 * x+2 * w, y + 15, 200+2 * x+2 * w, y + 15);
   //quad(200 + 3 * x, y, 250 + 3 * x, y, 250 + 3 * x, y + 14, 200 + 3 * x, y + 14);
   y = 100;
   //quad(100 + x, y, 150 + x, y, 150 + x, y + 14, 100 + x, y + 14);
   //quad(150 + 2 * x, y, 200 + 2 * x, y, 200 + 2 * x, y + 14, 150 + 2 * x, y + 14);
   //quad(200 + 3 * x, y, 250 + 3 * x, y, 250 + 3 * x, y + 14, 200 + 3 * x, y + 14);
   x = 100;
   y = 103;
   //quad(100 + x, y, 150 + x, y, 150 + x, y + 14, 100 + x, y + 14);
   //quad(150 + 2 * x, y, 200 + 2 * x, y, 200 + 2 * x, y + 14, 150 + 2 * x, y + 14);
}

void boxes(){
  fill(0,255,0);
  rect(35, 200, 60, 60, 10);
  rect(105, 200, 60, 60, 10);
  rect(35, 270, 60, 60, 10);
  rect(105, 270, 60, 60, 10);
  rect(35, 340, 60, 60, 10);
  rect(105, 340, 60, 60, 10);
  rect(35, 410, 60, 60, 10);
  rect(105, 410, 60, 60, 10);
  rect(35, 480, 60, 60, 10);
  rect(105, 480, 60, 60, 10);
  rect(35, 550, 60, 60, 10);
  rect(105, 550, 60, 60, 10);
=======
   int y = 550;
   int x = 125;
   quad(200 + x, y, 350 + x, y, 350 + x, y + 14, 200 + x, y + 14);
   quad(300 + 2 * x, y, 400 + 2 * x, y, 400 + 2 * x, y + 14, 350 + 2 * x, y + 14);
   quad(200 + 3 * x, y, 250 + 3 * x, y, 250 + 3 * x, y + 14, 200 + 3 * x, y + 14);
   y = 100;
   quad(100 + x, y, 150 + x, y, 150 + x, y + 14, 100 + x, y + 14);
   quad(150 + 2 * x, y, 200 + 2 * x, y, 200 + 2 * x, y + 14, 150 + 2 * x, y + 14);
   quad(200 + 3 * x, y, 250 + 3 * x, y, 250 + 3 * x, y + 14, 200 + 3 * x, y + 14);
   x = 100;
   y = 103;
   quad(100 + x, y, 150 + x, y, 150 + x, y + 14, 100 + x, y + 14);
   quad(150 + 2 * x, y, 200 + 2 * x, y, 200 + 2 * x, y + 14, 150 + 2 * x, y + 14);
   x = 100;
   y = 103 + 53;
   quad(100 + x, y, 150 + x, y, 150 + x, y + 14, 100 + x, y + 14);
   quad(150 + 2 * x, y, 200 + 2 * x, y, 200 + 2 * x, y, 0, 0);
}
void hood() {
  fill(0);
  quad(0, 800, 125, 625, 1075, 625, 1200, 800);
  fill(255);
}
