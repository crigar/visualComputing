/**
 * Flock of Boids
 * by Jean Pierre Charalambos.
 *
 * This example displays the famous artificial life program "Boids", developed by
 * Craig Reynolds in 1986 [1] and then adapted to Processing by Matt Wetmore in
 * 2010 (https://www.openprocessing.org/sketch/6910#), in 'third person' eye mode.
 * The Boid under the mouse will be colored blue. If you click on a boid it will
 * be selected as the scene avatar for the eye to follow it.
 *
 * 1. Reynolds, C. W. Flocks, Herds and Schools: A Distributed Behavioral Model. 87.
 * http://www.cs.toronto.edu/~dt/siggraph97-course/cwr87/
 * 2. Check also this nice presentation about the paper:
 * https://pdfs.semanticscholar.org/73b1/5c60672971c44ef6304a39af19dc963cd0af.pdf
 * 3. Google for more...
 *
 * Press ' ' to switch between the different eye modes.
 * Press 'a' to toggle (start/stop) animation.
 * Press 'p' to print the current frame rate.
 * Press 'm' to change the boid visual mode.
 * Press 'v' to toggle boids' wall skipping.
 * Press 's' to call scene.fitBallInterpolation().
 */

import frames.primitives.*;
import frames.core.*;
import frames.processing.*;

Scene scene;
//flock bounding box
static int flockWidth = 1280;
static int flockHeight = 720;
static int flockDepth = 600;
static boolean avoidWalls = true;

int initBoidNum = 900; // amount of boids to start the program with
ArrayList<Boid> flock;
Frame avatar;
boolean animate = true;

float sc = 3; // scale factor for the render of the boid
Vertex v0 = new Vertex(new Float[]{3 * sc, 0.0, 0.0} );
Vertex v1 = new Vertex(new Float[]{-3 * sc, 2 * sc, 0.0} );
Vertex v2 = new Vertex(new Float[]{-3 * sc, -2 * sc, 0.0} );
Vertex v3 = new Vertex(new Float[]{-3 * sc, 0.0, 2 * sc} );
Vertex v4 = new Vertex(new Float[]{(-3 * sc) * 2, 0.0, 0.0} );

int p0 = (int)random(0, initBoidNum);
int p1 = (int)random(0, initBoidNum);
int p2 = (int)random(0, initBoidNum);
int p3 = (int)random(0, initBoidNum);
int p4 = (int)random(0, initBoidNum);
int p5 = (int)random(0, initBoidNum);
int p6 = (int)random(0, initBoidNum);
int p7 = (int)random(0, initBoidNum);


  
void setup() {
  
  size(1000, 800, P3D);
  scene = new Scene(this);
  scene.setBoundingBox(new Vector(0, 0, 0), new Vector(flockWidth, flockHeight, flockDepth));

  scene.setAnchor(scene.center());
  scene.setFieldOfView(PI / 3);
  scene.fitBall();
  // create and fill the list of boids
  ArrayList<Vertex> objectVV = createObjectVV();
  ArrayList<Face> objectFV = createObjectFV();
  //introducir tipo de representacion: VV o FV
  PShape boidShape = representation("FV");
  flock = new ArrayList();
  for (int i = 0; i < initBoidNum; i++)
    //flock.add(new Boid(new Vector(flockWidth / 2, flockHeight / 2, flockDepth / 2), boidShape, "immediate", "VV", objectVV, null  ));
    flock.add(new Boid(new Vector(flockWidth / 2, flockHeight / 2, flockDepth / 2), boidShape, "retained", null, null, null));
  
  
}

PShape representation(String representation){
  if(representation == "VV"){
    ArrayList<Vertex> objectVV = createObjectVV();
    return createBoidShapeVV(objectVV);
  }else{
    ArrayList<Face> objectFV = createObjectFV();
    return createBoidShapeFV(objectFV);
  }
}

