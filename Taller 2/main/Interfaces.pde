public interface Drawable{
  public PGraphics getPGraphics();
  public void onMouseEvent(MouseEvent event, int x, int y);
}

public interface OnClickListener{
    public void onClick(int x, int y);
}

public interface OnMouseEventListener{
    public void onMouseEvent(MouseEvent event);
}
