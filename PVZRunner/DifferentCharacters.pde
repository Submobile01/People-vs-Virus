abstract class Friend extends Character{
  public Friend(int gx, int gy){
    super(gx,gy); 
  }
  public Friend(){
    super();
  }
  public void shoot(ArrayList<Projectile> projectiles, int time, ArrayList<Enemy> enemies){}
  public void isHit(Enemy e){
    this.health-=e.attack;
    isHitAnime();
    if(this.health<=0) grid.removeFriend();
  }
  
}
class Collector extends Friend{
  //int startTime;
  int produceTime;
  SoundFile sound;
  public Collector(int gx, int gy){
    super(gx,gy);
    type = "collector";
    activated = false;
    startTime = time;
  }
  public Collector(){
    super();
  }
  public void produce(){
    if(!activated){
      if(time == startTime + cooldown){
        activated = true;
        startTime = time;
      }
    }
    if(activated){
      if(time == startTime + produceTime){
        dropSuns.add(new DropSun(DropSun.MEDIUM,cenX,cenY,gridY));
        activated = false;
        startTime = time;
      }
    }
  }
  
}

class CollectorOne extends Collector{
  public CollectorOne(int gx, int gy){
    super(gx,gy);
    id = 3;
    cost = 50;
    image = loadImage("try000.png");//
    hasAnime = true;
    this.anime = new Anime("try",4,80/4,0);//
    wd = 105;
    ht = 105;
    cooldown = 280;
    maxHealth = 50;
    health = 50;
    produceTime = 80;
    hitBox = new HitBox(cenX,cenY,80,120);
    //sound = new SoundFile(theSketch, "tiu.wav");
  }
}
class Shooter extends Friend{
  int startTime;
  //int cooldown;
  int range;//unit: grid
  int xDeviate;
  //boolean activated;
  SoundFile shootingSound;
  public Shooter(int gx, int gy){
    super(gx,gy);
    type = "shooter";
    activated = false;
  }
  public Shooter(){
    super();
  }
  public void detectEnemy(ArrayList<Enemy> enemies, int time){
    boolean temp = false;
    for(int i=0; i<enemies.size(); i++){
      Enemy enemy= enemies.get(i);
      if( (enemy.gridY == this.gridY) && (enemy.gridX <= this.gridX + range) && (enemy.gridX >= this.gridX)){
        temp = true;
        break;
      }
    }
    if(activated){
      if(temp == false){
        activated = false;
        if(hasAnime){
          animating = false;
        }
      }
    }
    else{
      if(temp == true){
        activated = true;
        startTime = time;
        if(hasAnime){
          anime.setStartTime(time);
          animating = true;
        }
        println("ah");
      }
    }
  }
  public void shoot(ArrayList<Projectile> projectiles, int time, ArrayList<Enemy> enemies){//cen deviates to the right
    //println(activated);
    detectEnemy(enemies, time);
    if(activated){
      if((time-startTime)%cooldown == 0){
        projectiles.add(new Needle(cenX+xDeviate,cenY));
        shootingSound.play();
      }
    }
  }
  
}
class OneGun extends Shooter{
  public OneGun(int gx, int gy){
    //bullet = new Needle(x,y);//coordinates unadjusted
    super(gx,gy);
    id = 1;
    cost = 100;
    image = loadImage("try000.png");
    hasAnime = true;
    this.anime = new Anime("try",4,80/4,0);
    wd = 105;
    ht = 105;
    cooldown = 80;
    maxHealth = 50;
    health = 50;
    attack = 0;
    range = 8;
    xDeviate = grid.sideL/6;
    hitBox = new HitBox(cenX,cenY,80,120);
    shootingSound = new SoundFile(theSketch, "tiu.wav");
  }
  public OneGun(){
    super();
    image = loadImage("oneGun.gif");
    id = 1;
    recharge = 200;
    cost = 100;
  }
}
class TwoGun extends Shooter{
   public TwoGun(int gx, int gy){
     //bullet = new Needle(x,y);//coordinates unadjusted
     super(gx, gy);
     id = 2;
     cost = 200;
     image = loadImage("twoGun000.png");
     hasAnime = true;
     this.anime = new Anime("twoGun",4,40/4,0);
     wd = 105;
     ht = 105;
     cooldown = 40;
     maxHealth = 50;
     health = 50;
     attack = 0;
     range = 8;
     xDeviate = grid.sideL/6;
     hitBox = new HitBox(cenX,cenY,80,120);
     shootingSound = new SoundFile(theSketch, "tiu.wav");
   }
   public TwoGun(){
     super();
     image = loadImage("twoGun000.png");
     id = 2;
     recharge = 200;
     cost = 200;
   }
}



class Enemy extends Character{
  //boolean activated;//aka attacking
  float speed;
  Board theBoard;
  public Enemy(int gridY, Board theBoard){
    trans = 255;
    Grid theGrid = theBoard.summonGrids[gridY];
    this.gridY = gridY;
    cenX = theGrid.cenX;
    cenY = theGrid.cenY;
    this.theBoard = theBoard;
    updateGridX();
  }
  public void drawAndMove(){
    imageMode(CENTER);
    if(!activated && !pausing){
      cenX+=speed;
      rotateExtent+=(speed/40);
    }
    drawIt();
    hitBox.setIt(cenX,cenY,136/4,136/4);
    updateGridX();
    attack();
    detectLosing();
    //println(rotateExtent);
  }
  public void drawCirc(){
    pushMatrix();
    translate(cenX,cenY+15);
    fill(255);
    circle(400,0,0);
    popMatrix();
  }
  public boolean updateGridX(){
    int gx = theBoard.getGridX(cenX);
    if(gridX !=gx){
      gridX = gx;
      return true;
    }
    return false;
  }
  public void isHit(Projectile proj){
    this.health-=proj.damage;
    if(this.health<=0) alive = false;
    isHitAnime();
  }
  public void attack(){
    if(activated){
      if((time-startTime)%cooldown == 0){
        theBoard.grids[gridY][gridX].friend.isHit(this);
      }
    }
  }
  public void attackAnime(){
  }
  public void detectFriend(){
    if(gridX<9 && gridX >= 0){
      Grid grid = theBoard.grids[gridY][gridX];
      if(grid.occupied && this.hitBox.collideSide(grid.plantBox)){
        if(!activated){ activated = true; startTime = time; }
      }
      else{
        if(activated){ activated = false;}
      }
    }
  }
  private void detectLosing(){
    if(cenX<theBoard.topLeftX-theBoard.sideL){
      screenType = 3;
      pausing = true;
      failScreen = new FailScreen(this);
    }
  }
}

class Corona extends Enemy{
  public Corona(int gridY, Board theBoard){
    super(gridY,theBoard);
    maxHealth = 50;
    health = maxHealth;
    image = loadImage("coronavirus.png");
    activated = false;
    attack = 5;
    speed = -1;
    cooldown = 30;
    hitBox = new HitBox(cenX,cenY,theBoard.sideL/4,theBoard.sideL/4);
  }
}
