class Enemy { 
  int speed;
  PImage photo;
  float enemyX;
  float enemyY;
  int enemyType;
  int spr;
  

  // The Constructor is defined with arguments.
  Enemy(float tempXpos, float tempYpos, int tempXspeed, float c) { 
  }
  Enemy(int choice){
    if(choice==1){
      enemyX=random(100,int(width-100));
      enemyY=0;
      speed=5;
      spr = 32*2 + 16;
      enemyType=1;
      
    }
    if(choice==2){
      enemyX=random(100,int(width-100));
      enemyY=0;
      speed=9;
      spr = 32*2 + 16;
      enemyType=2;
      
    }
    if(choice==3){
      enemyX=random(100,int(width-100));
      enemyY=0;
      speed=7;
      spr = 32*2 + 16;
      enemyType=3;
      
    }
    if(choice==4){
      enemyX=random(100,int(width-100));
      enemyY=0;
      speed=5;
      spr = 32*2 + 16;
      enemyType=4;
      
    }  
  }
  

  void displayTankers(float x,float y) {
    //photo = loadImage("Tank-GTA2.png");
    //image(photo,x,y);
    drawQuad(x - 16, y - 16, spr);
    
  }
  void displayHelicopters(float x,float y) {
    //photo = loadImage("helicopter.png");
    //image(photo,x,y);
    drawQuad(x - 16, y - 16, spr);
    spr++;
    if(spr > 32*2+19)
      spr = 32*2+16;
  }
  void displayJets(float x,float y) {
    //photo = loadImage("Jet.png");
    //image(photo,x,y);
    drawQuad(x - 16, y - 16, spr);
    
  }
  void displayFuelDepots(float x,float y) {
    //photo = loadImage("oilbarrel.png");
    //image(photo,x,y);
    drawQuad(x - 16, y - 16, spr); 
  }
  void display(Enemy e){
    if(e.enemyType==1){
       displayTankers(e.enemyX,e.enemyY);     
    }
    if(e.enemyType==2){
      displayJets(e.enemyX,e.enemyY);
    }
    if(e.enemyType==3){
      displayHelicopters(e.enemyX,e.enemyY);
    }
    if(e.enemyType==4){
      displayFuelDepots(e.enemyX,e.enemyY);
    }
  
  }

}