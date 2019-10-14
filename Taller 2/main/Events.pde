//Events module made by Julian Diaz juddiazci@unal.edu.co  

public static class Events{
  private List<OnClickListener> onClickListenerList;
  private List<OnMouseEventListener> onMouseEventListener;
  private static Events events = new Events();
  
  private Events(){
    onClickListenerList = new ArrayList<OnClickListener>();
    onMouseEventListener = new ArrayList<OnMouseEventListener>();
  }
  
  public static Events getInstance(){
    return events;
  }
  
  public void click(MouseEvent event){
    for (OnClickListener l : onClickListenerList){
      l.onClick(event.getX(),event.getY());
    }
    for (OnMouseEventListener l : onMouseEventListener){
      l.onMouseEvent(event);
    }
  }
  
  public void mouseEvent(MouseEvent event){
    for (OnMouseEventListener l : onMouseEventListener){
      l.onMouseEvent(event);
    }
  }
  
  public void addOnMouseEventListener(OnMouseEventListener l){
    onMouseEventListener.add(l);
  }
  
  public void removeOnMouseEventListener(OnMouseEventListener l){
    onMouseEventListener.remove(l);
  }
  
  public void addOnClickListener(OnClickListener l){
    onClickListenerList.add(l);
  }
  
  public void removeOnClickListener(OnClickListener l){
    onClickListenerList.remove(l);
  }

}

void mouseClicked(MouseEvent event){
  Events.getInstance().click(event);
}

void mouseWheel(MouseEvent event){
  Events.getInstance().mouseEvent(event);
}

void mouseMoved(MouseEvent event){
  Events.getInstance().mouseEvent(event);
}
