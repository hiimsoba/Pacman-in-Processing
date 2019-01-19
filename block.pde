class Block {
  // is it a wall?  
  boolean wall = false;  

  // does it have a coin? OwO
  boolean has_coin = false;
  
  // IS IT SPECIAL? kawaiiiiiiiii desuuuuu! <3 <3 <3
  boolean is_special = false;

  // vars for the special coin
  float special_size = 10;
  float special_sin = 0;

  // keep track of its neighbors
  boolean[] neighbors;

  // boring stuff
  PVector position;

  // more boring stufffffffffffffff
  Block(float x, float y) {
    position = new PVector(x, y);
    neighbors = new boolean[4];
  }

  // get the neighbors of the current cell
  void getNeighbors(Board b) {
    // get the current i and j
    int y = floor(position.y / block_height);
    int x = floor(position.x / block_width);
    // and now get its valid neighbors ( up, right, down, left )

    Block[] neighs = new Block[4];

    neighs[0] = b.getBlockAt(x, y - 1);
    neighs[1] = b.getBlockAt(x + 1, y);
    neighs[2] = b.getBlockAt(x, y + 1);
    neighs[3] = b.getBlockAt(x - 1, y);

    for (int i = 0; i < 4; i++) {
      if (neighs[i] == null) {
        neighbors[i] = false;
      } else {
        neighbors[i] = neighs[i].wall;
      }
    }
  }

  // time to draw!
  void display() {
    stroke(wall ? color(25, 25, 166) : 0);
    strokeWeight(wall ? 3 : 0);
    //rect(position.x, position.y, block_width, block_height);

    noFill();

    // if we have a neighbor above, don't draw a line there, otherwise dew it
    if (!neighbors[0]) {
      line(position.x, position.y, position.x + block_width - 1, position.y);
    }
    if (!neighbors[1]) {
      line(position.x + block_width - 1, position.y, position.x + block_width - 1, position.y + block_height - 1);
    }
    if (!neighbors[2]) {
      line(position.x, position.y + block_height - 1, position.x + block_width - 1, position.y + block_height - 1);
    }
    if (!neighbors[3]) {
      line(position.x, position.y, position.x, position.y + block_height - 1);
    }

    // and if it has a coin, draw a white dot or some shit
    if (has_coin) {
      strokeWeight(5);
      stroke(255);
      point(position.x + block_width / 2, position.y + block_height / 2);
    }

    // AND if it is special OwO
    if (is_special) {
      // use the sin to have that breathing effect
      strokeWeight(special_size + 3 * sin(special_sin += 0.1));
      stroke(255);
      point(position.x + block_width / 2, position.y + block_height / 2);
    }
  }
}
