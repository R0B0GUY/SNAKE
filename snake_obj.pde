//SNAKECLASSSNAKECLASSSNAKECLASS-----------------------------------------------------------------
class Snake {
  Segment[] body;
  char dir;
  Boolean jt;
  int hX, hY, hI, oldheadPos;
  int l;
  int score;
  
  
  
  Snake(int startL) {
    body = new Segment[startL];
    score = 0;
    l = body.length;
    dir = 'd';
    for (int i = 0; i < l; i++) {
      body[i] = new Segment();
      body[i].x -= i;
      //body[i].show();
    }
    
    body[l-1].last = true;
    jt = false;
    
    hX = body[0].x;
    hY = body[0].y;
    hI = 0;
  }
  
  void restart() {
    snake = new Snake(3);
    gameSt = 1;
  }
  
  //CYCLE OF EVENTS FOR SNAKE TO UPDATE ---------------------------------
  void update() {
    delay(200);
    for (int i = 0; i < l; i++) {
      if (body[i].last) {
        body[i].last = false;
        tailX = body[i].x;
        tailY = body[i].y;
        hI = i;
        
        int newLast = (i-1+l) % l;
        oldheadPos = (i+1) % l;
        body[newLast].last = true;
        
        switch (dir) {
          case 'w':
            body[i].y = body[oldheadPos].y - 1;
            body[i].x = body[oldheadPos].x;
            break;
          case 'a':
            body[i].y = body[oldheadPos].y;
            body[i].x = body[oldheadPos].x - 1;
            break;
          case 's':
            body[i].y = body[oldheadPos].y + 1;
            body[i].x = body[oldheadPos].x;
            break;
          case 'd':
            body[i].y = body[oldheadPos].y;
            body[i].x = body[oldheadPos].x + 1;
            break;
        }
        
        hX = body[i].x;
        hY = body[i].y;
        break;
      }
    }
    jt = false;
    if (this.isEat()) {
      score += 1;
      if (this.score > highScore) {
        highScore = this.score;
      }
      this.eat();
      food.respawn();
    }
    if (isOnSelf()) {
      gameSt = -1;
    }
    if (isOut()) {
      gameSt = -1;
    }
    
    
  }
  
  //SELF INTERSECTION CHECKER ----------------------------------------------
  boolean isOnSelf() {
    
    for (int i = 0; i < l; i++) {
      
      if (hI != i && hX == body[i].x && hY == body[i].y) {
        
        return true;
      }
    }
    return false;
  }
  
  
  boolean isOut() {
    if (this.hX < inD || this.hX > outD || this.hY <inD || this.hY > outD) {
      return true;
    } else {
      return false;
    }
  }
  
  
  //CHANGE SNAKE DIR BY INPUT ----------------------------------------------
  void move(char dirP) {
    
    if (!jt) {
      switch (dirP) {
        case 'w':
          if (this.dir != 's') {
            this.dir = 'w';
          }
          break;
        case 'a':
          if (this.dir != 'd') {
            this.dir = 'a';
          }
          break;
        case 's':
          if (this.dir != 'w') {
            this.dir = 's';
          }
          break;
        case 'd':
          if (this.dir != 'a') {
            this.dir = 'd';
          }
          break;
      }
    }
    jt = true;
  }
  

  //DISPALY SNAKE ---------------------------------------------------------
  void show() {
    for (int i = 0; i < body.length; i++) {
      body[i].show(i);
    }
    body[hI].headShow();
  }
  
  boolean isEat() {
      if (hX == food.x && hY == food.y) {
        return true;
      }
      return false;
    }
    
  //FOOD EATEN FUNCION ------------------------------------------------------
  void eat() {
    Segment seg = new Segment();
    body = (Segment[])append(body, seg);
    l = body.length;
    
    if (hI != 0) {
      body[l-1].x = body[0].x;
      body[l-1].y = body[0].y;
      for (int i = 0; i < hI-1; i++) {
        body[i].x = body[i+1].x;
        body[i].y = body[i+1].y;
        
      }
      body[hI-1].x = tailX;
      body[hI-1].y = tailY;
      
    } else {
      body[l-1].x = tailX;
      body[l-1].y = tailY;
      body[l-2].last = false;
      body[l-1].last = true;
    }
    
  }
  
  //SEGMENT CLASS ----------------------s-------------------------------------
  class Segment {
    int x,y;
    int lx,ly;
    Boolean last = false;
    
    Segment() {
      x = inD + 4;
      y = inD+8;
    }
    
    //show snake head method -----------------------
    void headShow() {
      fill(0);
      rect(this.x*sqL,this.y*sqL,sqL,sqL);
    }
    
    //show regular snake part method ---------------
    void show(int j) {
      fill(255);
      //text(j, this.x*sqL,this.y*sqL);
      rect(this.x*sqL,this.y*sqL,sqL,sqL);
    }
    
  }
  
  void scoreDraw() {
    fill(255);
    textSize(20);
    text("Score: " + this.score, 3*sqL, 2*sqL);
  }
}
