//FOOD CLASS -------------------------------------------------------------
class Food {
  int x,y;
  
  Food() {
    x = int(random(inD,outD));
    y = int(random(inD,outD));
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
    }
  }
}
