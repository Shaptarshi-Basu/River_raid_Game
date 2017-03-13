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
      enemyX=random(100,int(VID_WIDTH-100));
      enemyY=0;
      speed=0;
      spr = 16*3 + 8;
      enemyType=1;
      
    }
    if(choice==2){
      enemyX=random(100,int(VID_WIDTH-100));
      enemyY=0;
      speed=4;
      spr = 16*4 + 8;
      enemyType=2;
      
    }
    if(choice==3){
      enemyX=random(100,int(VID_WIDTH-100));
      enemyY=0;
      speed=-1;
      spr = 16*2 + 8;
      enemyType=3;
      
    }
    if(choice==4){
      enemyX=random(100,int(VID_WIDTH-100));
      enemyY=0;
      speed=0;
      spr = 16*5 + 8;
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
    if(spr > 16*2+11)
      spr = 16*2+8;
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
  void display(){
    if(enemyType==1){
       displayTankers(enemyX,enemyY);     
    }
    if(enemyType==2){
      displayJets(enemyX,enemyY);
    }
    if(enemyType==3){
      displayHelicopters(enemyX,enemyY);
    }
    if(enemyType==4){
      displayFuelDepots(enemyX,enemyY);
    }
  
  }

}