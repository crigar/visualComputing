import frames.primitives.*;

import frames.core.*;
import frames.processing.*;

Scene scene;
Maze maze;
boolean drawAxes = true, drawShooterTarget = true, adaptive = true;
PImage label;
PShape sh;

int xPos = 0;
int yPos = 0;

float xRot = 0;
float yRot = 0;

int xMove = 0;
int yMove = 18;

void setup() {
  size(800, 800, P3D);
  maze = new Maze(15,15);
  maze.generate();
  //maze.drawMaze();
  scene = new Scene(this);
  scene.setRadius(200);
  scene.fitBall();
  scene.setType(Graph.Type.ORTHOGRAPHIC);

  scene.fitBallInterpolation();
  
  
  
  
}

void printMaze(){
  
  float x = -180;
  float y = -180;
  float z = 0;
  
  float wallHeight = 24;
  float wallWidht = wallHeight * 0.05;
  
  
  
  for (int i = 0; i < maze.getRows(); i++){
      for (int j = 0; j < maze.getCols(); j++){
        Cell cell = maze.getMaze()[i][j];
        
        if(i == 0){
          pushMatrix();
          translate(x, y, z);
          fill(22,60,7);
          box(wallHeight, wallWidht, wallHeight);
          popMatrix();
        }
        
        //top
        if( cell.getWalls().get("top") == 1 ){
          pushMatrix();
          translate(x, y, z);
          fill(22,60,7);
          box(wallHeight, wallWidht, wallHeight);
          popMatrix();
        }
        
        //right
        if( cell.getWalls().get("right") == 1 ){
          pushMatrix();
          translate(x + (wallHeight/2), y + (wallHeight/2), z);
          fill(22,60,7);
          box(wallWidht, wallHeight, wallHeight);
          popMatrix();
        }
        
        //bottom
        if( cell.getWalls().get("bottom") == 1 ){
          pushMatrix();
          translate(x, y + wallHeight, z);
          fill(22,60,7);
          box(wallHeight, wallWidht, wallHeight);
          popMatrix();
        }
        
        //left
         
        if( cell.getWalls().get("left") == 1 ){
          pushMatrix();
          translate(x - (wallHeight / 2), y + (wallHeight/2), z);
          fill(22,60,7);
          box(wallWidht, wallHeight, wallHeight);
          popMatrix();
        }
        
        //floor
        
        
        pushMatrix();
        translate(x,y + ( wallHeight/2 ), z - ( wallHeight/2 ) );
        fill(50, 50, 200);
        box( wallHeight, wallHeight  , wallWidht );
        popMatrix();
        
        x = x + wallHeight;
      }
      x = -180;
      y = y + wallHeight;
  }
  
  
}

void draw() {
  background(255);
  //pointLight(200, 200, 200, 0, 0, 100);
  printMaze(); 
  
}

void mouseMoved() {
  scene.cast();
}

void mouseDragged() {
  if (mouseButton == LEFT)
    scene.spin();
  else if (mouseButton == RIGHT)
    scene.translate();
  else
    scene.scale(mouseX - pmouseX);
}

void mouseWheel(MouseEvent event) {
  scene.zoom(event.getCount() * 20);
}
void mouseClicked() {
  print(mouseX);
}
void keyPressed() {
  switch (key) {
  case ENTER:
    xPos = -180;
    yPos = 40;
    scene.eye().setPosition(new Vector(xPos,yPos,0));
    //scene.rotate(110,0,0);
    break;
  case 'w':
    
    xPos = xPos + xMove;
    yPos = yPos - yMove;
    scene.eye().setPosition(new Vector(xPos,yPos,0));
    break;
  case 'd':
    yRot = yRot - 0.01;
    xMove = xMove + 1;
    yMove = yMove - 1;
    scene.rotate(0,yRot,0);
    break;
  case 's':
    yPos = yPos + yMove;
    scene.eye().setPosition(new Vector(xPos,yPos,0));
    break;
  case 'a':
    yRot = yRot + 0.01;
    scene.rotate(0,yRot,0);
    break;
  
  }
}