PShape createBoidShapeVV(ArrayList<Vertex> object){
  PShape boidShape = createShape();
  boidShape.beginShape(TRIANGLES);
  for (int i = 0; i < object.size(); i++){
    ArrayList<Vertex> adjacentVertices = object.get(i).getAdjacentVertices();
    for (int j = 0; j < adjacentVertices.size() ; j++){
      Vertex adjacentVertex = adjacentVertices.get(j);
      boidShape.vertex(adjacentVertex.getCoordinates()[0], adjacentVertex.getCoordinates()[1], adjacentVertex.getCoordinates()[2]);
    }
  }
  boidShape.endShape();
  return boidShape;
}


PShape createBoidShapeFV(ArrayList<Face> object){
  PShape boidShape = createShape();
  boidShape.beginShape(TRIANGLES);
  for (int i = 0; i < object.size(); i++){
    ArrayList<Vertex> adjacentVertices = object.get(i).getAdjacentVertices();
    for (int j = 0; j < adjacentVertices.size() ; j++){
      Vertex adjacentVertex = adjacentVertices.get(j);
      boidShape.vertex(adjacentVertex.getCoordinates()[0], adjacentVertex.getCoordinates()[1], adjacentVertex.getCoordinates()[2]);
    }
  }
  boidShape.endShape();
  return boidShape;
}

ArrayList<Face> createObjectFV(){
  ArrayList<Face> object = new ArrayList();
  ArrayList<Vertex> adjacentVertices;
  ArrayList<Face> adjacentFaces;
  
  adjacentVertices = new ArrayList();
  adjacentVertices.add(v0);
  adjacentVertices.add(v1);
  adjacentVertices.add(v2);
  Face f0 = new Face(adjacentVertices);
  
  adjacentVertices = new ArrayList();
  adjacentVertices.add(v0);
  adjacentVertices.add(v2);
  adjacentVertices.add(v3);
  Face f1 = new Face(adjacentVertices);
  
  adjacentVertices = new ArrayList();
  adjacentVertices.add(v0);
  adjacentVertices.add(v1);
  adjacentVertices.add(v3);
  Face f2 = new Face(adjacentVertices);
  
  adjacentVertices = new ArrayList();
  adjacentVertices.add(v1);
  adjacentVertices.add(v2);
  adjacentVertices.add(v3);
  Face f3 = new Face(adjacentVertices);
  
  adjacentVertices = new ArrayList();
  adjacentVertices.add(v3);
  adjacentVertices.add(v1);
  adjacentVertices.add(v4);
  Face f4 = new Face(adjacentVertices);
  
  adjacentVertices = new ArrayList();
  adjacentVertices.add(v1);
  adjacentVertices.add(v2);
  adjacentVertices.add(v4);
  Face f5 = new Face(adjacentVertices);
  
  adjacentVertices = new ArrayList();
  adjacentVertices.add(v2);
  adjacentVertices.add(v3);
  adjacentVertices.add(v4);
  Face f6 = new Face(adjacentVertices);
  
  adjacentFaces = new ArrayList();
  adjacentFaces.add(f0);
  adjacentFaces.add(f1);
  adjacentFaces.add(f2);
  v0.setAdjacentFaces(adjacentFaces);
  
  adjacentFaces = new ArrayList();
  adjacentFaces.add(f0);
  adjacentFaces.add(f2);
  adjacentFaces.add(f3);
  v1.setAdjacentFaces(adjacentFaces);
  
  adjacentFaces = new ArrayList();
  adjacentFaces.add(f0);
  adjacentFaces.add(f1);
  adjacentFaces.add(f3);
  v2.setAdjacentFaces(adjacentFaces);
  
  adjacentFaces = new ArrayList();
  adjacentFaces.add(f1);
  adjacentFaces.add(f2);
  adjacentFaces.add(f3);
  v3.setAdjacentFaces(adjacentFaces);
  
  adjacentFaces = new ArrayList();
  adjacentFaces.add(f4);
  adjacentFaces.add(f5);
  adjacentFaces.add(f6);
  v4.setAdjacentFaces(adjacentFaces);
  
  object.add(f0);
  object.add(f1);
  object.add(f2);
  object.add(f3);
  object.add(f4);
  object.add(f5);
  object.add(f6);
  
  return object;
}

