class Face {
  //attributes
  private ArrayList<Vertex> adjacentVertices;
  
  //constructor
  public Face(ArrayList<Vertex> adjacentVertices ){
    this.adjacentVertices = adjacentVertices;
  }
  
  //functions
  
  public ArrayList<Vertex> getAdjacentVertices(){
    return this.adjacentVertices;
  }
 
  public void setAdjacentVertices(ArrayList<Vertex> adjacentVertices ){
     this.adjacentVertices = adjacentVertices;
  }
  
  
}
