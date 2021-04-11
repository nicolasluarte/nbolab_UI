class Button {
  String label;
  float x;    // top left corner x position
  float y;    // top left corner y position
  float w;    // width of button
  float h;    // height of button
  boolean _clicked;
  boolean _rectOver;
  
  Button(String labelB, float xpos, float ypos, float widthB, float heightB) {
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
  }
  
  void Draw() {
    fill(255);
    stroke(141);
    rect(x, y, w, h);
    textAlign(CENTER, CENTER);
    fill(0);
    text(label, x + (w / 2), y + (h / 2));
  }
  
   void Draw(int COLOR) {
    fill(COLOR);
    stroke(141);
    rect(x, y, w, h);
    textAlign(CENTER, CENTER);
    fill(0);
    text(label, x + (w / 2), y + (h / 2));
  }
  
   void reLabel(int lab) {
    fill(218);
    stroke(141);
    rect(x, y, w, h, 10);
    textAlign(CENTER, CENTER);
    fill(0);
    this.label = str(lab);
    text(label, x + (w / 2), y + (h / 2));
  }
  
  int getLabel(){
    return Integer.valueOf(label);
  }
  
  
  boolean MouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
      return true;
    }
    else{
      return false;
    }
  }
  


}
