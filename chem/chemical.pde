/*class chemical{
private int pH;
public String[] parts = new String[4];

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
  if(hasAlkali(f) || f.parts[3].equals("acetate") || hasAlkali(s) || s.parts[3].equals("acetate"))
    return false;
  if(hasHalide(f)){
    if(s.parts[2].equals("Ag") || s.parts[2].equals("Pb") || s.parts[2].equals("Hg2"))
      return true;
  }
  if(hasHalide(s)){
    if(f.parts[2].equals("Ag") || f.parts[2].equals("Pb") || f.parts[2].equals("Hg2"))
      return true;
  }
  
  return true;
}

public boolean isSolid(chemical c){
  if(hasAlkali(c) || c.parts[3].equals("acetate"))
    return false;
  if(hasHalide(c)){
    if(c.parts[2].equals("Ag") || c.parts[2].equals("Pb") || c.parts[2].equals("Hg2"))
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

/*
make your own chemicals
*/
