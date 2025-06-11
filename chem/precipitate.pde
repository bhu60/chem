class precipitate{
PVector location;
PVector velocity;
int temp;
int originalTemp;

precipitate(float x, float y, int t, int oT){
  location = new PVector(x, y);
  temp = t;
  originalTemp = oT;
  float basic = max(1, (temp - originalTemp) / 10);
  velocity = new PVector(random(-0.2, 0.2), random(0.5, 1.5) * basic);
}

void move(){
  location.add(velocity);
  float basic = max(1, (temp - originalTemp) / 10);
  velocity = new PVector(random(-0.2, 0.2), random(0.5, 1.5) * basic);
}

void display(){
  noStroke();
  fill(255);
  rect(location.x, location.y, 15, 15);
} 

void bounce(){
  float r = 15;
  if(location.x + r >= 844){
    location = new PVector(844 - r - 1, location.y);
    velocity = new PVector(velocity.x * -1, velocity.y);
  }

  if(location.x - r <= 359){
    location = new PVector(359 + r + 1, location.y);
    velocity = new PVector(velocity.x * -1, velocity.y);
  }
  if(location.y + r >= 871){
    location = new PVector(location.x, 871 - r - 1);
    velocity = new PVector(0, 0);
  }
}
}
