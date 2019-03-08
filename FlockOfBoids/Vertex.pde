class Vertex {
  //attributes
  private Float[] coordinates;
  private ArrayList<Vertex> adjacentVertices;
  private ArrayList<Face> adjacentFaces;
  
  //constructors
  public Vertex(Float[] coordinates ){
    this.coordinates = coordinates;
  }
  //functions
  public Float[] getCoordinates(){
    return this.coordinates;
  }
  public ArrayList<Vertex> getAdjacentVertices(){
    return this.adjacentVertices;
  }
  public ArrayList<Vertex> getAdjacentFaces(){
    return this.adjacentVertices;
  }
  public void setCoordinates(Float[] coordinates){
     this.coordinates = coordinates;
  }
  public void setAdjacentVertices(ArrayList<Vertex> adjacentVertices ){
     this.adjacentVertices = adjacentVertices;
  }
  public void setAdjacentFaces(ArrayList<Face> adjacentVertices ){
     this.adjacentFaces = adjacentFaces;
  }
  
  @Override
  public String toString(){
    return "Coordenates: " + coordinates[0] + "," + coordinates[1]  + "," + coordinates[2];
  }
}
