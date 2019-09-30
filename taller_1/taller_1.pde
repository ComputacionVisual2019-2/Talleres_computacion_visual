import java.util.*;

PImage img, cambio;
PGraphics pg;
int [] arreglo = new int[256];

PImage convolucion(PImage inicial, int opcion){ 
  float matris[][] = new float[3][3];
  float divisor;
  if (opcion == 1){
    float[][] aux = { { 1, 1, 1 },
                { 1, 1, 1 },
                { 1, 1, 1 } 
              };
   matris = aux;
   divisor = 9;
  }else{
    float[][] aux = { { 0, -1, 0 },
                       { -1, 5, -1 },
                       { 0, -1, 0 } 
                     };
   matris = aux;
   divisor = 1;
  }
  
  
  PImage nueva = createImage( inicial.width,inicial.height, RGB);
  nueva.loadPixels();
  for(int y = 1; y < img.height-1;y++){
    for(int x = 1; x < img.width-1; x++){
      if(opcion != 0){
        float red = 0, green = 0, blue = 0;
        for(int ky = -1; ky <= 1; ky++){
          for(int kx = -1; kx <= 1; kx++){
            int pos = ((y + ky)*img.width) + (x + kx);
            red += matris[ky+1][kx+1] * red(img.pixels[pos]);
            green += matris[ky+1][kx+1] * green(img.pixels[pos]);
            blue += matris[ky+1][kx+1] * blue(img.pixels[pos]);
          }
        }
        nueva.pixels[y*img.width + x] = color(red/divisor,green/divisor,blue/divisor);
      }else{
        color p = img.pixels[y*img.width + x];
        nueva.pixels[y*img.width + x] =  color ((red(p)+green(p)+blue(p))/3);
      }
    }
  }
  return nueva;
}


int []histograma(){
  int [] aux = new int[256];
  for(int i = 0; i < cambio.pixels.length;i++){
    aux[(int)red(cambio.pixels[i])]+=1;  
  };
  return aux;
}

void setup(){
  
  //img = loadImage("uno.png");
  img = loadImage("tres.jpg");
  size(1352,550); 
  img.resize(400,400);
  img.loadPixels();
  int opcion = 0;
  
  cambio = convolucion(img,opcion);
  
  arreglo = histograma();
  pg=createGraphics(512, cambio.height);  
  cambio = segmentacion();

};

PImage segmentacion(){
  PImage aux = createImage(cambio.width,cambio.height,RGB);
  aux.loadPixels();
  int max = 0;
  for(int i =0; i<arreglo.length;i++){
    max = arreglo[max]> arreglo[i] ? max : i;    
  }
  int range1 = 20, range2=20;
  if(max>range1){range1=max>0? max-1:max;}
  if(255-max<range2){range2=255-max>0 ? 255-max: 0;}
  for(int i =0; i<aux.pixels.length ;i++){  
    if(red(cambio.pixels[i])> max-range1 && red(cambio.pixels[i])< max+range2){
      aux.pixels[i] = cambio.pixels[i];
    }
  }
  return aux;
}


void pintarLineas(){
  int cont = 0;
   for(int i = 0; i < 255;i++){
    pg.line(cont,cambio.height, cont,cambio.height-arreglo[i]/7);
    cont+=2;
  }
}

void draw(){
  pg.beginDraw();
  pg.background(100);
  pg.stroke(255);
  pintarLineas();
  pg.endDraw();
  image(img,10,10);
  image(cambio, 420,10);
  image(pg, 830,10);
  
  
  
};
