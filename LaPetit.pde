ArrayList<Circle> circles;
ArrayList<Point> points;
boolean hasBeenPressed;

void setup(){
  size(1000,1000);
  circles = new ArrayList<Circle>();
  points = new ArrayList<Point>();
  //creates all the points you will ever need
  for(int x = 0; x < width; x++){
    for(int y = 0; y < height; y++){
      points.add(new Point(x,y));
    }
  }
  hasBeenPressed = false;
  ellipseMode(RADIUS);
  //noStroke();
  background(color(0));
  //createCircle(10,10,50.0);
}

class Point{
  int x; int y;
  
  Point(int x, int y){
    this.x = x; this.y = y;
  }
}

class Circle{
  double pX; double pY;
  double radius;
  
  Circle(double pX, double pY, double radius){
    this.pX = pX; this.pY = pY;
    this.radius = radius;
  }
}

double getDist(double aX, double aY, double bX, double bY){
  return sqrt(pow((float)(aX-bX),2) + pow((float)(aY-bY),2));
}

double findMaxRadius(double x, double y){
  double maxRad = Float.MAX_VALUE;
  for(Circle circle: circles){
    double distTo = getDist(x,y,circle.pX,circle.pY)-circle.radius;
    if(distTo < 0){
      return -1;
    }
    if(distTo < maxRad){
      maxRad = distTo;
    }
  }
  float val;
  val = min(abs((float)x-width),(float)x);
  if(val < maxRad){maxRad = val;}
  val = min(abs((float)y-height),(float)y);
  if(val < maxRad){maxRad = val;}
  return maxRad;
}

void keyPressed(){
  if(key == ' '){
    drawLargest();
  }
}

void createCircle(int x, int y, float radius){
  //println(circles.size());
  int stack = 5;
  if(circles.size() >= stack){
    Circle circ = circles.get(circles.size()-stack);
    fill(color(255));
    ellipse((float)circ.pX,(float)circ.pY,(float)circ.radius,(float)circ.radius);
  }
  fill(color(255,0,0));
  //fill(color(random(255),random(255),random(255)));
  ellipse((float)x,(float)y,(float)radius,(float)radius);
  circles.add(new Circle(x,y,radius));
  //int stepSize = points.size()/1000+1; //This is fantastic, it's such a hack, but it works
  //println(points.size());
  //for(int i = 0; i < points.size(); i+=1000){
  //  Point pnt = points.get(i);
  //  if(getDist((double)x,(double)y,(double)pnt.x,(double)pnt.y) < radius){
  //    //points.remove(i);
  //  }
  //}
}

void drawLargest(){
  double bestX = -1; double bestY = -1;
  double bestRadius = -Double.MAX_VALUE;
  //for(int x = 0; x < width; x++){
  //  for(int y = 0; y < height; y++){
  //println(points.size());
  for(int i = 0; i < points.size(); i++){
    Point pnt = points.get(i);
    double rad = findMaxRadius(pnt.x,pnt.y);
    if(rad > bestRadius){
      bestX = pnt.x; bestY = pnt.y;
      bestRadius = rad;
    }
  }
  //  }
  //}
  //if(bestRadius > 0)
  createCircle((int)bestX,(int)bestY,(float)bestRadius);
  //ellipse((float)bestX,(float)bestY,(float)bestRadius,(float)bestRadius);
  //circles.add(new Circle(bestX,bestY,bestRadius));
}

void mousePressed(){
  double x = mouseX; double y = mouseY;
  double radius = findMaxRadius(x,y);
  //if(radius >= 0){
    fill(color(255,0,0));
    createCircle((int)x,(int)y,(float)radius);
    
    //ellipse((float)x,(float)y,(float)radius,(float)radius);
    //circles.add(new Circle(x,y,radius));
  //}
  hasBeenPressed = true;
  //print(radius);
  //ellipse(mouseX,mouseY,10,10);
}

void draw(){
  if(hasBeenPressed){
    drawLargest();
  }
}
