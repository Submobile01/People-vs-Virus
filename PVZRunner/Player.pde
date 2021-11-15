class Player{
  String name;
  ArrayList<Integer> possessedFriendIDs;
  ArrayList<Integer> beatedLevelIDs;
  public Player(String name){
    this.name = name;
  }
  public Player(String name, ArrayList<Integer> friendIds, ArrayList<Integer> beatedIds){
    this.possessedFriendIDs = friendIds;
    this.beatedLevelIDs = beatedIds;
    this.name = name;
  }
  
}
