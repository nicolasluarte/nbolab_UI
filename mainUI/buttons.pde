void createButtons(){
  ControlP5 cp5;
  cp5 = new ControlP5(this);
  // check ping button
  cp5.addButton("Ping")
     .setBroadcast(false)
     .setValue(0)
     .setPosition(300,offset)
     .setSize(200,19)
     .setBroadcast(true);
     ;
}

public void controlEvent(ControlEvent theEvent) {
  theEvent.getController().getName();
}
public void Ping() {
  String pingAllScript = dataPath("") + "/linux_scripts/pingall.sh";
  String pingReset = dataPath("") + "/linux_scripts/resetping.sh";
  exec(pingReset);
  exec(pingAllScript);
}
