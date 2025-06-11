class Chemical{
  
String[] parts = new String[6];

Chemical(int numH, int numOH, String subgroupP, String subgroupN, float concentration, float vol){
  parts[0] = "" + numH;
  parts[1] = "" + numOH;
  parts[2] = subgroupP;
  parts[3] = subgroupN;
  parts[4] = " " + concentration;
  parts[5] = " " + vol;
}

boolean hasHalide(Chemical chem){
  if(chem.parts[3].equals("Fluoride") || chem.parts[3].equals("Chloride") || chem.parts[3].equals("Bromide") || parts[3].equals("Iodide"))
    return true;
  return false;
}

boolean hasAlkali(Chemical chem){
  if(chem.parts[2].equals("Lithium") || chem.parts[2].equals("Sodium") || chem.parts[2].equals("Potassium"))
    return true;
  return false;
}

boolean canFormPrecipitate(Chemical f, Chemical s){
  String fcat = f.parts[2];
  String fan = f.parts[3];
  String scat = f.parts[2];
  String san = s.parts[3];
  if(hasAlkali(f) && hasAlkali(s))
    return false;
  if(fan.equals("Carbonate") || san.equals("Carbonate"))
    return true;
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

boolean isSolid(Chemical c){
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

color colorChange(Chemical chem1, Chemical chem2){
  if(canFormPrecipitate(chem1, chem2)){
    return color(181, 225, 255, 220);
  }
  if(chem1.parts[2].equals("Calcium") || chem2.parts[2].equals("Calcium"))
    return color(255, 255, 255, 100);
  if(chem1.parts[2].equals("Copper(II)") || chem2.parts[2].equals("Copper(II)"))
    return color(48, 83, 255, 100);
  if(chem1.parts[2].equals("Chromium(VI)") || chem2.parts[2].equals("Chromium(VI)"))
    return color(255, 202, 56, 100);
  if(chem1.parts[2].equals("Iron(III)") || chem2.parts[2].equals("Iron(III)"))
    return color(240, 225, 24, 100);
  if(chem1.parts[2].equals("Manganese(II)") || chem2.parts[2].equals("Manganese(II)"))
    return color(255, 181, 240, 100);
  return color(181, 225, 255, 100);
}

boolean formBubbles(Chemical c1, Chemical c2){
  if((c1.parts[2].equals("Hydronium") && c2.parts[3].equals("Carbonate")) || (c2.parts[2].equals("Hydronium") && c1.parts[3].equals("Carbonate")))
    return true;
  if((c1.parts[2].equals("Hydronium") && c2.parts[3].equals("Bicarbonate")) || (c2.parts[2].equals("Hydronium") && c1.parts[3].equals("Bicarbonate")))
    return true;
  if((c1.parts[2].equals("Ammonium") && c2.parts[3].equals("Hydroxide")) || (c2.parts[2].equals("Ammonium") && c1.parts[3].equals("Hydroxide")))
    return true;
  return false;
}

boolean itselfBubbles(Chemical c1){
  if(c1.parts[2].equals("Hydronium") && c1.parts[3].equals("Carbonate"))
    return true;
  if(c1.parts[2].equals("Hydronium") && c1.parts[3].equals("Bicarbonate"))
    return true;
  if(c1.parts[2].equals("Ammonium") && c1.parts[3].equals("Hydroxide"))
    return true;
  return false;
}
}
/*
make your own chemicals
*/
