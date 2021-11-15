class Anime{
  PImage[] images;
  int imageCount;
  int frame;
  int interval;
  int startTime;
  
  public Anime(String imagePrefix, int count, int interval, int startTime) {
    imageCount = count;
    images = new PImage[imageCount];
    this.interval = interval;
    this.startTime = startTime;
    
    for (int i = 0; i < imageCount; i++) {
      String filename = imagePrefix + nf(i, 3) + ".png";
      images[i] = loadImage(filename);
    }
  }

  void display(int wd, int ht) {//need to be translated
    frame = ((time-startTime+10)/interval) % imageCount;
    image(images[frame], 0, 0,wd,ht);
  }
  
  int getWidth() {
    return images[0].width;
  }
  
  void setStartTime(int t){
    this.startTime = t;
  }
}
