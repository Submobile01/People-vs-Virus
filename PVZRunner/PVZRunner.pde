import processing.sound.*;
//global variables
boolean pausing;
int screenType;//0-selectLevel, 2-gaming, 3-fail
int time;
Board theBoard;
SelectingBoxes selBoxes;
int selectedID = 0;
int sun = 50;
Hordes theHordes;
Level theLevel;
SelectLevel selectlvl;
BottomMessage botMes;
FailScreen failScreen;
WinScreen winScreen;
PApplet theSketch = this;
ArrayList<Friend> friends;
ArrayList<Enemy> enemies;
ArrayList<Projectile> projectiles;
ArrayList<DropSun> dropSuns;
void setup(){
   size(1400,1000); 
   selectlvl = new SelectLevel();
   botMes = new BottomMessage();
   theBoard = new Board(width,height,5,9);
   selBoxes = new SelectingBoxes(new int[]{1,2});
   theHordes = new Hordes(new int[][]{{1,1},{1},{1},{1,1,1,1},{1,1,1,1}}, new int[][]{{0,1},{1},{3},{},{}}, new int[]{1000,1000,600,1000,100});
   //friends.add(new OneGun(theBoard.grids[0][0].cenX,theBoard.grids[0][0].cenY));
   //selected
   //theBoard.grids[0][0].setFriend(new OneGun(0,0));
   //theBoard.grids[1][0].setFriend(new TwoGun());
   //theBoard.enemies.add(new Corona(0,theBoard));
   //println(theBoard.topLeftX + " " + theBoard.topLeftY + " " + theBoard.sideL);
   friends = new ArrayList<Friend>();
   enemies = new ArrayList<Enemy>();
   projectiles = new ArrayList<Projectile>();
   dropSuns = new ArrayList<DropSun>();
}

void mousePressed(){
  if(mouseButton == RIGHT){
    //theBoard.enemies.add(new Corona(gridY,theBoard));
    if(screenType == 2) if(!pausing) dropSuns.add(new DropSun(DropSun.MEDIUM));
  }
  else if(mouseButton == LEFT){
    if(screenType == 2) if(!pausing) theBoard.doClicked();
    
    if(screenType == 0) selectlvl.select();
    if(screenType == 3) failScreen.detectButtons();
    if(screenType == 4) winScreen.detectButtons();
  }
}

void keyPressed(){
  if(key == ' '){
    pausing = !pausing;
  }
  else if(key == 'r'){
    theLevel.startLevel();
  }
}
void draw(){
  
  if(screenType == 0){
    selectlvl.drawSelectLevelScreen();
  }
  if(screenType == 2){
    if(!pausing){
      time++;
    }
    theBoard.drawIt();
    theBoard.doStuff();
    selBoxes.drawIt();
    displaySun();
  }
  if(screenType == 3) failScreen.drawIt();
  if(screenType == 4) winScreen.drawIt();
  botMes.drawWarning();
   //println(enemies.size());
   //if(projectiles.size()>0) println(projectiles.get(0).hitBox);
   //println(enemies.size());
   //println(projectiles.size());
   /*for(int i=0; i<friendlyCreatures.size();i++){
     friends.get(i).drawIt(theBoard);
   }*/
   //save("realBoardPic.png");
}


public boolean settleFriend(int id, int gx, int gy){
  Friend friend;
  switch(id){
    case 1:
      friend = new OneGun(gx,gy);
      break;
    case 2:
      friend = new TwoGun(gx,gy);
      break;
    default:
      friend = new OneGun(gx,gy);
  }
  return theBoard.grids[gy][gx].setFriend(friend);
}

public Enemy getEnemy(int id, int gy){
  Enemy e;
  switch(id){
    case 1:
      e = new Corona(gy,theBoard);
      break;
    default:
      e = new Corona(gy,theBoard);
  }
  return e;
}
public Friend getFriend(int id){
  Friend friend;
  switch(id){
    case 1:
      friend = new OneGun();
      break;
    case 2:
      friend = new TwoGun();
      break;
    default:
      friend = new OneGun();
  }
  return friend;
}

private void displaySun(){
  pushMatrix();
  //strokeWeight(1);
  translate(45,25);
  rectMode(CENTER);
  fill(255);
  stroke(0);
  rect(0,0,90,50);
  textAlign(CENTER,CENTER);
  textSize(18);
  fill(0);
  text("sun: " + sun,0,0);
  popMatrix();
}
