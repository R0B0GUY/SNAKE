void settings() {
  size(500,500);
}

int gameSt = 1;

int highScore;

int gameSize = 20;
int sqL = 20;

int sqN;
int inD, outD;

Snakes snakes;
Food food;

void setup() {
  frameRate(20);
  snakes = new Snakes(2);
  sqN = floor(width/sqL);
  inD = floor(sqN/2)-floor(gameSize/2)+1;
  outD = inD + gameSize;
  food = new Food(2);
  highScore = 0;
}


//KEYSSTROKE Listener------------------------------------
void keyPressed() {
  //println(key);
  controls(key);
  snakes.move(key);
  
}


//MAIN DRAW LOOP------------------------------------------
void draw() {
  background(169);
  drawGrid();
  food.show();
  
  if (gameSt == 1) {
    snakes.update();
  }
  snakes.show();
  
  highScoreDraw();
  
  
  if (gameSt == -1) {
    pauseDraw();
  }
}
