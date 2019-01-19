// 21x21 grid
final int rows = 21;
final int cols = 21;

float block_width;
float block_height;

Board board;
Player player;

void setup() {
  // init the window
  size(0, 0);
  //fullScreen();

  // looks best if it's a square window, but can be resized
  int w = 600;//floor(displayWidth * 0.75);
  int h = 600;//floor(displayHeight * 0.75);

  //println(w + " " + h);

  // adapt the resolution of the window to be divisible by the number of rows and columns
  for (; w >= 0; w--) {
    if (w % cols == 0) {
      break;
    }
  }  

  for (; h >= 0; h--) {
    if (h % rows == 0) {
      break;
    }
  }

  //println(w + " " + h);

  // and reset the window to have the correct dimensions
  surface.setSize(w, h);
  size(w, h);
  surface.setLocation(0, 0);

  // set the width and height of a single block
  block_width = (float) width / cols;
  block_height = (float) height / rows;

  //println(block_width, block_height);

  // set up the board
  board = new Board(rows, cols);
  board.init();

  // add the walls, coins and "special" coins
  addWalls(board);
  addCoins(board);
  addSpecial(board);

  // and get the neighbors of each block
  board.getBlockNeighbors();

  // set up the player
  player = new Player(15, 10);

  // limit the framerate
  frameRate(60);
}

void draw() {
  // reset the background
  background(0);

  // render and update the objects
  board.render();
  player.update(board);
  player.display();

  // stop the game if the player got all the points
  if (player.score == total_points) {
    noLoop();
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(32); 
    // comic sans is the best font
    textFont(createFont("Comic Sans MS", 32, true));
    text("gg, you're a true mad lad", width / 2, height / 2);
  }
}
