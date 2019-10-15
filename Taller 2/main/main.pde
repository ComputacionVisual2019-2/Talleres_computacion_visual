private Drawable activeDrawable;
private ButtonList bl;
private OnMouseEventListener onMouseEventListener;

void setup(){
  size(1200, 800);
  createMenu();
  onMouseEventListener = new OnMouseEventListener(){
    @Override
    public void onMouseEvent(MouseEvent event){
      if(activeDrawable!=null){
        PGraphics pg = activeDrawable.getPGraphics();
        activeDrawable.onMouseEvent(event,event.getX()-(width/2-pg.width/2),event.getY()-(height/2-pg.height/2));
      }
    }
  };
  Events.getInstance().addOnMouseEventListener(onMouseEventListener);
}

private void createMenu(){
  bl = new ButtonList(20,20,35);
  bl.setActive(true);
  bl.addButton(new Button(100,35,"Cubo de Necker",new OnClickListener(){
    @Override
    public void onClick(int x, int y){
      activeDrawable = new NeckerCube();
    }
  }));
  bl.addButton(new Button(100,35,"Stepping feet",new OnClickListener(){
    @Override
    public void onClick(int x, int y){
      activeDrawable = new SteppingFeet();
    }
  }));
  bl.addButton(new Button(100,35,"Pared de cafetería",new OnClickListener(){
    @Override
    public void onClick(int x, int y){
      activeDrawable = new CafeWall();
    }
  }));
  bl.addButton(new Button(100,35,"Poggendorff",new OnClickListener(){
    @Override
    public void onClick(int x, int y){
      activeDrawable = new Poggendorff("arco.png",500,500);
    }
  }));
  bl.addButton(new Button(100,35,"Pyramid",new OnClickListener(){
    @Override
    public void onClick(int x, int y){
      activeDrawable = new Pyramid(500,500);
    }
  }));
  bl.addButton(new Button(100,35,"Bandas de Mach",new OnClickListener(){
    @Override
    public void onClick(int x, int y){
      activeDrawable = new MachBands();
    }
  }));
}

void draw(){
  clear();
  background(255);
  bl.makeMenu();
  if(activeDrawable!=null){
    PGraphics pg = activeDrawable.getPGraphics();
    //println(width/2-pg.width/2,height/2-pg.height/2);
    image(pg,width/2-pg.width/2,height/2-pg.height/2);
  }
}
