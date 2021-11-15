class DropSun{
  int value;
  float cenX;
  int cenY;
  int radius;
  int fallSpeed = 2;
  int fallExtent;
  int startTime;
  int trans = 140;
  int maxTrans = 140;
  int duration = 2000;
  HitBox hitBox;
  static final int SMALL = 1;
  static final int MEDIUM = 2;
  static final int BIG = 3;
  public DropSun(int type){
    setValue(type);
    radius = 30*type;
    cenX = random(theBoard.topLeftX+radius,theBoard.botRightX-radius);
    cenY = 0-radius;
    fallExtent = radius*2 + theBoard.topLeftY + (int)random(theBoard.rows)*theBoard.sideL;
    hitBox = new HitBox((int)cenX,cenY,radius*2,radius*2);
    startTime = time;
  }
  public DropSun(int type, int cenX, int cenY, int gridY){
    setValue(type);
    radius = 30*type;
    this.cenX = cenX;
    this.cenY = cenY;
    fallExtent = radius*2 + theBoard.topLeftY + gridY*theBoard.sideL;
    hitBox = new HitBox((int)cenX,cenY,radius*2,radius*2);
    startTime = time;
  }
  public void disappearAnime(){
    if(time > startTime+ duration - maxTrans*2){
      if(time%2 == 0) trans--;
    }
  }
  public boolean shouldGo(){
    return (time == startTime + duration);
  }
  public void drawIt(){
    if(!pausing && cenY<fallExtent) cenY+=fallSpeed;
    pushMatrix();
    noStroke();
    fill(255,255,0,trans);
    circle(cenX,cenY,radius);
    popMatrix();
    hitBox.setIt((int)cenX,cenY,radius*2,radius*2);
    disappearAnime();
  }
  private void setValue(int type){
    switch(type){
      case 1:
        value = 25;
        break;
      case 2:
        value = 50;
        break;
      case 3: 
        value = 75;
        break;
    }
  }
  
}
