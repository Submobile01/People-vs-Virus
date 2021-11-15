class BottomMessage{
  ArrayList<String> warnings;
  int current;
  int startTime;
  int duration = 60;
  int alpha;
  public BottomMessage(){
    warnings = new ArrayList<String>();
    loadWarnings();
    alpha = 255;
  }
  public void show(int which){
    startTime = time;
    current = which;
  }
  private void loadWarnings(){
    warnings.add("place holder 0");
    warnings.add("This Grid is already occupied");
    warnings.add("You don't have enough money, or recharge isn't over yet");
  }
  
  public void drawWarning(){
    if(current>=1){
      pushMatrix();
      translate(700,900);
      fill(255,0,0,alpha);
      textAlign(CENTER,CENTER);
      textSize(28);
      text(warnings.get(current),0,0);
      noFill();
      popMatrix();
      if(time > startTime + duration){
        alpha-=5;
        if(alpha <= 0){
          current = 0;
          alpha = 255;
        }
      }
    }
  }
}
