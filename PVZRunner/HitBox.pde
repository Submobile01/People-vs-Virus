class HitBox{
  int leftMost,rightMost,upMost,botMost;
  public HitBox(int centerX, int centerY, int wd, int ht){
    setIt(centerX,centerY,wd,ht);
  }
  public void setIt(int centerX, int centerY, int wd, int ht){
    leftMost = centerX-wd/2;
    rightMost = centerX+wd/2;
    upMost = centerY-ht/2;
    botMost = centerY+ht/2;
  }
  public boolean collide(HitBox other){
    if( ((this.rightMost>other.leftMost && this.rightMost<other.rightMost) ||
         (this.leftMost>other.rightMost && this.leftMost<other.rightMost)) &&
        ((this.botMost<other.botMost && this.botMost>other.upMost) ||
         (this.upMost<other.botMost && this.upMost>other.upMost)) ) return true;
     return false;
  }
  public boolean collideSide(HitBox other){
    if( ((this.rightMost>other.leftMost && this.rightMost<other.rightMost) ||
         (this.leftMost>other.rightMost && this.leftMost<other.rightMost)) ) return true;
     return false;
  }
  public boolean within(int x, int y){
    if(x > leftMost && x < rightMost &&
      y > upMost && y < botMost) return true;
    return false;
  }
  public String toString(){
    return "[up: " + upMost
          +"\nbot: " + botMost
          +"\nleft: " + leftMost
          +"\nright: " + rightMost + "]";
  }
}
