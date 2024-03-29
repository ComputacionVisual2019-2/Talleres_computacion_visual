public class Poggendorff implements Drawable{
    
    private PGraphics main;
    private PImage cuadro, modificado;  
    private int size_x;
    private int size_y;
    private Boolean state;
    
    public Poggendorff(String imagen, int x ,int y){
      this.state = true;
      this.size_y = y;
      this.size_x = x;    
      this.cuadro= loadImage(imagen);
      this.cuadro.resize(this.size_x,this.size_y);
      this.cuadro.loadPixels();
      this.modificado = createImage(size_x, size_y,RGB);
      this.modificado.loadPixels();
      this.modificar();
      this.main= createGraphics(size_x,size_y);
    }
    
    private void modificar(){
        for (int i = 0; i < size_x; i++){
            for (int j = 0; j < size_y; j++){
                if(i > size_x/2-2 && i < size_x/2+80 ){
                    this.modificado.pixels[j*size_x+i] = color(231,152,120);    
                }else{
                    this.modificado.pixels[j*size_x+i] = this.cuadro.pixels[j*size_x+i];
                }
            }
        }
    }
    
    @Override
    public PGraphics getPGraphics(){
      this.main.beginDraw();
      this.main.clear();
      this.main.image(this.select(),0,0);
      this.main.endDraw();
      return main;
    }
    
    @Override
    public void onMouseEvent(MouseEvent event, int x, int y){
      switch(event.getAction()){
        case MouseEvent.MOVE:         
          if(x>=0 && x <= main.width/2){
            setState(true);
          }else{
            setState(false);
          }
          break;
      }
    };
    
    private PImage select(){
      if(state){
        return this.cuadro;
      }else{
        return this.modificado;
      }
    }
    
    public void setState(Boolean state){
      this.state=state;
    }
    
}