ArrayList<Vertex> createObjectVV(){
  ArrayList<Vertex> object = new ArrayList();
  ArrayList<Vertex> adjacentVertices; 

  
  
    
  adjacentVertices = new ArrayList();
  adjacentVertices.add(v1);
  adjacentVertices.add(v2);
  adjacentVertices.add(v3);
  v0.setAdjacentVertices(adjacentVertices);
  
  adjacentVertices = new ArrayList();
  adjacentVertices.add(v0);
  adjacentVertices.add(v2);
  adjacentVertices.add(v3);
  adjacentVertices.add(v4);
  v1.setAdjacentVertices(adjacentVertices);
  
  adjacentVertices = new ArrayList();
  adjacentVertices.add(v0);
  adjacentVertices.add(v1);
  adjacentVertices.add(v3);
  adjacentVertices.add(v4);
  v2.setAdjacentVertices(adjacentVertices);
  
  adjacentVertices = new ArrayList();
  adjacentVertices.add(v0);
  adjacentVertices.add(v1);
  adjacentVertices.add(v2);
  adjacentVertices.add(v4);
  v3.setAdjacentVertices(adjacentVertices);
  
  adjacentVertices = new ArrayList();
  adjacentVertices.add(v1);
  adjacentVertices.add(v2);
  adjacentVertices.add(v3);
  v4.setAdjacentVertices(adjacentVertices);
  
  object.add(v0);
  object.add(v1);
  object.add(v2);
  object.add(v3);
  object.add(v4);
  
  return object;
}

float bez3(float u, int k){
  if(k == 0){
    return (float) Math.pow( (1 - u), 3);
  }
  if(k == 1){
    return (float) (3 * u * Math.pow( (1 - u), 2) );
  }
  if(k == 2){
    return  (float) (3 * Math.pow(u, 2) * (1 - u) );
  }
  if(k == 3){
    return (float) Math.pow( u, 3);
  } 
  return 0;
}

float bez7(float u, int k){
  if(k == 0){
    return (float) Math.pow( (1 - u), 7);
  }
  if(k == 1){
    return (float) (7 * u * Math.pow( (1 - u), 6) );
  }
  if(k == 2){
    return  (float) (21 * Math.pow(u, 2) * Math.pow( (1 - u), 5) );
  }
  if(k == 3){
    return  (float) (35 * Math.pow(u, 3) * Math.pow( (1 - u), 4) );
  }
  if(k == 4){
    return  (float) (35 * Math.pow(u, 4) * Math.pow( (1 - u), 3) );
  }
  if(k == 5){
    return  (float) (21 * Math.pow(u, 5) * Math.pow( (1 - u), 2) );
  }
  if(k == 6){
    return  (float) (7 * Math.pow(u, 6) * (1 - u) );
  }
  if(k == 7){
    return  (float) (Math.pow(u, 7) );
  }
  return 0;
}

float h0(float t){  
  return (float )(2 * Math.pow(t,3) - 3 * Math.pow(t,2) + 1 ); 
}
float h1(float t){  
  return (float )( Math.pow(t,3) - 2 * Math.pow(t,2) + t ); 
}

float h2(float t){  
  return (float )(-2 * Math.pow(t,3) + 3 * Math.pow(t,2)); 
}

float h3(float t){  
  return (float )(Math.pow(t,3) -  Math.pow(t,2)); 
}

float mx(Boid[] vec, int i){  
  return  vec[i+1].position.x() - vec[i-1].position.x() * 0.5 ; 
}
float my(Boid[] vec, int i){  
  return  vec[i+1].position.y() - vec[i-1].position.y() * 0.5 ; 
}
float mz(Boid[] vec, int i){  
  return  vec[i+1].position.z() - vec[i-1].position.z() * 0.5 ; 
}

void bezie(float u){
  
}

