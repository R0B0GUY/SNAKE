void drawGrid() {
  fill(0);
  rect(0,0,width,height);
  for (int i = inD; i < outD+1; i++ ) {
    //line(i*sqL,inD*sqL,i*sqL, (outD)*sqL);
    //text(i-inD+1,i*sqL,(inD+1)*sqL);
    //line(inD*sqL, i*sqL, (outD)*sqL, i*sqL);
  }
  fill(20,170,40);
  rect(inD*sqL,inD*sqL,gameSize*sqL,gameSize*sqL);
  
}

void pauseDraw() {
  fill(0);
  rect(200,200,100,100);
  fill(145);
  rect(220,220,20,60);
  rect(260,220,20,60);
}

void controls(char kee) {
  if (kee == 'h') {
    gameSt *= -1;
  } else if (kee == 'r') {
    snakes.restart();
    food.respawn();
  }
    
}

void highScoreDraw() {
  fill(255);
  textSize(25);
  text("HIGH SCORE: " + highScore, 3*sqL, 1*sqL);
}
