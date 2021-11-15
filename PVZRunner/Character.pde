abstract class Character{
  String type;
  String name;
  boolean alive;
  boolean activated;
  boolean friendly;
  int id;
  int projectileID;
  int maxHealth;
  int health;
  int attack;
  int cost;
  int recharge;
  int gridX;
  int gridY;
  int cenX;
  int cenY;
  int ht;
  int wd;
  int startTime;
  int cooldown;
  int trans;
  int normalTime;//when the transparency goes back to normal
  float rotateExtent;
  Grid grid;
  HitBox hitBox;
  PImage image;
  Anime anime;
  boolean hasAnime;
  boolean animating;
  public Character(){
      alive = true;
  }
  public Character(int gx, int gy){
    alive = true;
    gridX = gx;
    gridY = gy;
    this.grid = theBoard.grids[gy][gx];
    cenX = grid.cenX;
    cenY = grid.cenY;
    trans = 255;
  }
  public boolean isAlive(){
    return alive;
  }
  public void drawIt(){
    imageMode(CENTER);
    pushMatrix();
    translate(cenX,cenY+15);
    rotate(rotateExtent);
    tint(255,trans);
    if(!hasAnime) image(image,0,0);
    else{
      if(animating) anime.display(wd,ht);
      else image(image,0,0,wd,ht);
    }
    popMatrix();
    if(time>=normalTime) trans = 255;
    else trans = 150;
  }
  public HitBox getHitBox(){
    return hitBox;
  }
  public void isHitAnime(){
    normalTime = time+3;
  }
  public void ability(){//overrideable
    
  }
  /*public void setGeneralStats(String imageURL, int maxHealth){
    this.image = loadImage(imageURL);
    this.name = imageURL.substring(0,imageURL.length()-4);
    this.maxHealth = maxHealth;
    this.health = maxHealth;
  }*/
}
