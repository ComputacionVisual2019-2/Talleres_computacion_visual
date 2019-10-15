public class MachBands implements Drawable{
  
  private PGraphics pg;
  private int nSquares;
  
  public MachBands(){
    nSquares = 5;
  }
  
  @Override
  public PGraphics getPGraphics(){
    pg = createGraphics(350,250);
    pg.beginDraw();
    for(int i=0;i<nSquares;i++){
      pg.noStroke();
      pg.fill(10*nSquares-10*i);
      pg.rect((i*pg.width)/(2*nSquares),pg.height-((i*pg.height)/nSquares),pg.width-((i*pg.width)/nSquares),pg.height/nSquares);
    }
    pg.endDraw();
    return pg;
  }
  
  @Override
  public void onMouseEvent(MouseEvent event, int x, int y){
    
  }
  
}