void bezier(int grade){
  if( grade == 3){
    for (float u = 0; u < 1; u = u + 0.01){
        float x = flock.get(p0).position.x() * bez3(u, 0) +
                   flock.get(p1).position.x() * bez3(u, 1)   + 
                   flock.get(p2).position.x() * bez3(u, 2)  + 
                   flock.get(p3).position.x() * bez3(u, 3);
                   
        float y = flock.get(p0).position.y() * bez3(u, 0) +
                   flock.get(p1).position.y() * bez3(u, 1)   + 
                   flock.get(p2).position.y() * bez3(u, 2)  + 
                   flock.get(p3).position.y() * bez3(u, 3);
                   
        float z = flock.get(p0).position.z() * bez3(u, 0) +
                   flock.get(p1).position.z() * bez3(u, 1)   + 
                   flock.get(p2).position.z() * bez3(u, 2)  + 
                   flock.get(p3).position.z() * bez3(u, 3);
        
        strokeWeight(3);
        stroke(63,95,138);
        point(x, y, z);
    }
  }else{
    for (float u = 0; u < 1; u = u + 0.01){
        float x = flock.get(p0).position.x() * bez7(u, 0) +
                  flock.get(p1).position.x() * bez7(u, 1) + 
                  flock.get(p2).position.x() * bez7(u, 2) + 
                  flock.get(p3).position.x() * bez7(u, 3) +
                  flock.get(p4).position.x() * bez7(u, 4) +
                  flock.get(p5).position.x() * bez7(u, 5) +
                  flock.get(p6).position.x() * bez7(u, 6) +
                  flock.get(p7).position.x() * bez7(u, 7);
                  
                  
        float y = flock.get(p0).position.y() * bez7(u, 0) +
                  flock.get(p1).position.y() * bez7(u, 1) + 
                  flock.get(p2).position.y() * bez7(u, 2) + 
                  flock.get(p3).position.y() * bez7(u, 3) +
                  flock.get(p4).position.y() * bez7(u, 4) +
                  flock.get(p5).position.y() * bez7(u, 5) +
                  flock.get(p6).position.y() * bez7(u, 6) +
                  flock.get(p7).position.y() * bez7(u, 7);
                  
        float z = flock.get(p0).position.z() * bez7(u, 0) +
                  flock.get(p1).position.z() * bez7(u, 1) + 
                  flock.get(p2).position.z() * bez7(u, 2) + 
                  flock.get(p3).position.z() * bez7(u, 3) +
                  flock.get(p4).position.z() * bez7(u, 4) +
                  flock.get(p5).position.z() * bez7(u, 5) +
                  flock.get(p6).position.z() * bez7(u, 6) +
                  flock.get(p7).position.z() * bez7(u, 7);
                  
        
        strokeWeight(3);
        stroke(63,95,138);
        point(x, y, z);
    }
  }
    
}

void hermit(int grade){
  Boid[] vec;
  if( grade == 3){
    vec = new Boid[4];
    vec[0] = flock.get(p0);
    vec[1] = flock.get(p1);
    vec[2] = flock.get(p2);
    vec[3] = flock.get(p3);
  }else{
    vec = new Boid[8];
    vec[0] = flock.get(p0);
    vec[1] = flock.get(p1);
    vec[2] = flock.get(p2);
    vec[3] = flock.get(p3);
    vec[4] = flock.get(p4);
    vec[5] = flock.get(p5);
    vec[6] = flock.get(p6);
    vec[7] = flock.get(p7);
  }
  
  for(int i= 1; i <  vec.length - 2;i++){
     for (float u = 0; u < 1; u = u + 0.01){
       float x = h0(u) * flock.get(i).position.x() + h1(u) * mx(vec, i) + h2(u)* flock.get(i + 1).position.x() + h3(u) * mx(vec, i+1); 
       float y = h0(u) * flock.get(i).position.y() + h1(u) * my(vec, i) + h2(u)* flock.get(i + 1).position.y() + h3(u) * my(vec, i+1); 
       float z = h0(u) * flock.get(i).position.z() + h1(u) * mz(vec, i) + h2(u)* flock.get(i + 1).position.z() + h3(u) * mz(vec, i+1); 
       
       strokeWeight(3);
       stroke(255,0,0);
       point(x, y, z);
     }
    }
}

