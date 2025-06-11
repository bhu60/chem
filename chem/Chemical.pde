class Chemical{
  
String[] parts = new String[4];

Chemical(int numH, int numOH, String subgroupP, String subgroupN){
  parts[0] = "" + numH;
  parts[1] = "" + numOH;
  parts[2] = subgroupP;
  parts[3] = subgroupN;
}

public boolean hasHalide(Chemical chem){
  if(chem.parts[3].equals("Cl") || chem.parts[3].equals("Br") || parts[3].equals("I"))
    return true;
  return false;
}

public boolean hasAlkali(Chemical chem){
  if(chem.parts[2].equals("Na") || chem.parts[2].equals("K"))
    return true;
  return false;
}

public boolean canFormPrecipitate(Chemical f, Chemical s){
  String fcat = f.parts[2];
  String fan = f.parts[3];
  String scat = f.parts[2];
  String san = s.parts[3];
  if(hasAlkali(f) && hasAlkali(s))
  if(hasHalide(f)){
    if(san.equals("Silver") || scat.equals("Lead(II)") || scat.equals("Mercury"))
      return true;
  }
  if(hasHalide(s)){
    if(fcat.equals("Silver") || fcat.equals("Lead(II)") || fcat.equals("Mercury"))
      return true;
  }
  if(fan.equals("Sulfate")){
    if(scat.equals("Silver") || scat.equals("Calcium") || scat.equals("Strontium") || scat.equals("Barium") || scat.equals("Lead"))
      return true;
  }
  if(san.equals("Sulfate")){
    if(fcat.equals("Silver") || fcat.equals("Calcium") || fcat.equals("Strontium") || fcat.equals("Barium") || fcat.equals("Lead"))
      return true;
  }
  return false;
}

public boolean isSolid(Chemical c){
  if(hasAlkali(c) || c.parts[3].equals("acetate"))
    return false;
  if(hasHalide(c)){
    if(c.parts[2].equals("Silver") || c.parts[2].equals("Lead(II)") || c.parts[2].equals("Mercury"))
      return true;
    return false;
  }
  if(parseInt(c.parts[1]) != 0){
    if(c.parts[3].equals("Calcium") || c.parts[3].equals("Barium") || c.parts[3].equals("Sr"))
      return false;
    return true;
  }
  return false;
}

String colorChange(Chemical chem1, Chemical chem2){
  if(canFormPrecipitate(chem1, chem2)){
    return "colorless";
  }
  if(chem1.parts[2].equals("Calcium") || chem2.parts[2].equals("Calcium"))
    return "white";
  if(chem1.parts[2].equals("Copper(II)") || chem2.parts[2].equals("Copper(II)"))
    return "blue";
  if(chem1.parts[2].equals("Chromium(VI)") || chem2.parts[2].equals("Chromium(VI)"))
    return "orange";
  if(chem1.parts[2].equals("Iron(III)") || chem2.parts[2].equals("Iron(III)"))
    return "yellow";
  return "colorless";
}

}
/*
make your own chemicals
*/
