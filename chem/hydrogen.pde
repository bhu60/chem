class hydrogen{

float waterHeight;
PVector location;
PVector velocity = new PVector(random(-2, 2), random(-2, 2));
hydrogen(float x, float y, float w){
  location = new PVector(x, y);
  circle(x, y, 5);
  waterHeight = w;
}

void move(){
  location.add(velocity);
}

void bounce(float waterHeight){
  float r = 10;
  if(location.x + r >= 545){
    location = new PVector(545 - r - 1, location.y);
    velocity = new PVector(velocity.x * -1, velocity.y);
  }

  if(location.x - r <= 285){
    location = new PVector(285 + r + 1, location.y);
    velocity = new PVector(velocity.x * -1, velocity.y);
  }
  if(location.y + r >= 585){
    location = new PVector(location.x, 585 - r - 1);
    velocity = new PVector(velocity.x, velocity.y * -1);
  }
  if(location.y - r <= 493 + (100 - waterHeight)){
    location = new PVector(location.x, 493 + (100 - waterHeight) + r + 1);
    velocity = new PVector(velocity.x, velocity.y * -1);
  }
}

void display(){
  fill(227, 210, 27);
  circle(location.x, location.y, (float) 10);
}

}
