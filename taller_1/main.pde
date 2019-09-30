import processing.video.*;

MovieConvolution mc;
Movie m;
ButtonList bl;
PImage myImage;
float[][] activeMatrix;

float[][] convolutionMatrix0 = new float[][]{{1,0,-1},{0,0,0},{-1,0,1}}; 
float[][] convolutionMatrix1 = new float[][]{{-1,-1,-1},{-1,8,-1},{-1,-1,-1}};
float[][] convolutionMatrix2 = new float[][]{{1/256f,4/256f,6/256f,4/256f,1/256f},
                                             {4/256f,16/256f,24/256f,16/256f,4/256f},
                                             {6/256f,24/256f,36/256f,24/256f,6/256f},
                                             {4/256f,16/256f,24/256f,16/256f,4/256f},
                                             {1/256f,4/256f,6/256f,4/256f,1/256f}};

boolean showingImages;
boolean showingVideo;
PApplet main;

void setup(){
  size(1000, 2000);
  main = this;
  //makeMenu(0,200,50,20,new String[] {"test","test2"});
  //mc = new MovieConvolution(new Movie(this, "colors.mp4"),activeMatrix);
  //Hacer menú de botones
  bl = new ButtonList(50,500,20);
  setActiveButtonList(bl);
  ButtonList image = bl.addSubmenuButton(50,20,"Imágen",20,new OnClickListener(){
    @Override
    public void onClick(ButtonList buttonList){
      showingImages = true;
      showingVideo = false;
    }
  });
  ButtonList video = bl.addSubmenuButton(50,20,"Video",20,new OnClickListener(){
    @Override
    public void onClick(ButtonList buttonList){
      showingImages = false;
      showingVideo = true;
    }
  });
  ButtonList image1 = image.addSubmenuButton(70,20,"Ciervo",20,new OnClickListener(){
    @Override
    public void onClick(ButtonList buttonList){
      myImage = loadImage("Vd-Orig.png");
    }
  });
  ButtonList image2 = image.addSubmenuButton(70,20,"Pie",20,new OnClickListener(){
    @Override
    public void onClick(ButtonList buttonList){
      myImage = loadImage("pie.jpg");
    }
  });
  addMatrixMenu(image1);
  addMatrixMenu(image2);
  addMatrixVideoMenu(video);
}

void addMatrixVideoMenu(ButtonList bl){
  bl.addButton(new Button(70,20,"Original",new OnClickListener(){
    @Override
    public void onClick(ButtonList buttonList){
      if(mc!=null) mc.stopMovie();
      activeMatrix = null;
      mc = new MovieConvolution(new Movie(main, "colors.mp4"),activeMatrix);
    }
  }));
  bl.addButton(new Button(150,20,"Detección de bordes 1",new OnClickListener(){
    @Override
    public void onClick(ButtonList buttonList){
      if(mc!=null) mc.stopMovie();
      activeMatrix = convolutionMatrix0;
      mc = new MovieConvolution(new Movie(main, "colors.mp4"),activeMatrix);
    }
  }));
  bl.addButton(new Button(150,20,"Detección de bordes 2",new OnClickListener(){
    @Override
    public void onClick(ButtonList buttonList){
      if(mc!=null) mc.stopMovie();
      activeMatrix = convolutionMatrix1;
      mc = new MovieConvolution(new Movie(main, "colors.mp4"),activeMatrix);
    }
  }));
  bl.addButton(new Button(170,20,"Desenfoque gaussiano 5 × 5",new OnClickListener(){
    @Override
    public void onClick(ButtonList buttonList){
      if(mc!=null) mc.stopMovie();
      activeMatrix = convolutionMatrix2;
      mc = new MovieConvolution(new Movie(main, "colors.mp4"),activeMatrix);
    }
  }));
  bl.addButton(new Button(170,20,"Escala de grises",new OnClickListener(){
    @Override
    public void onClick(ButtonList buttonList){
      if(mc!=null) mc.stopMovie();
      activeMatrix = null;
      mc = new GrayScaleMovie(new Movie(main, "colors.mp4"),activeMatrix);
    }
  }));
}

void addMatrixMenu(ButtonList bl){
  bl.addButton(new Button(150,20,"Detección de bordes 1",new OnClickListener(){
    @Override
    public void onClick(ButtonList buttonList){
      activeMatrix = convolutionMatrix0;
    }
  }));
  bl.addButton(new Button(150,20,"Detección de bordes 2",new OnClickListener(){
    @Override
    public void onClick(ButtonList buttonList){
      activeMatrix = convolutionMatrix1;
    }
  }));
  bl.addButton(new Button(170,20,"Desenfoque gaussiano 5 × 5",new OnClickListener(){
    @Override
    public void onClick(ButtonList buttonList){
      activeMatrix = convolutionMatrix2;
    }
  }));
  bl.addButton(new Button(170,20,"Escala de grises",new OnClickListener(){
    @Override
    public void onClick(ButtonList buttonList){
      activeMatrix = null;
    }
  }));
}

void draw(){
  clear();
  if(showingVideo && mc!=null && mc.newFrame()){
    image(mc.getPGraphics(), 0, 0);
  }
  if(showingImages && myImage!=null && activeMatrix!=null){
    PGraphics pg = applyConvolutionalMatrix(myImage,activeMatrix);
    image(myImage, 0, 0);
    image(pg, myImage.width+20, 0);
  }else if(showingImages && myImage!=null){
    PGraphics pg = applyGrayScale(myImage);
    image(myImage, 0, 0);
    image(pg, myImage.width+20, 0);
  }
  bl.makeMenu();
}

void movieEvent(Movie movie) {  
    if(mc!=null) mc.movieEvent(movie);
}
