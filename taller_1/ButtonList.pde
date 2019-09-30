//Library made by Julian Diaz juddiazci@unal.edu.co
import java.util.List;

public class ButtonList{
  private float x;
  private float y;
  private float maxHeight;
  private float w;
  private float h;
  private int size;
  private float margin = 10;
  private List<Button> buttons;
  
  public ButtonList(float x,float y,float maxHeight){
    this.size = 0;
    this.x = x;
    this.y = y;
    this.w = 0;
    this.h = 0;
    this.maxHeight = maxHeight;
    buttons = new ArrayList<Button>();
  }
  
  public void makeMenu(){
    for(int i=0;i<buttons.size();i++){
      Button b = buttons.get(i);
      margin = margin*(size+1);
      fill(2, 23, 117);
      rect(b.getX(), b.getY(), b.getWidth(), b.getHeight());
      fill(255, 255, 255);
      textAlign(CENTER);
      text(b.getText(),b.getX(), b.getY(), b.getWidth(), b.getHeight());
      if(b.isMenuButton() && b.isActive()){
        ((MenuButton) b).displayMenu();
      }
    }
  }
  
  public List<Button> getButtons(){
    return this.buttons;
  }
  
  public void addButton(Button button){
    button.setX(x+w+margin*size);
    button.setY(y);
    if(button.getHeight()>maxHeight){
      maxHeight = button.getHeight();
    }
    buttons.add(button);
    size++;
    w += button.getWidth()+margin;
  }
  
  public ButtonList addSubmenuButton(float w, float h, String text,float maxHeight, OnClickListener clickListener){
    ButtonList bl = new ButtonList(x,this.maxHeight+margin+y,maxHeight);
    Button menuButton = new MenuButton(w,h,text,clickListener,bl);
    addButton(menuButton);
    return bl;
  }
  
  public float getMaxHeight(){
    return this.maxHeight;
  }
  
  public void onClick(int x, int y){
    for(int i=0;i<buttons.size();i++){
      Button b = buttons.get(i);
      //println(x,y);
      //println(x<b.getWidth()+b.getX(), x>b.getX(), y<b.getHeight()+b.getY(), y>b.getY());
      if(b.isMenuButton() && b.isActive()){
        b.onClick(this);
      }else if(x<b.getWidth()+b.getX() && x>b.getX() && y<b.getHeight()+b.getY() && y>b.getY()){
        b.onClick(this);
        break;
      }
    }
  }
  
  public void clearActiveMenu(){
    for(Button b : buttons){
      if(b.isMenuButton()){
        ((MenuButton) b).setIsActive(false); 
      }
    }
  }
  
}

public class Button{
    private float x;
    private float y;
    private float w;
    private float h;
    private boolean isActive;
    private String text;
    private OnClickListener onClickListener;
    
    public Button(float w, float h, String text, OnClickListener onClick){
      this.w = w;
      this.h = h;
      this.onClickListener = onClick;
      this.text = text;
    }
    public float getWidth(){
      return w;
    }
    
    public float getHeight(){
      return h;
    }
    
    private float getX(){
      return this.x;
    }
    
    private float getY(){
      return this.y;
    }
    
    private String getText(){
      return this.text;
    }
    
    public OnClickListener getOnClickListener(){
      return this.onClickListener;
    }
    
    private void setX(float x){
      this.x = x;
    }
    
    private void setY(float y){
      this.y = y;
    }
    
    public boolean isMenuButton(){
      return false;
    }
    
    public boolean isActive(){
      return isActive;
    }
    
    public void setIsActive(boolean isActive){
      this.isActive = isActive;
    }
    
    public void onClick(ButtonList buttonList){
      onClickListener.onClick(buttonList);
    }
    
}

public class MenuButton extends Button implements OnClickListener{
  
  private ButtonList bl;
  
  public MenuButton(float w, float h, String text, OnClickListener onClick, ButtonList bl){
      super(w,h,text,onClick);
      this.bl = bl;
      setIsActive(false);
  }
  
  public ButtonList getButtonList(){
    return bl;
  }
  
  public boolean isMenuButton(){
      return true;
  }
  
  public void displayMenu(){
    bl.makeMenu();
  }
  
  public void setButtonList(ButtonList bl){
    this.bl = bl;
  }
  
  public void addButtons(ButtonList bl){
    if(bl!=null){
      for(Button b : bl.getButtons()){
        if(b.isMenuButton()){
          bl.addSubmenuButton(b.getWidth(),b.getHeight(),b.getText(),bl.getMaxHeight(),b.getOnClickListener());
        }else{
          bl.addButton(new Button(b.getWidth(),b.getHeight(),b.getText(),b.getOnClickListener()));
        }
      }
    }
  }
  
  @Override
  public void onClick(ButtonList buttonList){
    if(getOnClickListener()!=null){
      getOnClickListener().onClick(buttonList);
    }
    buttonList.clearActiveMenu();
    setIsActive(true);
    bl.onClick(mouseX,mouseY);
  }
  
}

public interface OnClickListener{
    public void onClick(ButtonList buttonList);
}

private ButtonList activeButtonList;

public void setActiveButtonList(ButtonList activeButtonList){
  this.activeButtonList = activeButtonList;
}

void mouseClicked(){
  activeButtonList.onClick(mouseX,mouseY);
}
