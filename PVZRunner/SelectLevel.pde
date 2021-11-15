class SelectLevel{
  int rows = 5;
  int columns = 11;
  int topLeftX = 140;
  int topLeftY = 240;
  int sideL = 100;
  int[] selectedLevel;
  Level[][] levels;
  public SelectLevel(){
    selectedLevel = new int[]{-1,-1};
  }
  public void drawSelectLevelScreen(){
    background(255);
    for(int i=0; i<rows; i++){
      for(int j=0; j<columns; j++){
        rectMode(CENTER);
        pushMatrix();
        translate(topLeftX+(int)(j+0.5)*sideL,topLeftY+(int)(i+0.5)*sideL);
        fill(255);
        rect(0,0,sideL,sideL);
        fill(0);
        textAlign(CENTER,CENTER);
        textSize(30);
        text(i+"-"+j,0,0);
        popMatrix();
      }
    }
    if(selectedLevel[0]>=0){
      rectMode(CENTER);
      pushMatrix();
      translate(topLeftX+(int)(selectedLevel[0]+0.5)*sideL,topLeftY+(int)(selectedLevel[1]+0.5)*sideL);
      drawSelected(sideL,sideL);
      popMatrix();
    }
  }
  
  
  
  public void select(){
    int[] selected = detectSelected();
    if(selected[0] != -1){
      if(selected[0] == selectedLevel[0] && selected[1] == selectedLevel[1]){
        theLevel = new Level(selected[0],selected[1]);
        theLevel.startLevel();
      }
      selectedLevel = selected;
    }
    printArray(selectedLevel);
  }
  
  
  private int[] detectSelected(){
    int[] point = new int[2];
    point[0] = (mouseX-topLeftX+(int)(sideL*0.5))/sideL;
    point[1] = (mouseY-topLeftY+(int)(sideL*0.5))/sideL;
    if(point[0]>=0 && point[0]<columns && point[1]>=0 && point[1]<rows) return point;
    return new int[]{-1,-1};
  }
  
  private void drawSelected(int ht, int wd){//translated already
    int topLeftX = -wd/2;
    int topLeftY = -ht/2;
    int botRightX = wd/2;
    int botRightY = ht/2;
    int vertExtent = ht/4;
    int horiExtent = wd/4;
    strokeWeight(6);
    line(topLeftX,topLeftY,topLeftX,topLeftY+vertExtent);
    line(topLeftX,topLeftY,topLeftX+horiExtent,topLeftY);
    line(topLeftX,botRightY,topLeftX,botRightY-vertExtent);
    line(topLeftX,botRightY,topLeftX+horiExtent,botRightY);
    line(botRightX,topLeftY,botRightX,topLeftY+vertExtent);
    line(botRightX,topLeftY,botRightX-horiExtent,topLeftY);
    line(botRightX,botRightY,botRightX,botRightY-vertExtent);
    line(botRightX,botRightY,botRightX-horiExtent,botRightY);
    strokeWeight(1);
  }
}


class FailScreen{
  Enemy theEnemy;
  HitBox restart;
  HitBox selectLvl;
  public FailScreen(Enemy e){
    theEnemy = e;
    restart = new HitBox(630,600,80,30);
    selectLvl = new HitBox(770,600,80,30);
  }
  
  public void drawIt(){
    background(0);
    theEnemy.drawCirc();
    theEnemy.drawIt();
    pushMatrix();
    translate(700,500);
    fill(255,0,0);
    textAlign(CENTER,CENTER);
    textSize(38);
    text("Viruses has invaded your house!!",0,0);
    noFill();
    popMatrix();
    drawButtons();
  }
  private void drawButtons(){
    drawRestartButton();
    drawSelectButton();
  }
  private void drawRestartButton(){
    pushMatrix();
    translate(630,600);
    fill(255);
    rect(0,0,130,60);
    textAlign(CENTER,CENTER);
    textSize(25);
    fill(40);
    text("RESTART",0,0);
    noFill();
    popMatrix();
  }
  private void drawSelectButton(){
    pushMatrix();
    translate(770,600);
    fill(255);
    rect(0,0,130,60);
    textAlign(CENTER,CENTER);
    textSize(25);
    fill(40);
    text("SelectLevel",0,0);
    noFill();
    popMatrix();
  }
  public void detectButtons(){
    if(restart.within(mouseX,mouseY)){
      theLevel.startLevel();
      screenType = 2;
    }
    else if(selectLvl.within(mouseX,mouseY)){
      screenType = 0;
    }
  }
  
}

class WinScreen{
  //HitBox nextLevel;
  HitBox selectLvl;
  public WinScreen(){
    //nextLevel = new HitBox(630,600,80,30);
    selectLvl = new HitBox(700,600,80,30);
  }
  
  public void drawIt(){
    background(0);
    pushMatrix();
    translate(700,500);
    fill(0,255,0);
    textAlign(CENTER,CENTER);
    textSize(38);
    text("You Successfully defended this place!!",0,0);
    noFill();
    popMatrix();
    drawButtons();
  }
  private void drawButtons(){
    //drawRestartButton();
    drawSelectButton();
  }
  private void drawRestartButton(){
    pushMatrix();
    translate(630,600);
    fill(255);
    rect(0,0,130,60);
    textAlign(CENTER,CENTER);
    textSize(25);
    fill(40);
    text("RESTART",0,0);
    noFill();
    popMatrix();
  }
  private void drawSelectButton(){
    pushMatrix();
    translate(700,600);
    fill(255);
    rect(0,0,130,60);
    textAlign(CENTER,CENTER);
    textSize(25);
    fill(40);
    text("SelectLevel",0,0);
    noFill();
    popMatrix();
  }
  public void detectButtons(){
    //if(restart.within(mouseX,mouseY)){
    //  theLevel.startLevel();
    //}
    if(selectLvl.within(mouseX,mouseY)){
      screenType = 0;
    }
  }
  
}
