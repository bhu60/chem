import java.util.Arrays;
import java.util.ArrayLIst;

private boolean hasStrong;
private String[] acids;
private String[] bases;
private double[] kaArr;
private double[] kbARr;
public double H;
public double vol;
public ArrayList<double[]> group;
private int numObj;

void setup(){
  acids = {"HNO2", "H2SO3", "H3PO4", "H2CO3", "CH3COOH", "HF", "HCN", "HCl", "HNO3", "HBr", "HI", "HClO3", "HClO4", "H2SO4"};
  bases = {"NH3",  "Nicotine", "Pyridine", "LiOH", "NaOH", "KOH", "RbOH", "CaOH", "Ca(OH)2", "Sr(OH)2", "Ba(OH)2"};
  kaArr = {7.2 * (Math.pow(10, -4)), 7.2 * (Math.pow(10, -4)), 1.2 * (Math.pow(10, -2)), 7.5 * (Math.pow(10, -3)), 4.2 * (Math.pow(10, -7)), 1.8 * (Math.pow(10, -5)), 7.1 * (Math.pow(10, -4)), 4.9 * (Math.pow(10, -10)), 100, 100, 100, 100, 100, 100, 200};
  kbArr = {-1 * 1.8 * (Math.pow(10, -5)), -1 * (Math.pow(10, -6)), -1 * 1.8 * (Math.pow(10, -9)), -100, -100, -100, -100, -100, -200, -200, -200};
  vol = 100;
}
// have a slider for amount of acid volume added
void addAcid(String sub, double volume, double conc){
  int i = 0;
  while(!sub.equals(acids[i])){
    i ++;
  }
  double[] curr = new double[3];
  curr[0] = kaArr[i];
  curr[1] = volume;
  curr[2] = conc;
  numObj += (int) conc * vol * 10;
  group.add(curr);
}
  
void addBase(String sub, double volume, double conc){
  int i = 0;
  while(!sub.equals(bases[i])){
    i ++;
  }
  double[] curr = new double[2];
  curr[0] = kbArr[i];
  curr[1] = volume;
  curr[2] = conc;
  numObj -= (int) conc * vol * 10;
  group.add(curr);
}

void boolean isStrong(double[] curr){
  if(Math.abs(curr[1]) >= 100)
    return true;
  return false;
}

void double calculatepH(){
  double[] curr = group.remove(0);
  if(isStrong(curr)){
    hasStrong = true;
    H += curr[2] * curr[1];
  }
  if(hasStrong){
    return -1 * Math.log10(H);
  }
  H += Math.pow(curr[2] * curr[0], 0.5);
  return -1 * (Math.log10(H));
}

void hydrogen(){
  x = (int)(Math.random() * width) - 375;
  y = (int)(Math.random() * height) - 315;
  circle(x, y, 5);
}

void hydroxide(){
  x = (int)(Math.random() * width) - 375;
  y = (int)(Math.random() * height) - 315;
  circle(x, y, 15);
  circle(x + 15, y, 5);
}

void bounce() {
  if (y == 1) {
    if (x < 265) {
      x++;
    } else {
      y = -1;
    }
  } else if (y == -1) {
    if (x > -248) {
      x--;
    } else {
      y = 1;
    }
  }
}

void display(){
  if(numObj > 0){
    for(int i = 0; i < numObj; i ++){
      hydrogen();
    }
  }
  else{
    for(int i = -1 * numObj; i < 0; i ++){
      hydroxide();
    }
  }
}
