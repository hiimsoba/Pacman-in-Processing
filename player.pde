class Player {

  PVector position;
  // diameter will be 75% of the minimum side of the width / height of a block... i believe?
  final float diameter = 0.75 * Math.min(width, height) / (width < height ? cols : rows);

  int score = 0;

  // 1 is up
  // 2 is right
  // 3 is down
  // 4 is left
  // so... go left, initially, i guess
  int dir = 4;
  int desired_dir = 0;

  // some arbitrary velocity
  float velocity = 3;

  // a pixel threshold 
  float threshold = 4;

  Player(int y, int x) {
    // y and x are the same as an usual block, but we add half of each dimension's size to center the player, which will be an ellipse
    position = new PVector(x * block_width + block_width * 0.5, y * block_height + block_height * 0.5);
  }

  void set_dir(int new_dir) {
    // update the desired direction
    desired_dir = new_dir;
  }

  void update(Board b) {
    float x = position.x;
    float y = position.y;

    // first check if we went off the map ( left or right )
    if (x + block_width / 2 < 0) {
      position.x = width + block_width / 2;
      dir = 4;
      return;
    } else if (x - block_width / 2 > width) {
      position.x = 0 - block_width / 2;
      dir = 2;
      return;
    }

    // find its 4 neighbors ( the blocks above, below, to the right and to the left of the player )
    Block[] neighbors = new Block[4];
    // top, right, bottom, left
    neighbors[0] = b.getBlockAt(floor(x / block_width), floor((y - block_height) / block_height));
    neighbors[1] = b.getBlockAt(floor((x + block_width) / block_width), floor(y / block_height));
    neighbors[2] = b.getBlockAt(floor(x / block_width), floor((y + block_height) / block_height));
    neighbors[3] = b.getBlockAt(floor((x - block_width) / block_width), floor(y / block_height));

    Block current = b.getBlockAt(floor(x / block_width), floor(y / block_height));

    if (current == null) {
      if (position.x <= 0 || position.x >= width) {
        if (dir == 2) {
          position.x += velocity;
        } else if (dir == 4) {
          position.x -= velocity;
        }
        return;
      } else {
        println("well, you're screwed, mon ami");
        return;
      }
    }

    // if we're like in the middle of the current block and it has a coin or has a special thingie, remove it
    if (current.has_coin || current.is_special) {
      if (abs(position.y - (current.position.y + block_height / 2)) <= threshold && abs(position.x - (current.position.x + block_width  / 2)) <= threshold) {
        score++;
        current.has_coin = false;
        current.is_special = false;
      }
    }
    if (debug) {
      // draw them to debug
      for (int i = 0; i < neighbors.length; i++) {
        fill(int(neighbors[i].wall) * 255, (1 - int(neighbors[i].wall)) * 255, 0);
        rect(neighbors[i].position.x, neighbors[i].position.y, block_width, block_height);
      }
      fill(255);
      rect(current.position.x, current.position.y, block_width, block_height);
    }

    // if the desired direction is different than our actual direction
    if (desired_dir != 0 && desired_dir != dir) {
      // first check if the desired direction is the opposite of the current direction
      // if it is, then just reverse it
      if (abs(desired_dir - dir) == 2) {
        dir = desired_dir;
      } else if (neighbors[desired_dir - 1] != null && !neighbors[desired_dir - 1].wall) {
        if (abs(position.y - (current.position.y + block_height / 2)) <= threshold && abs(position.x - (current.position.x + block_width  / 2)) <= threshold) {
          dir = desired_dir;
          desired_dir = 0;
        }
      }
    }

    // no idea what's happening here at this point
    if (dir == 1) {
      if (neighbors[dir - 1] != null && neighbors[dir - 1].wall && abs(position.y - (current.position.y + block_height / 2)) <= threshold) {
        position.y = current.position.y + block_height / 2;
        return;
      }
      position.y -= velocity;
    } else if (dir == 2) {
      if (neighbors[dir - 1] != null && neighbors[dir - 1].wall && abs(position.x - (current.position.x + block_width / 2)) <= threshold) {
        position.x = current.position.x + block_width / 2;
        return;
      }
      position.x += velocity;
    } else if (dir == 3) {
      if (neighbors[dir - 1] != null && neighbors[dir - 1].wall && abs(position.y - (current.position.y + block_height / 2)) <= threshold) {
        position.y = current.position.y + block_height / 2;
        return;
      }
      position.y += velocity;
    } else if (dir == 4) {
      if (neighbors[dir - 1] != null && neighbors[dir - 1].wall && abs(position.x - (current.position.x + block_width / 2)) <= threshold) {
        position.x = current.position.x + block_width / 2;
        return;
      }
      position.x -= velocity;
    }
  }

  // yo.. display the pacman! insane.
  void display() {
    noStroke();
    fill(255, 238, 0);
    ellipse(position.x, position.y, diameter, diameter);
  }
}
