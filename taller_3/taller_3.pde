import nub.primitives.*;
import nub.core.*;
import nub.processing.*;

import java.util.Collections;
import java.util.List;
import java.util.ArrayList;
import java.lang.Math.*;

// 1. Nub objects
Scene scene;
Node node;
Vector v1, v2, v3;
// timing
TimingTask spinningTask;
boolean yDirection;
// scaling is a power of 2
int n = 4;

// 2. Hints
boolean triangleHint = true;
boolean gridHint = true;
boolean debug = true;
boolean shadeHint = false;
boolean antialising = true;
boolean colorized = false;

// 3. Use FX2D, JAVA2D, P2D or P3D
String renderer = P2D;

// 4. Window dimension
int dim = 9;

void settings() {
  size(int(pow(2, dim)), int(pow(2, dim)), renderer);
}

void setup() {
  rectMode(CENTER);
  scene = new Scene(this);
  if (scene.is3D())
    scene.setType(Scene.Type.ORTHOGRAPHIC);
  scene.setRadius(width/2);
  scene.fit(1);

  // not really needed here but create a spinning task
  // just to illustrate some nub timing features. For
  // example, to see how 3D spinning from the horizon
  // (no bias from above nor from below) induces movement
  // on the node instance (the one used to represent
  // onscreen pixels): upwards or backwards (or to the left
  // vs to the right)?
  // Press ' ' to play it
  // Press 'y' to change the spinning axes defined in the
  // world system.
  spinningTask = new TimingTask(scene) {
    @Override
    public void execute() {
      scene.eye().orbit(scene.is2D() ? new Vector(0, 0, 1) :
        yDirection ? new Vector(0, 1, 0) : new Vector(1, 0, 0), PI / 100);
    }
  };

  node = new Node();
  node.setScaling(width/pow(2, n));

  // init the triangle that's gonna be rasterized
  randomizeTriangle();
}

void draw() {
  background(0);
  stroke(0, 255, 0);
  if (gridHint)
    scene.drawGrid(scene.radius(), (int)pow(2, n));
  if (triangleHint)
    drawTriangleHint();
  push();
  scene.applyTransformation(node);
  triangleRaster();
  pop();
}

