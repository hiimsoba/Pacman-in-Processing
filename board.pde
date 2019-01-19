class Board {

  // board dimensions
  int rows;
  int cols;

  // keep its blocks
  ArrayList<Block> blocks;

  // constructor
  Board(int _rows, int _cols) {
    // just set the dimensions
    rows = _rows;
    cols = _cols;
    // and initialize the blocks array list
    blocks = new ArrayList<Block> ();
  }

  // create the blocks array list
  void init() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        blocks.add(new Block(j * block_width, i * block_height));
      }
    }
  }

  // get the neighbors of each block
  void getBlockNeighbors() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        getBlockAt(j, i).getNeighbors(this);
      }
    }
  }

  // returns the block at (j, i)
  // j first 'cuz i thought about it as being (x, y)
  Block getBlockAt(int j, int i) {
    if (j < 0 || i < 0 || j >= cols || i >= rows) {
      return null;
    }
    return blocks.get(i * rows + j);
  }

  // render the board
  void render() {
    for (Block b : blocks) {
      b.display();
    }
  }
}
