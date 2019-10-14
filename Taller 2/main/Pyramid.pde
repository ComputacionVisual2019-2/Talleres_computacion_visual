import java.lang.*;

public class Pyramid implements Drawable{
  
  private int division;
  private PGraphics ventana;
  private int X,Y,ancho;
  private color azul, blanco;
  //////////////////////////////////////
  ////////DEFAUL DESDE CENTRO AZUL HASTA EXTERIOR BLANCO
  public Pyramid(int x, int y){
    this.division = 1;
    if(x<y){
      this.X = x;
      this.Y = x;
    }else{
      this.X=y;
      this.Y=y;
    }
    this.azul = color(0,30,255);
    this.blanco = color(255,255,255);
    this.ventana= createGraphics(X,Y);

  }
  //////////////////////////////////////
  ///////////////// CAMBIO DE COLORES DESDE: HASTA: 
  public Pyramid(int x, int y, color desde, color hasta){
    this.division = 1;
    if(x<y){
      this.X = x;
      this.Y = x;
    }else{
      this.X=y;
      this.Y=y;
    }
    this.azul = color(0,30,255);
    this.blanco = color(255,255,255);
    this.ventana= createGraphics(X,Y);
    this.azul = desde;
    this.blanco = hasta;
  }
  
  private void numeroCuadros(){
    if(second()%5 ==0){
      this.division = 1;
    }else if(second()%5 ==1){
      this.division = 5;
    }else if(second()%5 ==2){
      this.division = 15;
    }else if(second()%5 ==3){
      this.division = 50;
    }else if(second()%5 ==4){
      this.division = 125;
    }
    this.anchoCuadros();
  }
  
  private void anchoCuadros(){
    this.ancho = (X/2)/division;
  }
  
  public PGraphics getPGraphics(){
    this.numeroCuadros();
    this.ventana.beginDraw();
        
      this.ventana.clear();
      for(int i = this.division-1; i >=0; i--){
        this.ventana.stroke(lerpColor(azul,blanco,(1.0/this.division)*i));
        this.ventana.fill(lerpColor(azul,blanco,(1.0/this.division)*i));
        this.ventana.square(((this.X/2)-(this.ancho*i)),((this.X/2)-(this.ancho*i)),this.ancho*2*i);
      }
    
    this.ventana.endDraw();
    return this.ventana;
  }
  
  public void onMouseEvent(MouseEvent event, int x, int y){};
  
}
