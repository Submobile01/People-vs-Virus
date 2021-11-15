class Projectile{
   double velocity;
   int damage;
   int id;
   int posX;
   int posY;
   int row;
   int startTime;
   PImage image;
   HitBox hitBox;
   public Projectile(int x, int y){
     posX = x;
     posY = y;
     startTime = time;
   }
   public void setStats(int id){
     this.id = id;
     switch(id){
       case 1:
         velocity = 2;
         damage = 5;
         hitBox = new HitBox(posX,posY,10,2);
         break;
     }
     
   }
   public void drawAndMove(){//need to insert image
     if(!pausing) posX+=velocity;
     pushMatrix();
     translate(posX,posY);
     fill(255,0,0);
     rectMode(CENTER);
     rect(0,0,10,2);
     popMatrix();
   }
   public boolean disappear(Board theBoard){
     if(posX>theBoard.getRightMost() || posX<theBoard.getLeftMost()
     || posY>theBoard.getBotMost() || posY<theBoard.getUpMost()){
       return true;
     }
     return false;
   }
   public boolean collide(ArrayList<Enemy> enemies){
     hitBox.setIt(posX,posY,10,2);
    for(int i=0; i<enemies.size(); i++){
      Enemy enemy = enemies.get(i);
      if(hitBox.collide(enemy.getHitBox())){
        enemy.isHit(this);
        //println("collided");
        return true;
      }
    }
    return false;
  }
}

//specific ones
class Needle extends Projectile{
  public Needle(int x, int y){
    super(x,y);
    id = 1;
    velocity = 2;
    damage = 5;
    hitBox = new HitBox(posX,posY,10,2);
    //println(hitBox);
  }
  
}
