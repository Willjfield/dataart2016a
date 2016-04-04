class Artwork implements Comparable{

  String artist;
  String title;
  String dimensionsString;
  int year;
  PVector dimensions = new PVector();

  PVector pos = new PVector();

  Artwork() {
  }

  Artwork fromJSON(JSONObject j) {
    artist = j.getString("Artist");
    title = j.getString("Title");
    try{
    String strYear = j.getString("Date");
    year = int(strYear);
    }catch(Exception e){
      year = -1;
      //println(j);
    }
    
    try {
      dimensionsString = j.getString("Dimensions");
      //19 1/8 x 66 1/2\" (48.6 x 168.9 cm)
      String metric = dimensionsString.split("//(")[1].split("cm//)")[0];
      String[] dims = metric.split(" //* ");
      //println(dims.length);
      if(dims.length == 2) {
        //2D artwork
        dimensions.x = float(dims[0]);
        dimensions.y = float(dims[1]);
      } else if (dims.length == 3) {
        //3D artwork
        dimensions.x = float(dims[0]);
        dimensions.y = float(dims[1]);
        dimensions.z = float(dims[2]);
      }
      
    } 
    catch(Exception e) {
      println("no dimensions");
    }
    return(this);
  }

  void update() {
  }

  void render() {
    pushMatrix();
    noFill();
    strokeWeight(1);
    stroke(255,10);
    translate(pos.x, pos.y);
    rect(0, 0, dimensions.x, dimensions.y);
    popMatrix();
  }
  
  int compareTo(Object b){
     return(int((dimensions.x*dimensions.y)-(((Artwork) b).dimensions.x*((Artwork) b).dimensions.y)));
  }
}