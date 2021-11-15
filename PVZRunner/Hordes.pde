class Hordes{
  ArrayList<Horde> hordes;
  ArrayList<Integer> waitTimes;
  int lastTime;
  boolean isBeginning;
  public Hordes(int[][] ids,int[][] gridYs, int[] waitTimes){
    hordes = new ArrayList<Horde>();
    this.waitTimes = new ArrayList<Integer>();
    settleWaitTimes(waitTimes);
    isBeginning = true;
    for(int i=0; i<ids.length; i++){
      if(gridYs[i].length != 0) hordes.add(new Horde(ids[i],gridYs[i]));
      else hordes.add(new Horde(ids[i]));
    }
  }
  private void settleWaitTimes(int[] waitTimes){
    for(int i=0; i<waitTimes.length; i++){
      this.waitTimes.add( waitTimes[i]);
    }
  }
  public void releaseNextHorde(){
    if(time == lastTime+waitTimes.get(0) || (!isBeginning && enemies.size() == 0)){
      hordes.get(0).addToGame();
      hordes.remove(0);
      waitTimes.remove(0);
      lastTime = time;
      isBeginning = false;
    }
  }
  
  
  
}


class Horde{
  int startTime;
  ArrayList<Enemy> horde;
  ArrayList<Integer> gySelections = new ArrayList<Integer>();
  public Horde(int[] ids, int[] gridYs){
    horde = new ArrayList<Enemy>();
    for(int i=0; i<ids.length; i++){
      horde.add(getEnemy(ids[i],gridYs[i]));
    }
  }
  public Horde(int[] ids){
    horde = new ArrayList<Enemy>();
    initSel();
    for(int i=0; i<ids.length; i++){
      int ind = (int)random(0,gySelections.size());
      int n = gySelections.get(ind);
      gySelections.remove(ind);
      horde.add(getEnemy(ids[i],n));
    }
  }
  private void initSel(){
    for(int i=0;i<theBoard.rows;i++){
      gySelections.add(i);
    }
  }
  public void addToGame(){
    for(int i=0; i<horde.size(); i++){
      enemies.add(horde.get(i));
    }
  }
}
