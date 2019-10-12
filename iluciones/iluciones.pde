
ilusion1 ilusion; 
ilusion2 ilusion_2;
int ilusion_height = 500;
int ilusion_weight = 500;

Boolean state = true;

void setup(){
  ////////////////////////////////////////////////////////////////////
    //ilusion = new ilusion1("arco.png", ilusion_weight, ilusion_height);
    //ilusion_2 = new ilusion2(500,500); 
    size(500, 500);
}


void draw(){
  
  
  /*///////////////////////////////-- ilucion 1 cambia con setState///////////////////////////////////////////////// 
  update(mouseX,mouseY);
  ilusion.setState(state);
  image(ilusion.pintar(),0,0);
  */
  
  /*
  /////////////////////////////////-- ilucion 2 cambia cada segundo sola///////////////////////////////////////////////
  image(ilusion_2.pintar(),0,0);
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  */
  
}

void update(int x, int y){
  if(mouseX>=0 && mouseX <= 250 && mouseY >= 0 && mouseY <= 500){
    state=true;
  }else{
    state=false;
  }
  
}
