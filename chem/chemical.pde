private int pH;
private String[] parts = new String[4];

public chemical(int numH, int numOH, String subgroupP, String subgroupN){
  pH = 7;
  parts[0] = "" + numH;
  parts[1] = "" + numOH;
  parts[2] = subgroupP;
  parts[3] = subgroupN;
}

public boolean canFormPrecipitate(chemical f, chemical s){
  if(f.parts[2].equals("Na") || f.parts[3].equals("acetate"))
    return false;
}
