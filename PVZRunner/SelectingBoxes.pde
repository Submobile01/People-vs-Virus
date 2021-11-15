public class SelectingBoxes{
  int n;
  int ht;
  int eachWd;
  int leftest;
  int rightest;
  int selectedIndex;
  SelectingBox[] boxes;
  public SelectingBoxes(int[] ids){
    n = ids.length+1;
    ht = 120;
    eachWd = 100;
    leftest = 180;
    rightest = leftest + eachWd*n;
    this.boxes = new SelectingBox[n];
    for(int i=0; i<n; i++){
      if(i!=n-1)boxes[i] = new SelectingBox(getFriend(ids[i]));
      else boxes[i] = new SelectingBox();//firing box
    }
    selectedIndex = -1;
  }
  
  public void drawIt(){
    for(int i=0; i<n; i++){
      boxes[i].drawIt((int)(leftest+eachWd*(i+0.5)),ht/2,eachWd);
    }
  }
  public int getID(int x){
    int index = (x-leftest)/eachWd;
    if(index == n-1) return -1;
    return boxes[index].id;
  }
  public void select(){
    int index = (mouseX-leftest)/eachWd;println("index: " + index);
    int lastInd = selectedIndex;
    deselect(false);
    if(boxes[index].selectable ){
      if(index == lastInd){
        selectedID = 0;
        selectedIndex = index;
        boxes[index].selected = false;
        deselect(false);
      }
      else if(index == n-1){
        selectedID =  -1;
        selectedIndex = index;
      }
      else{
        selectedID = boxes[index].id;
        selectedIndex = index;
      }  
      if(selectedIndex != -1) boxes[selectedIndex].selected = true;
    }
    else{
      botMes.show(2);
    }
    
    
  }
  public void deselect(boolean successful){
    if(selectedIndex != -1) boxes[selectedIndex].selected = false;
    if(successful) boxes[selectedIndex].startTime = time;
    selectedIndex = -1;
  }
  public void initialize(){
    for(int i=0; i<n-1; i++){
      boxes[i].startTime = 0;
    }
  }
}

class SelectingBox{
  int startTime;
  int recharge;
  int id;
  int cost;
  boolean isFired;
  boolean selected;
  boolean selectable;
  PImage image;
  public SelectingBox(Friend friend){
    this.recharge = friend.recharge;
    this.image = friend.image;
    this.id = friend.id;
    this.cost = friend.cost;
  }
  public SelectingBox(){
    this.isFired = true;
    this.selectable = true;
  }
  public void drawIt(int cenX,int cenY, int eachWd){
    imageMode(CENTER);
    rectMode(CENTER);
    pushMatrix();
    fill(255);
    translate(cenX,cenY);
    stroke(0);
    rect(0,0,eachWd,cenY*2);
    if(!isFired){
      rect(0,(int)(cenY*-0.8),eachWd,(int)(cenY*0.4));
      fill(0);
      textSize(18);
      text(cost,0,(int)(cenY*-0.8));
      noFill();
      image(image,0,(int)(cenY*0.2),eachWd, (int)(cenY*1.6));
    }
    else{
      fill(0);
      textAlign(CENTER,CENTER);
      textSize(32);
      text("FIRED!",0,0);
    }
    if(selected) drawSelected(cenX,cenY,eachWd);
    if(!isFired){
      if(time<startTime+recharge){
        selectable = false;
        float portion = (float)(startTime+recharge-time)/recharge;
        fill(0,200);
        rect(0,0-cenY*(1-portion),eachWd,cenY*2*portion);
      }else selectable = true;
      if(cost>sun){
        selectable = false;
        fill(40,170);
        rect(0,0,eachWd,cenY*2);
      }else{
        if(selectable) selectable = true;
      }
    }
    popMatrix();
  }
  private void drawSelected(int cenX, int cenY, int wd){//translated already
    int topLeftX = -wd/2;
    int topLeftY = -cenY;
    int botRightX = wd/2;
    int botRightY = cenY;
    int vertExtent = cenY/2;
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
