class Snakes {
  //array of all snakes in play
  Snake[] lizards;
  int snakeNum, snakeLen;
  
  
  //init snakes by specifying how many
  Snakes(int s, int snakeL) {
    step(sp(1)+"Snake inner INIT started");

    snakeNum = s;
    snakeLen = snakeL;
    lizards = new Snake[s];
    // need to init snakes in different locs
    for (int i = 0; i < s; i++) {
      step("INIT snake: " + i + " starting");
      lizards[i] = new Snake(snakeLen);
      step(sp(2)+"Length of lizards[" + i + "] array: " + lizards[i].l);
      //translate each subsequent snake down one after the first
    }
    step(sp(1)+"all snakes INITed");
    //printAllSegCoords();
    for (int i = 0; i < snakeNum; i++) {
      step(sp(2)+"Snake translate started; translating snake: " + i);
      stepNC(sp(2)+"lizards translation called at: " + stepCount);
      stepNC(sp(2)+"Snake " + i + " Head X: " + lizards[i].hX + " Head Y: " + lizards[i].hY);
      lizards[i].translateSnake(0, 3*i);
      step(sp(2)+"translate on snake: " + i + " has finished");
      stepNC(sp(2)+"Snake " + i + " new Head X: " + lizards[i].hX + " new Head Y: " + lizards[i].hY);
    }
    //printAllSegCoords();
  }
  
  //update  all snakes based on their next dir
  void update() {
    step("all snake update is called");
    for (Snake s : lizards) {
      s.update();
    }
    if (isOnSnake()) {
      step("snake on snake detected switching game state");
      gameSt = -1;
    }
    step("update finished");
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
  void restartAll() {
    step("restart all has been called");
    for (Snake s : lizards) {
      stepNC("restartAll called at: " + frameCount);
      s.resetSnake(snakeLen);
      for (int i = 0; i < snakeNum; i++) {
        lizards[i].translateSnake(0, int(random(-4,4)));
      }
    }
    gameSt = 1;
  }
  

  //draw both snakes
  void show() {
    for (Snake s : lizards) {
      s.show();
    }
  }
  
  boolean isOnSnake() {
    step("is on snake has been called");
    //print snake segment locations
    
    
      for (int s = 0; s < lizards.length; s++) {
        for (int i = 0; i < lizards[s].l; i++) {
          if (lizards[s].hI != i && lizards[s].hX == lizards[s].body[i].x && lizards[s].hY == lizards[s].body[i].y) {
            return true;
          }
          
          for (int g = 0; g < lizards.length; g++) {
            for (int j = 0; j < lizards[g].l
            ; j++) {
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
  
    //{}{}{}{}{}{}{}{}{}{}{}{}XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX{}{}{}{}{}{}{}{}{}{}{}{}{}{} FIX THIS! FIX THIS! FIX THIS! FIX THIS! FIX THIS! FIX THIS! FIX THIS! FIX THIS! FIX THIS! FIX THIS! FIX THIS! FIX THIS! FIX THIS! FIX THIS! FIX THIS! FIX THIS!
    Snake(int startL) {
      step(sp(3)+"individual snake INIT started");
      body = new Segment[startL];
      l = body.length;
      dir = 'd';
      
      score = 0;
      
      
      for (int i = 0; i < l; i++) {
        step(sp(4)+"running segment init for " + i +"'th segment");
        body[i] = new Segment();
        body[i].x -= i;
      }
      
      body[l-1].last = true;
      jt = false;
      
      hX = body[0].x;
      hY = body[0].y;
      hI = 0;
      step(sp(3)+"Individ snake INIT finished.");
    }
    
    //{}{}{}{}{}{}{}{}{}{}{}{}XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX{}{}{}{}{}{}{}{}{}{}{}{}{}{} FIX THIS! FIX THIS! FIX THIS! FIX THIS! FIX THIS! FIX THIS! FIX THIS! FIX THIS! FIX THIS! FIX THIS! FIX THIS! FIX THIS! FIX THIS! FIX THIS! FIX THIS! FIX THIS!
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
      step("Individual snake update is called; Hbody x " + this.body[hI].x + ", Hbody y " + this.body[hI].y);
      moveBody();
      step("moveBody() has ran; NEW HEAD: Hbody x " + this.body[hI].x + ", Hbody y " + this.body[hI].y);
      if (this.isEat()) {
        step(sp(2)+"*****iseat called");
        this.score(1);
        this.grow();
        food.respawn();
      }
      
      
      step("about to check is out");
      if (isOut()) {
        step("is out triggered");
        resetSnake(snakeLen);
      }
      
      
    }
    
    //SELF INTERSECTION CHECKER ----------------------------------------------
    
    
    
    boolean isOut() {
      if (this.hX == inD -1 || this.hX == outD || this.hY == inD-1 || this.hY == outD) {
        return true;
      } else {
        return false;
      }
    }
    
    
    void moveBody() {
      delay(100);
      step("moving snake started");
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
          
          hX = body[hI].x;
          hY = body[hI].y;
          break;
        }
      }
      jt = false;
      step("moving snake finished");
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
    
    void translateSnake(int x, int y) {
      stepNC(sp(3)+"Snake translating");
      step(sp(3)+"The input of x and y for this snake are: " + x + " and " + y);
      for (Segment s : this.body) {
        stepNC(sp(4)+"Snake sement coords: "  + " Head X: " + s.x + " Head Y: " + s.y );
        s.x += x;
        s.y += y;
        
        stepNC(sp(4)+"new Snake sement coords"  + " Head X: " + s.x + " Head Y: " + s.y + "\n");
      }
        hX = this.body[hI].x;
        hY = this.body[hI].y;
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
        step(sp(5)+"segment INIT started");
        x = inD + 4;
        y = inD+8;
        step(sp(5)+"segment coords set to: ("+x+", "+y+")");
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
