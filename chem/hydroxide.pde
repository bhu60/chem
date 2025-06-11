class hydroxide{

float waterHeight;
PVector location;
PVector velocity = new PVector(random(-2, 2), random(-2, 2));
float angle;
float totalR = 40;
float bigR = 20;
float smallR = 10;

hydroxide(float x, float y, float w){
  location = new PVector(x, y);
  circle(x, y, 5);
  waterHeight = w;
  angle = random(2 * (float) Math.PI);
}

void move(){
  location.add(velocity);
  angle += 0.01;
}

void bounce(float waterHeight){
  float r = totalR;
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
  fill(222, 228, 252);
  circle(location.x, location.y, bigR);
  fill(227, 210, 27);
  circle(location.x + totalR * cos(angle), location.y + totalR * sin(angle), smallR);
}

}
