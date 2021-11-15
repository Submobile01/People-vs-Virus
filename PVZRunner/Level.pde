class Level{
  Hordes hordes;
  int unit,level;
  public Level(int unit, int level){
    this.unit = unit;
    this.level = level;
    loadHordes();
  }
  public void startLevel(){
    resetVars();
    screenType = 2;
    theHordes = hordes;
  }
  private void resetVars(){
    time = 0;
    pausing = false;
    sun = 50;
    theBoard.initializeStuff();
    selBoxes.initialize();
    loadHordes();
  }
  private void loadHordes(){
    if(unit == 0){
      if(level == 0){
        hordes = new Hordes( new int[][]{{1,1},{1},{1},{1,1,1,1},{1,1,1,1}},
                                new int[][]{{0,1},{1},{3},{},{}},
                                new int[]{1000,1000,600,1000,100} );
      }
    }
  }
}
