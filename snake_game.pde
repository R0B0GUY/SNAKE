void settings() {
  size(500,500);
}

int gameSize = 20;

int sqL = 20;
int gameSt = 1;
int tailX, tailY;
int sqN;
int inD, outD;
int highScore;
Snake snake;
Food food;

void setup() {
  frameRate(20);
  snake = new Snake(3);
  sqN = floor(width/sqL);
  inD = floor(sqN/2)-floor(gameSize/2)+1;
  outD = inD + gameSize;
  food = new Food();
  highScore = 0;
}






void draw() {
  background(169);
  drawGrid();
  
  
  if (gameSt == 1) {
    snake.update();
  }
  
  
  food.show();
  snake.show();
  snake.scoreDraw();
  highScoreDraw();
  
  
  if (gameSt == -1) {
    pauseDraw();
  }
}





void keyPressed() {
  println(key);
  controls(key);
  snake.move(key);
  
}