// Implement this function to rasterize the triangle.
// Coordinates are given in the node system which has a dimension of 2^n
void triangleRaster() {
  // node.location converts points from world to node
  // here we convert v1 to illustrate the idea
  
  
  //-- GabrielEBD toma de los puntos 
  int x1,x2,x3,y1,y2,y3;
  x1 = round(node.location(v1).x());
  x2 = round(node.location(v2).x());
  x3 = round(node.location(v3).x());
  
  y1 = round(node.location(v1).y());
  y2 = round(node.location(v2).y());
  y3 = round(node.location(v3).y());
  
  //-- GabrielEBD metodo para encontrar los puntos mas lejanos y cercanos 
  List<Integer> ListX = new ArrayList<Integer>();
  List<Integer> ListY = new ArrayList<Integer>();
  ListX.add(round(node.location(v1).x()));
  ListX.add(round(node.location(v2).x()));
  ListX.add(round(node.location(v3).x()));

  ListY.add(round(node.location(v1).y()));
  ListY.add(round(node.location(v2).y()));
  ListY.add(round(node.location(v3).y()));
  Collections.sort(ListX);
  Collections.sort(ListY);
  
  //-- maximos y minimos para limites en el el for()
  int minX = ListX.get(0);
  int maxX = ListX.get(2);
  int minY = ListY.get(0);
  int maxY = ListY.get(2);
  
  //---------------- para pintarlo 
  int cX = round((x1+x2+x3)/3);
  int cY = round((y1+y2+y3)/3);
  int red,blue,green;
  
  double  CV1 = Math.pow((Math.pow((x1-cX),2)+Math.pow((y1-cY),2)),0.5);
  double  CV2 = Math.pow((Math.pow((x2-cX),2)+Math.pow((y2-cY),2)),0.5);
  double  CV3 = Math.pow((Math.pow((x3-cX),2)+Math.pow((y3-cY),2)),0.5);
          
  //----------------
  
  if (debug) {
    push();
    
    for(int i = minX-1;i<=maxX;i++){
      for(int j = minY-1; j<= maxY;j++){
        
        //-- ecuaciones para la orientacion de del tringulo principal y los triangulos que se forman con respecto al punto (i,j)
        //-- ref : http://www.dma.fi.upm.es/personal/mabellanas/tfcs/kirkpatrick/Aplicacion/algoritmos.htm
        int general = (x1-x3)*(y2-y3)-(y1-y3)*(x2-x3)>0? 1:-1;
        int t1 = (x1-i)*(y2-j)-(y1-j)*(x2-i)>0? 1:-1;
        int t2 = (x2-i)*(y3-j)-(y2-j)*(x3-i) >0? 1:-1;
        int t3 = (x3-i)*(y1-j)-(y3-j)*(x1-i)>0? 1:-1;
        // si tienen la misma orientacion entonces el punto esta dentro del trangulo y lo pinta 
        if(!antialising && general == t1 && t1 == t2 && t2 == t3){
          noStroke();
          
          //******* para pintarlo 
          double  distanceV1 = Math.pow((Math.pow((x1-i),2)+Math.pow((y1-j),2)),0.5);
          double  distanceV2 = Math.pow((Math.pow((x2-i),2)+Math.pow((y2-j),2)),0.5);
          double  distanceV3 = Math.pow((Math.pow((x3-i),2)+Math.pow((y3-j),2)),0.5);
          
          double pv1 = distanceV1/CV1> 1? 0:1-distanceV1/CV1;
          double pv2 = distanceV2/CV2> 1? 0:1-distanceV2/CV2;
          double pv3 = distanceV3/CV3> 1? 0:1-distanceV3/CV3;
          //*******
          ////////////////////////////////////////////////////////////////////
          int g = (x1-x3)*(y2-y3)-(y1-y3)*(x2-x3);
          int A = (x1-i)*(y2-j)-(y1-j)*(x2-i);
          int B = (x2-i)*(y3-j)-(y2-j)*(x3-i);
          int C = (x3-i)*(y1-j)-(y3-j)*(x1-i);
          double genA = A/(A+B+C+0.0);
          double genB = B/(A+B+C+0.0);
          double genC = C/(A+B+C+0.0);
          fill((float)(255*(genA)),(float)(255*(genB)),(float)(255*(genC)),200);
          
          /////////////////////////////////////////////////////////
          
          
          //fill((float)(255*(pv1)),(float)(255*(pv2)),(float)(255*(pv3)),200);
          //fill((((x1-i)*(y2-j)-(y1-j)*(x2-i))/((x1-x3)*(y2-y3)-(y1-y3)*(x2-x3))), ((x2-i)*(y3-j)-(y2-j)*(x3-i))/((x1-x3)*(y2-y3)-(y1-y3)*(x2-x3)), ((x3-i)*(y1-j)-(y3-j)*(x1-i))/((x1-x3)*(y2-y3)-(y1-y3)*(x2-x3)), 125);
          square(i, j, 1);
        }
      }
    }
    
    noStroke();
    fill(255, 0, 0, 125);
    square(round(node.location(v1).x()), round(node.location(v1).y()), 1);
    fill(0, 255, 0, 125);
    square(round(node.location(v2).x()), round(node.location(v2).y()), 1);
    fill(0, 0, 255, 125);
    square(round(node.location(v3).x()), round(node.location(v3).y()), 1);
    
    pop();
  }
  if(antialising){
    for(int i = minX-1;i<=maxX;i++){
      for(int j = minY-1; j<= maxY;j++){
        double percentage = 0;
        int c11 = (y1-y2)*(i-0.5)+(x2-x1)*(j-0.5)+(x1*y2-y1*x2) >0? 1:-1;
        int c12 = (y2-y3)*(i-0.5)+(x3-x2)*(j-0.5)+(x2*y3-y2*x3) >0? 1:-1;
        int c13 = (y3-y1)*(i-0.5)+(x1-x3)*(j-0.5)+(x3*y1-y3*x1) >0? 1:-1;
        
        int c21 = (y1-y2)*(i+0.5)+(x2-x1)*(j-0.5)+(x1*y2-y1*x2) >0? 1:-1;
        int c22 = (y2-y3)*(i+0.5)+(x3-x2)*(j-0.5)+(x2*y3-y2*x3) >0? 1:-1;
        int c23 = (y3-y1)*(i+0.5)+(x1-x3)*(j-0.5)+(x3*y1-y3*x1) >0? 1:-1;
        
        int c31 = (y1-y2)*(i-0.5)+(x2-x1)*(j+0.5)+(x1*y2-y1*x2) >0? 1:-1;
        int c32 = (y2-y3)*(i-0.5)+(x3-x2)*(j+0.5)+(x2*y3-y2*x3) >0? 1:-1;
        int c33 = (y3-y1)*(i-0.5)+(x1-x3)*(j+0.5)+(x3*y1-y3*x1) >0? 1:-1;
        
        int c41 = (y1-y2)*(i+0.5)+(x2-x1)*(j+0.5)+(x1*y2-y1*x2) >0? 1:-1;
        int c42 = (y2-y3)*(i+0.5)+(x3-x2)*(j+0.5)+(x2*y3-y2*x3) >0? 1:-1;
        int c43 = (y3-y1)*(i+0.5)+(x1-x3)*(j+0.5)+(x3*y1-y3*x1) >0? 1:-1;
        
        if(c11==c12 && c12==c13){
          percentage += 0.25;
        }
        if(c21==c22 && c22==c23){
          percentage += 0.25;
        }
        if(c31==c32 && c32==c33){
          percentage += 0.25;
        }
        if(c41==c42 && c42==c43){
          percentage += 0.25;
        }
        if(percentage > 0){
          if(colorized){
            noStroke();
            int A = (x1-i)*(y2-j)-(y1-j)*(x2-i);
            int B = (x2-i)*(y3-j)-(y2-j)*(x3-i);
            int C = (x3-i)*(y1-j)-(y3-j)*(x1-i);
            double genA = A/(A+B+C+0.0);
            double genB = B/(A+B+C+0.0);
            double genC = C/(A+B+C+0.0);
            fill((float)(255*(genA)*percentage),(float)(255*(genB)*percentage),(float)(255*(genC)*percentage),200);
            //fill((((x1-i)*(y2-j)-(y1-j)*(x2-i))/((x1-x3)*(y2-y3)-(y1-y3)*(x2-x3))), ((x2-i)*(y3-j)-(y2-j)*(x3-i))/((x1-x3)*(y2-y3)-(y1-y3)*(x2-x3)), ((x3-i)*(y1-j)-(y3-j)*(x1-i))/((x1-x3)*(y2-y3)-(y1-y3)*(x2-x3)), 125);
            square(i, j, 1);
          }else{
            noStroke();
            fill((int) (255-255*percentage));
            square(i, j, 1);
          }
        }
      }
    }
  }
  strokeWeight(5);
  stroke(255, 0, 0);
  point(v1.x(), v1.y());
  stroke(0, 255, 0);
  point(v2.x(), v2.y());
  stroke(0, 0, 255);
  point(v3.x(), v3.y());
}

