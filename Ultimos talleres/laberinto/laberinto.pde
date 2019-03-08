import frames.primitives.*;

import frames.core.*;
import frames.processing.*;

Scene scene;
Maze maze;
boolean drawAxes = true, drawShooterTarget = true, adaptive = true;

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
          box(wallHeight, wallWidht, wallHeight);
          popMatrix();
        }
        
        //top
        if( cell.getWalls().get("top") == 1 ){
          pushMatrix();
          translate(x, y, z);
          box(wallHeight, wallWidht, wallHeight);
          popMatrix();
        }
        
        //right
        if( cell.getWalls().get("right") == 1 ){
          pushMatrix();
          translate(x + (wallHeight/2), y + (wallHeight/2), z);
          box(wallWidht, wallHeight, wallHeight);
          popMatrix();
        }
        
        //bottom
        if( cell.getWalls().get("bottom") == 1 ){
          pushMatrix();
          translate(x, y + wallHeight, z);
          box(wallHeight, wallWidht, wallHeight);
          popMatrix();
        }
        
        //left
         
        if( cell.getWalls().get("left") == 1 ){
          pushMatrix();
          translate(x - (wallHeight / 2), y + (wallHeight/2), z);
          fill(255);
          box(wallWidht, wallHeight, wallHeight);
          popMatrix();
        }
        
        //floor
        
        pushMatrix();
        translate(x,y + ( wallHeight/2 ), z - ( wallHeight/2 ) );
        color(255, 204, 0);
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

void keyPressed() {
  if (key == ' ') {
    adaptive = !adaptive;
   
  }
  if (key == 'a')
    drawAxes = !drawAxes;
  if (key == 'p')
    drawShooterTarget = !drawShooterTarget;
  if (key == 'e')
    scene.setType(Graph.Type.ORTHOGRAPHIC);
  if (key == 'E')
    scene.setType(Graph.Type.PERSPECTIVE);
  if (key == 's')
    scene.fitBallInterpolation();
  if (key == 'S')
    scene.fitBall();
  if (key == 'u')
    
  if (key == CODED)
    if (keyCode == UP)
      scene.translate("keyboard", 0, -10);
    else if (keyCode == DOWN)
      scene.translate("keyboard", 0, 10);
    else if (keyCode == LEFT)
      scene.translate("keyboard", -10, 0);
    else if (keyCode == RIGHT)
      scene.translate("keyboard", 10, 0);
}
