public class GrayScaleMovie extends MovieConvolution{
  GrayScaleMovie(Movie movie,float[][] matrix){
    super(movie,matrix);
  }
  
  public PGraphics getPGraphics(){
    PGraphics pg = getPg();
    Movie movie = getMovie();
    movie.pause();
    long startTime = System.currentTimeMillis();
    setNewFrame(false);
    pg = createGraphics(movie.width,movie.height);
    pg.beginDraw();
    pg.pixels = new int[movie.width*movie.height];
    movie.loadPixels();
    //Recorrer pixeles
    for(int i=0;i<movie.width*movie.height;i++){
      float r = red(movie.pixels[i]);
      float g = green(movie.pixels[i]);
      float b = blue(movie.pixels[i]);
      //Asignar color a nueva imágen
      pg.pixels[i] = color((r+g+b)/3);
    }
    pg.updatePixels();
    long endTime = System.currentTimeMillis();
    pg.fill(0, 102, 153);
    pg.text("FPS: "+1000/(endTime - startTime),20,20);
    pg.endDraw();
    movie.play();
    return pg;
  }
}
