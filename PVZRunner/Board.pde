class Board{
   int wd;
   int ht;
   int sideL;
   int topLeftX,topLeftY,botRightX,botRightY;
   int rows,columns;
   int lastTimeDropSun;
   int waitSunTime = 300;
   PImage image;
   Grid[][] grids;
   Grid[] summonGrids;
   
   public Board(int w, int h, int r, int c){
     wd = w;
     ht = h;
     sideL = 132;//(int)(0.136*h);
     topLeftX = 181;//(int)(w*0.1);
     topLeftY = 170;//(int)(h*0.18);
     rows = r;
     columns = c;
     botRightX = topLeftX+sideL*columns;
     botRightY = topLeftY+sideL*rows;
     grids = new Grid[rows][columns];
     summonGrids = new Grid[rows];
     image = loadImage("realBoardPic.png");
     initializeStuff();
   }
   public void initializeStuff(){
     initializeGrids();
     friends = new ArrayList<Friend>();
     enemies = new ArrayList<Enemy>();
     projectiles = new ArrayList<Projectile>();
     dropSuns = new ArrayList<DropSun>();
   }
   private void initializeGrids(){
     for(int i=0; i<rows; i++){
       summonGrids[i] = new Grid(9,i,topLeftX,topLeftY,sideL);
       for(int j=0; j<columns; j++){
        grids[i][j] = new Grid(j,i,topLeftX,topLeftY,sideL);
       }
     }
   }
   public int getUpMost(){
     return topLeftY;
   }
   public int getBotMost(){
     return botRightY;
   }
   public int getLeftMost(){
     return topLeftX;
   }
   public int getRightMost(){
     return botRightX;
   }
   public void drawIt(){
    background(255);
    pushMatrix();
    imageMode(CENTER);
    tint(255,255);
    image(image,width/2,height/2);
    popMatrix();
    for(int i=0; i<rows; i++){
      for(int j=0; j<columns; j++){
        grids[i][j].drawIt();
      }
    }
   }
   public int getGridX(int cenX){
     return (int)((cenX-topLeftX)/sideL);
   }
   public int getGridY(int cenY){
     return (int)((cenY-topLeftY)/sideL);
   }
   public void doClicked(){
      int gridX = theBoard.getGridX(mouseX);
      int gridY = theBoard.getGridY(mouseY);
      if(!pausing){
        if(mouseButton == RIGHT){
          //theBoard.enemies.add(new Corona(gridY,theBoard));
          dropSuns.add(new DropSun(DropSun.MEDIUM));
        }
        else if(mouseButton == LEFT){
          for(int i=0; i<dropSuns.size(); i++){
            DropSun theSun = dropSuns.get(i);
            if(theSun.hitBox.within(mouseX,mouseY)){
              sun+=theSun.value;
              dropSuns.remove(i);
              return;
            }
          }
          if(mouseX<=theBoard.botRightX && mouseY<=theBoard.botRightY && mouseX>=theBoard.topLeftX && mouseY>=theBoard.topLeftY){
            boolean settled = false;
            if(selectedID > 0){
              settled = settleFriend(selectedID,gridX,gridY);
            }
            else if(selectedID == -1){theBoard.grids[gridY][gridX].removeFriend();}
            if(selectedID != 0){
              selBoxes.deselect(settled);
            }
            selectedID = 0;
          }
          else{
            //selectedID = 0;//println("zero");
            //selBoxes.deselect(false);
            if(mouseX<=selBoxes.rightest && mouseY<=selBoxes.ht && mouseX>=selBoxes.leftest && mouseY>=0){
              selBoxes.select();
            }
            else selBoxes.deselect(false);
          }
          println("selectedID: " + selectedID);
          println("selectedIndex: " + selBoxes.selectedIndex);
          //if(theBoard.dropSuns.size()>0) println(theBoard.dropSuns.get(0).hitBox);
        }
      }
   }
   public void doStuff(){
     for(int i=0; i<rows; i++){
       for(int j=0; j<columns; j++){
         grids[i][j].doStuff(projectiles, time, enemies);
       }
     }
     for(int i=0; i<friends.size(); i++){
     
     }
     for(int i=0; i<enemies.size(); i++){
       Enemy e = enemies.get(i);
       e.drawAndMove();
       if(!e.isAlive()) enemies.remove(i);
       e.detectFriend();
       //if(proj.disappear(theBoard)) projectiles.remove(i);
     }
     for(int i=0; i<projectiles.size(); i++){
       Projectile proj = projectiles.get(i);
       proj.drawAndMove();
       if(proj.disappear(theBoard) || proj.collide(enemies)) projectiles.remove(i);
     }
     for(int i=0; i<dropSuns.size(); i++){
       DropSun d = dropSuns.get(i);
       d.drawIt();
       if(d.shouldGo()){
         dropSuns.remove(i);i--;
       }
     }
     checkWin();
     dropSun();
     if(!(theHordes.hordes.size() == 0)) theHordes.releaseNextHorde();
   }
   private void checkWin(){
     if(theHordes.hordes.size() == 0){
       if(enemies.size() == 0){
         winScreen = new WinScreen();
         screenType = 4;
       }
     }
   }
   private void dropSun(){
     if(time == lastTimeDropSun+waitSunTime){
       dropSuns.add(new DropSun(DropSun.MEDIUM));
       lastTimeDropSun = time;
     }
   }
   
   private boolean mouseWithin(){
     return mouseX<=theBoard.botRightX && mouseY<=theBoard.botRightY && mouseX>=theBoard.topLeftX && mouseY>=theBoard.topLeftY;
   }
}



class Grid{
  int cenX,cenY,sideL;
  PImage image ;
  boolean occupied;
  Friend friend;
  HitBox hitBox;
  HitBox plantBox;
  public Grid(int x, int y, int topLeftX, int topLeftY, int sideL){
      this.cenX = topLeftX+sideL/2+x*sideL;
      this.cenY = topLeftY+sideL/2+y*sideL;
      this.sideL = sideL;
      this.occupied = false;
      hitBox = new HitBox(cenX,cenY,sideL,sideL);
      plantBox = new HitBox(cenX,cenY,sideL,sideL);
      occupied = false;
      if(y%2 == 0)image = loadImage("groundOne.png");
      else image = loadImage("groundTwo.png");
  }
  public boolean setFriend(Friend friend){
    if(occupied == false && sun >= friend.cost){
      this.friend = friend;
      sun-=friend.cost;
      occupied = true;
      return true;
    }
    else if(occupied){
      println("occupied");
      botMes.show(1);
      return false;
    }
    else if(sun<friend.cost){
      println("not enough money");
      return false;
    }
    else return false;
  }
  public void removeFriend(){
    this.friend = null;
    occupied = false;
  }
  public void doStuff(ArrayList<Projectile> projectiles, int time, ArrayList<Enemy> enemies){
    if(occupied){
      friend.shoot(projectiles,time, enemies);
    }
  }
  public void drawIt(){
      pushMatrix();
      stroke(0);
      imageMode(CENTER);
      rectMode(CENTER);
      strokeWeight(1);
      //fill(255);
      //image(image,cenX,cenY,sideL,sideL);
      noFill();
      rect(cenX,cenY,sideL,sideL);
      popMatrix();
      if(occupied){
        friend.drawIt();
      }
  }
}
