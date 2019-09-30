import java.util.concurrent.TimeUnit;

class MovieConvolution{
  private Movie movie;
  private PGraphics pg;
  private boolean newFrame;
  private float[][] matrix;
  
  MovieConvolution(Movie movie,float[][] matrix){
    this.movie = movie;
    this.matrix = matrix;
    this.movie.play();
  }
  
  public Movie getMovie(){
    return this.movie;
  }
  
  public void movieEvent(Movie movie) {
    movie.read();
    newFrame = true;
  }
  
  public PGraphics getPGraphics(){
    movie.pause();
    long startTime = System.currentTimeMillis();
    newFrame = false;
    pg = createGraphics(movie.width,movie.height);
    pg.beginDraw();
    pg.pixels = new int[movie.width*movie.height];
    movie.loadPixels();
    if(matrix==null){
      pg.pixels = movie.pixels.clone();
    }else{
      //Hallar centro de la matriz de convolución
      int matrixCoreX = int(matrix[0].length/2);
      int matrixCoreY = int(matrix.length/2);
      //Recorrer pixeles
      for(int i=0;i<movie.width*movie.height;i++){
        //Inicializar valores r,g,b
        int r = 0;
        int g = 0;
        int b = 0;
        //Recorrer matriz
        for(int j=0;j<matrix[0].length;j++){
          int x = i%movie.width+(j-matrixCoreX);
          for(int j2=0;j2<matrix.length;j2++){
            int y = int(i/movie.width)+(j2-matrixCoreY); 
            //Comprobar que el pixel esté en el arreglo
            if(x>=0 && y>=0 && x<movie.width && y<movie.height){
              //Sumar valores de r,g,b
              r += red(movie.pixels[y*movie.width+x])*matrix[j2][j];
              g += green(movie.pixels[y*movie.width+x])*matrix[j2][j];
              b += blue(movie.pixels[y*movie.width+x])*matrix[j2][j];
            }
          }
        }
        //Asignar color a nueva imágen
        pg.pixels[i] = color(r,g,b);
      }
    }
    pg.updatePixels();
    long endTime = System.currentTimeMillis();
    pg.fill(0, 102, 153);
    if(matrix!=null) pg.text("FPS: "+1000/(endTime - startTime),20,20);
    pg.endDraw();
    movie.play();
    return pg;
  }
  
  public boolean newFrame(){
    return newFrame;
  }
  
  public PGraphics getPg(){
    return this.pg;
  }
  
  public void stopMovie(){
    movie.stop();
  }
  
  public void setNewFrame(boolean newFrame){
    this.newFrame = newFrame;
  }
}
