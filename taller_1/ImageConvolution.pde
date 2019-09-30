PGraphics applyConvolutionalMatrix(PImage myImage,float[][] matrix){
  PGraphics pg = createGraphics(myImage.width,myImage.height);
  pg.beginDraw();
  myImage.loadPixels();
  pg.loadPixels();
  //Hallar centro de la matriz de convolución
  int matrixCoreX = int(matrix[0].length/2);
  int matrixCoreY = int(matrix.length/2);
  //Recorrer pixeles
  for(int i=0;i<myImage.width*myImage.height;i++){
    //Inicializar valores r,g,b
    int r = 0;
    int g = 0;
    int b = 0;
    //Recorrer matriz
    for(int j=0;j<matrix[0].length;j++){
      int x = i%myImage.width+(j-matrixCoreX);
      for(int j2=0;j2<matrix.length;j2++){
        int y = int(i/myImage.width)+(j2-matrixCoreY); 
        //Comprobar que el pixel esté en el arreglo
        if(x>=0 && y>=0 && x<myImage.width && y<myImage.height){
          //Sumar valores de r,g,b
          r += red(myImage.pixels[y*myImage.width+x])*matrix[j2][j];
          g += green(myImage.pixels[y*myImage.width+x])*matrix[j2][j];
          b += blue(myImage.pixels[y*myImage.width+x])*matrix[j2][j];
        }
      }
    }
    //Asignar color a nueva imágen
    pg.pixels[i] = color(r,g,b);
  }
  pg.updatePixels();
  pg.endDraw();
  return pg;
}

PGraphics applyGrayScale(PImage myImage){
  PGraphics pg = createGraphics(myImage.width,myImage.height);
  pg.beginDraw();
  myImage.loadPixels();
  pg.loadPixels();
  //Recorrer pixeles
  for(int i=0;i<myImage.width*myImage.height;i++){
    //Inicializar valores r,g,b
    float r = 0;
    float g = 0;
    float b = 0;
    r = red(myImage.pixels[i]);
    g = green(myImage.pixels[i]);
    b = blue(myImage.pixels[i]);
    pg.pixels[i] = color((r+g+b)/3);
  }
  pg.updatePixels();
  pg.endDraw();
  return pg;
}
