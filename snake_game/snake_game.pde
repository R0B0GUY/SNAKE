void settings() {
  size(500,500);

}
/*
The game state determines what part of the game code is run
-1 means the game is paused and the puse draw runs
1 the game is running normally
*/
int gameMode = 2;
int gameSt = 1;


int highScore;

//this is the number of squares across of the game
int gameSize = 40;
//this is the pixel length of each square
int sqL = 10;

//this is the number of squares that will fit onto the screen going across
int sqN;
/*
this is the game coord boundaries of the game 
inD is how much to go in from top and from left for 
outD is where the game area ends
*/
int inD, outD;

//creates the snake group object from class
Snakes snakes;

//creates food group object from class
Food food;

void setup() {
    frameRate(30);
    
    
  //INIT snakes group with 2 snakes; does not work with 1 snake ATM lol
  snakes = new Snakes(gameMode);
  
  //INIT square Num
  sqN = floor(width/sqL);
  //INIT inside Distance
  inD = floor(sqN/2)-floor(gameSize/2)+1;
  //INIT outside Distance
  outD = inD + gameSize;
  //INIT food group with 2 food
  food = new Food(20);
  
  highScore = 0;
}


//KEYSSTROKE Listener------------------------------------
void keyPressed() {
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
    //pauseDraw();
  }
}