void randomizeTriangle() {
  int low = -width/2;
  int high = width/2;
  v1 = new Vector(random(low, high), random(low, high));
  v2 = new Vector(random(low, high), random(low, high));
  v3 = new Vector(random(low, high), random(low, high));
}

void drawTriangleHint() {
  push();

  if(shadeHint)
    noStroke();
  else {
    strokeWeight(2);
    noFill();
  }
  beginShape(TRIANGLES);
  if(shadeHint)
    fill(255, 0, 0);
  else
    stroke(255, 0, 0);
  vertex(v1.x(), v1.y());
  if(shadeHint)
    fill(0, 255, 0);
  else
    stroke(0, 255, 0);
  vertex(v2.x(), v2.y());
  if(shadeHint)
    fill(0, 0, 255);
  else
    stroke(0, 0, 255);
  vertex(v3.x(), v3.y());
  endShape();

  strokeWeight(5);
  stroke(255, 0, 0);
  point(v1.x(), v1.y());
  stroke(0, 255, 0);
  point(v2.x(), v2.y());
  stroke(0, 0, 255);
  point(v3.x(), v3.y());

  pop();
}

void keyPressed() {
  if (key == 'g')
    gridHint = !gridHint;
  if (key == 't')
    triangleHint = !triangleHint;
  if (key == 's')
    shadeHint = !shadeHint;
  if (key == 'd')
    debug = !debug;
  if (key == '+') {
    n = n < 7 ? n+1 : 2;
    node.setScaling(width/pow( 2, n));
  }
  if (key == '-') {
    n = n >2 ? n-1 : 7;
    node.setScaling(width/pow( 2, n));
  }
  if (key == 'r')
    randomizeTriangle();
  if (key == ' ')
    if (spinningTask.isActive())
      spinningTask.stop();
    else
      spinningTask.run();
  if (key == 'y')
    yDirection = !yDirection;
  if (key == 'a')
    antialising = !antialising;
  if (key == 'c')
    colorized = !colorized;
}
