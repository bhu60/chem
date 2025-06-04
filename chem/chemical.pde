class chemical{
int pH;
String[] parts = new String[4];

chemical(int numH, int numOH, String subgroupP, String subgroupN){
  pH = 7;
  parts[0] = "" + numH;
  parts[1] = "" + numOH;
  parts[2] = subgroupP;
  parts[3] = subgroupN;
}

public boolean hasHalide(chemical chem){
  if(chem.parts[3].equals("Cl") || chem.parts[3].equals("Br") || parts[3].equals("I"))
    return true;
  return false;
}

public boolean hasAlkali(chemical chem){
  if(chem.parts[2].equals("Na") || chem.parts[2].equals("K"))
    return true;
  return false;
}

public boolean canFormPrecipitate(chemical f, chemical s){
  String fcat = fcat;
  String fan = f.parts[3];
  String scat = scat;
  String san = s.parts[3];
  if(hasAlkali(f) && hasAlkal(s))
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
  return true;
}

public boolean isSolid(chemical c){
  if(hasAlkali(c) || c.parts[3].equals("acetate"))
    return false;
  if(hasHalide(c)){
    if(c.parts[2].equals("Silver") || c.parts[2].equals("Lead(II)") || c.parts[2].equals("Mercury"))
      return true;
    return false;
  }
  if(parseInt(c.parts[1]) != 0){
    if(c.parts[3].equals("Ca") || c.parts[3].equals("Ba") || c.parts[3].equals("Sr"))
      return false;
    return true;
  }
  return false;
}

}
/*
make your own chemicals
*/
