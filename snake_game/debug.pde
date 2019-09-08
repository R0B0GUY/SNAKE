void step(String s) {
  if (debug == 1) {
    stepCount ++;
    println(stepCount + ": " + s);
  }
}

void step() {
  stepCount ++;
}

void stepNC(String s) {
  if (debug == 1) {
    
    println(stepCount + ": " + s);
  }
}

void printAllSegCoords() {
    for (int i = 0; i < gameMode; i++) {
      step("first part okay in print all seg");
          println(" ");
          println("printing snake " + i + "'s part coords");
          for (int seg = 0; seg < startSnakeLenght; seg++) {
            println(" ");
            println(snakes.lizards[i].body[seg].x + ", " + snakes.lizards[i].body[seg].y);
            println(" ");
          }
    }
  }
  
  
  String sp(int n) {
    String s = " ";
    if (n==0) {
      return "";
    } else {
        s = "  ";
      
      for (int i = 0; i < n-1; i++) {
        s += s;
      }
    }
    
    return s;
    
    //return "";
  }
