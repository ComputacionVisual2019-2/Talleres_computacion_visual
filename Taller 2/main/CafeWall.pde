public class CafeWall implements Drawable{
  
  private PGraphics pg;
  private int distance;
  private int squareSize;
  
  public CafeWall(){
    distance = 7;
  }
  
  @Override
  public PGraphics getPGraphics(){
    pg = createGraphics(300,300);
    pg.beginDraw();
    pg.background(0);
    squareSize = 15;
    for(int i=-2;i<pg.width/squareSize+4;i=i+2){
      for(int j=0;j<pg.height/squareSize;j++){
        if(j%2==0){
          pg.square(squareSize*i,squareSize*j,squareSize);
        }else{
          pg.square(squareSize*i+distance,squareSize*j,squareSize);
        }
      }
    }
    pg.endDraw();
    return pg;
  };
  
  @Override
  public void onMouseEvent(MouseEvent event, int x, int y){
    switch(event.getAction()){
      case MouseEvent.WHEEL: 
        distance += event.getCount();
        if(distance>2*squareSize){
          distance -= 2*squareSize;
        }else if(distance<-2*squareSize){
          distance += 2*squareSize;
        }
        break;
    }
  };
  
}
