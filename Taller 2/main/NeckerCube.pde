public class NeckerCube implements Drawable{
  private PGraphics pg;
  
  public NeckerCube(){
    pg = createGraphics(300,300);
    pg.beginDraw();
    pg.stroke(0);
    pg.noFill();
    pg.square(0,pg.height/3,(2*pg.height)/3-1);
    pg.square(pg.height/3,0,(2*pg.height)/3-1);
    pg.line(0,pg.height/3,pg.height/3,0);
    pg.line((2*pg.height)/3,pg.height/3,pg.height-1,0);
    pg.line(0,pg.height-1,pg.height/3,(2*pg.height)/3);
    pg.line((2*pg.height)/3,pg.height-1,pg.height-1,(2*pg.height)/3);
    pg.endDraw();
  }
  
  @Override
  public PGraphics getPGraphics(){
    return pg;
  };
  
  @Override
  public void onMouseEvent(MouseEvent event, int x, int y){};
}
