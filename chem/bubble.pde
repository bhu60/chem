class bubble{

float waterHeight;
PVector location;
PVector velocity;
boolean notPop;
bubble(float x, float y, float w){
  location = new PVector(x, y);
  velocity = new PVector(0, random(-1, -2));
  circle(x, y, 5);
  waterHeight = w;
  notPop = true;
}

void move(){
  location.add(velocity);
}

void floatUp(float waterHeight){
  location.add(velocity);
  float r = 10;
  if(location.y - r <= waterHeight){
    location = new PVector(location.x, waterHeight + r + 1);
  }
}

void display(){
  if(notPop){
    fill(227, 210, 27);
    circle(location.x, location.y, (float) 20);
  }
}

}
