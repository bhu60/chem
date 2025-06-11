class smoke{
PVector location;
PVector velocity;
float time;
color col;
boolean clear;
 
smoke(float x, float y){
  location = new PVector(x, y);
  velocity = new PVector(0, random(-2, -4));
  time = 255;
  col = color(80, 80, 80, time);
  clear = false;
}

void move(){
  location.add(velocity);
  time -= 0.9;
  col = color(110, 110, 110, time);
  if(time <= 0){
    clear = true;
  }
  int r = 20;
  if(location.x + r >= 850){
    location = new PVector(850 - r - 1, location.y);
    velocity = new PVector(velocity.x * -1, velocity.y);
  }

  if(location.x - r <= 300){
    location = new PVector(300 + r + 1, location.y);
    velocity = new PVector(velocity.x * -1, velocity.y);
  }
}

void display(){
  noStroke();
  fill(col);
  circle(location.x, location.y, 20);
}

}
