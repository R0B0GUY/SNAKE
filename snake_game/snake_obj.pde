class Snakes {
  //array of all snakes in play
  Snake[] lizards;
  
  //init snakes by specifying how many
  Snakes(int s) {
    lizards = new Snake[s];
    // need to init snakes in different locs
    for (int i = 0; i < s; i++) {
      lizards[i] = new Snake(1);
      //translate each subsequent snake down one after the first
      lizards[i].translate(0,i+6);
    }
  }
  
  
  
  //move snakes also add input for other snake
  void move(char kee) {
    //char swap;
    if (kee == 'a' || kee == 's' || kee == 'd' || kee == 'w') {
      lizards[0].move(kee);
    } else if (kee == 'j' || kee == 'k' || kee == 'l' || kee == 'i' && gameMode == 2) {
      switch (kee) {
        case 'j' :
          lizards[1].move('a');
          break;
        case 'k' :
          lizards[1].move('s');
          break;
        case 'l' :
          lizards[1].move('d');
          break;
        case 'i' :
          lizards[1].move('w');
          break;
      }
    }
  }
  
  //reset game with both snakes renewed
  void restart() {
    for (Snake s : lizards) {
      s.resetSnake(3);
      
    }
    gameSt = 1;
  }
  
  //update  all snakes based on their next dir
  void update() {
    for (Snake s : lizards) {
      s.update();
    }
    if (isOnSnake()) {
      gameSt *= -1;
    }
  }
  
  //draw both snakes
  void show() {
    for (Snake s : lizards) {
      s.show();
    }
  }
  
  boolean isOnSnake() {
      for (int s = 0; s < lizards.length; s++) {
        for (int i = 0; i < lizards[s].l; i++) {
          if (lizards[s].hI != i && lizards[s].hX == lizards[s].body[i].x && lizards[s].hY == lizards[s].body[i].y) {
            return true;
          }
          for (int g = 0; g < lizards.length; g++) {
            for (int j = 0; j < lizards[g].body.length; j++) {
              if (s != g && lizards[s].hX == lizards[g].body[j].x && lizards[s].hY == lizards[g].body[j].y) {
                return true;
              }
            }
          }
        }
      }
      return false;
    }
  
  //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  //SNAKECLASSSNAKECLASSSNAKECLASS-----------------------------------
  class Snake {
    Segment[] body;
    int l;
    char dir;
    Boolean jt;
    
    int score;
    
    int hX, hY, hI, oldheadPos;
    int tailX, tailY;
  
    
    Snake(int startL) {
      body = new Segment[startL];
      l = body.length;
      dir = 'd';
      
      score = 0;
      
      
      for (int i = 0; i < l; i++) {
        body[i] = new Segment();
        body[i].x -= i;
      }
      
      body[l-1].last = true;
      jt = false;
      
      hX = body[0].x;
      hY = body[0].y;
      hI = 0;
    }
    
    void resetSnake(int startL) {
      body = new Segment[startL];
      l = body.length;
      dir = 'd';
      
      score = 0;
      
      
      for (int i = 0; i < l; i++) {
        body[i] = new Segment();
        body[i].x -= i;
      }
      
      body[l-1].last = true;
      jt = false;
      
      hX = body[0].x;
      hY = body[0].y;
      hI = 0;
    }
    
    //CYCLE OF EVENTS FOR SNAKE TO UPDATE ---------------------------------
    void update() {
      
      moveBody();
      
      if (this.isEat()) {
        this.score(1);
        this.grow();
        food.respawn();
      }
      
      
      
      if (isOut()) {
        resetSnake(3);
      }
      
      
    }
    
    //SELF INTERSECTION CHECKER ----------------------------------------------
    
    
    
    boolean isOut() {
      if (this.hX < inD || this.hX > outD-1 || this.hY < inD || this.hY > outD-1) {
        return true;
      } else {
        return false;
      }
    }
    
    
    void moveBody() {
      delay(100);
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
    
    void score(int i) {
      this.score += i;
      if (this.score > highScore) {
        highScore = this.score;
      }
    }
    
    
    //DISPALY SNAKE ---------------------------------------------------------
    void show() {
      for (int i = 0; i < body.length; i++) {
        body[i].show(i);
      }
      body[hI].headShow();
      scoreDraw();
    }
    
    
    
    boolean isEat() {
      if (food.checkMonch(this.hX,this.hY)) {
        return true;
      } else {
        return false;
      }
      
    }
    
    //TRANSLATE SNAKE FUNCION -------------------------------------------------
    
    void translate(int x, int y) {
      for (Segment s : body) {
        s.x += x;
        s.y += y;
      }
    }
    
    //FOOD EATEN FUNCION ------------------------------------------------------
    void grow() {
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
    
    
    
    //SEGMENT CLASS ------------------------------------------------------------
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
  //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
}
