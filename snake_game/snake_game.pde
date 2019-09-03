void settings() {
  size(500,500);
}

int gameSt = 1;

int highScore;

int gameSize = 20;
int sqL = 20;

int sqN;
int inD, outD;

Snake snake;
Food food;

void setup() {
  frameRate(20);
  snake = new Snake(3);
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
  snake.move(key);
  
}


//MAIN DRAW LOOP------------------------------------------
void draw() {
  background(169);
  drawGrid();
  food.show();
  
  if (gameSt == 1) {
    snake.update();
  }
  snake.show();
  
  highScoreDraw();
  
  
  if (gameSt == -1) {
    pauseDraw();
  }
}