void draw() {
  background(10, 50, 25);
  ambientLight(128, 128, 128);
  directionalLight(255, 255, 255, 0, 1, -100);
  walls();
  scene.traverse();
  // uncomment to asynchronously update boid avatar. See mouseClicked()
  // updateAvatar(scene.trackedFrame("mouseClicked"));
  
  //intruducir el grado del polinomio: 3 o 7
  bezier(7);
  hermit(7);
}

void walls() {
  pushStyle();
  noFill();
  stroke(255, 255, 0);

  line(0, 0, 0, 0, flockHeight, 0);
  line(0, 0, flockDepth, 0, flockHeight, flockDepth);
  line(0, 0, 0, flockWidth, 0, 0);
  line(0, 0, flockDepth, flockWidth, 0, flockDepth);

  line(flockWidth, 0, 0, flockWidth, flockHeight, 0);
  line(flockWidth, 0, flockDepth, flockWidth, flockHeight, flockDepth);
  line(0, flockHeight, 0, flockWidth, flockHeight, 0);
  line(0, flockHeight, flockDepth, flockWidth, flockHeight, flockDepth);

  line(0, 0, 0, 0, 0, flockDepth);
  line(0, flockHeight, 0, 0, flockHeight, flockDepth);
  line(flockWidth, 0, 0, flockWidth, 0, flockDepth);
  line(flockWidth, flockHeight, 0, flockWidth, flockHeight, flockDepth);
  popStyle();
}

void updateAvatar(Frame boid) {
  if (boid != avatar) {
    avatar = boid;
    if (avatar != null)
      thirdPerson();
    else if (scene.eye().reference() != null)
      resetEye();
  }
}

// Sets current avatar as the eye reference and interpolate the eye to it
void thirdPerson() {
  scene.eye().setReference(avatar);
  scene.interpolateTo(avatar);
}

// Resets the eye
void resetEye() {
  // same as: scene.eye().setReference(null);
  scene.eye().resetReference();
  scene.lookAt(scene.center());
  scene.fitBallInterpolation();
}

// picks up a boid avatar, may be null
void mouseClicked() {
  // two options to update the boid avatar:
  // 1. Synchronously
  updateAvatar(scene.track("mouseClicked", mouseX, mouseY));
  // which is the same as these two lines:
  // scene.track("mouseClicked", mouseX, mouseY);
  // updateAvatar(scene.trackedFrame("mouseClicked"));
  // 2. Asynchronously
  // which requires updateAvatar(scene.trackedFrame("mouseClicked")) to be called within draw()
  // scene.cast("mouseClicked", mouseX, mouseY);
}

// 'first-person' interaction
void mouseDragged() {
  if (scene.eye().reference() == null)
    if (mouseButton == LEFT)
      // same as: scene.spin(scene.eye());
      scene.spin();
    else if (mouseButton == RIGHT)
      // same as: scene.translate(scene.eye());
      scene.translate();
    else
      // same as: scene.zoom(mouseX - pmouseX, scene.eye());
      scene.zoom(mouseX - pmouseX);
}

// highlighting and 'third-person' interaction
void mouseMoved(MouseEvent event) {
  // 1. highlighting
  scene.cast("mouseMoved", mouseX, mouseY);
  // 2. third-person interaction
  if (scene.eye().reference() != null)
    // press shift to move the mouse without looking around
    if (!event.isShiftDown())
      scene.lookAround();
}

void mouseWheel(MouseEvent event) {
  // same as: scene.scale(event.getCount() * 20, scene.eye());
  scene.scale(event.getCount() * 20);
}

void keyPressed() {
  switch (key) {
  case 'a':
    animate = !animate;
    break;
  case 's':
    if (scene.eye().reference() == null)
      scene.fitBallInterpolation();
    break;
  case 't':
    scene.shiftTimers();
    break;
  case 'p':
    println("Frame rate: " + frameRate);
    break;
  case 'v':
    avoidWalls = !avoidWalls;
    break;
  case ' ':
    if (scene.eye().reference() != null)
      resetEye();
    else if (avatar != null)
      thirdPerson();
    break;
  }
}
