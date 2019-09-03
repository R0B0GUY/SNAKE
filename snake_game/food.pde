//FOOD CLASS -------------------------------------------------------------
class Food {
  
  Apple[] apples;
  int count;
  Food(int a) {
    apples = new Apple[a];
    
    for (int i = 0; i < a; i++) {
      apples[i] = new Apple();
      count = apples.length;
    }
  }
  
  void respawn() {
    for (int i = 0; i < count; i++) {
      if (apples[i].eaten) {
        apples[i].respawn();
      }
    }
  }
  
  void show() {
    for (int i = 0; i < count; i++) {
      if (!apples[i].eaten) {
        apples[i].show();
      }
    }
    
  }
  
  boolean checkMonch(int hx, int hy) {
    for (Apple red : apples) {
      if (red.x == hx && red.y == hy) {
        
        red.eaten = true;
        return true;
      }
    }
    return false;
  }
  
  class Apple {
    int x,y;
    boolean eaten;
    Apple() {
      x = int(random(inD,outD));
      y = int(random(inD,outD));
      eaten = false;
      
      for (int i = 0; i < snake.l; i++) {
        if (snake.body[i].x == this.x && snake.body[i].y == this.y) {
          this.respawn();
        }
      }
    }
    
    void show() {
      fill(255,0,0);
      rect(this.x*sqL,this.y*sqL,sqL,sqL);
      //get coords of food here.
    }
    void respawn() {
      this.x = int(random(inD,outD));
      this.y = int(random(inD,outD));
      
      for (int i = 0; i < snake.l; i++) {
        if (snake.body[i].x == this.x && snake.body[i].y == this.y) {
          this.respawn();
        }
        
        this.eaten = false;
      }
    }
  }
}
