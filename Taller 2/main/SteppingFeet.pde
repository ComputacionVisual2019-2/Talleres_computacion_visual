public class SteppingFeet implements Drawable{
  private PGraphics pg;
  private int x;
  private int y;
  private int y2;
  private int w;
  private int h;
  private int r;
  private int time;
  private boolean showStrips;
  
  public SteppingFeet(){
    pg = createGraphics(300,150);
    x = 0;
    y = pg.height/5;
    y2 = (3*pg.height)/5;
    w = 50;
    h = pg.height/5;
    time = millis();
  }
  
  public void onMouseEvent(MouseEvent event, int x, int y){
    switch(event.getAction()){
      case MouseEvent.CLICK:
        showStrips = !showStrips;
        break;
    }
  };
  
  public PGraphics getPGraphics(){
    pg = createGraphics(300,150);
    pg.beginDraw();
    pg.noStroke();
    if(showStrips){
      for(int i=0;i<pg.width/(w/5);i++){
        if(i%2==0){
          pg.fill(0);
        }else{
          pg.fill(355);
        }
        pg.rect(i*10,0,w/5,pg.height);
      }
    }
    pg.fill(255, 255, 0);
    pg.rect(r+x,y,w,h);
    pg.fill(0, 0, 255);
    pg.rect(r+x,y2,w,h);
    pg.endDraw();
    if(r<pg.width){
      if(millis()-time>3){
        r++;
        time = millis(); 
      }
    }else{
      r = 0;
    }
    return pg;  
  };
}
