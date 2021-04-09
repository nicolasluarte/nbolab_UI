class manyButtons{
  
  int _canvasW;
  int _canvasH;
  int _offSetX;
  int _offSetY;
  int _cols;
  int _rows;
  int _counter;
  int _buttonPressed = 99;
  int[] _buttonArray;
  int _buttonSelected;
  String _labels[];
  ArrayList<String> _labelsArray;
  Button[] buttons;
  
  manyButtons(int canvasW, int canvasH, int offSetX, int offSetY, int cols, int rows, String labels[]){
    _canvasW = canvasW;
    _canvasH = canvasH;
    _offSetX = offSetX;
    _offSetY = offSetY;
    _cols = cols;
    _rows = rows;
    _buttonArray = new int[_rows * _cols];
    _labels = labels;
    _counter = 0;

    
    buttons = new Button[_cols * _rows];
    for (int i = 0; i < _rows; ++i){
      for (int j = 0; j < _cols; ++j){
        buttons[_counter] = new Button(labels[_counter], j * (_canvasW / _cols) + _offSetX, i * (_canvasH / _rows) + _offSetY, _canvasW / _cols, (_canvasH / _rows));
        buttons[_counter].Draw();
        ++_counter;
      }
    }
  }
  
   manyButtons(int canvasW, int canvasH, int offSetX, int offSetY, int cols, int rows, ArrayList<String> labels){
    _canvasW = canvasW;
    _canvasH = canvasH;
    _offSetX = offSetX;
    _offSetY = offSetY;
    _cols = cols;
    _rows = rows;
    _buttonArray = new int[_rows * _cols];
    _labelsArray = labels;
    _counter = 0;
    
    buttons = new Button[_cols * _rows];
    for (int i = 0; i < _rows; ++i){
      for (int j = 0; j < _cols; ++j){
        buttons[_counter] = new Button(labels.get(_counter), j * (_canvasW / _cols) + _offSetX, i * (_canvasH / _rows) + _offSetY, _canvasW / _cols, (_canvasH / _rows));
        buttons[_counter].Draw();
        ++_counter;
      }
    }
  }
  
  int changeMenu(){
    return _buttonPressed;
  }
  
  void updatePing(){
      raspberryPing = loadStrings("pingCheck.csv");
      pings = int(split(raspberryPing[0], ','));
      for(int x = 0; x < (_cols * _rows); x++){
        if (pings[x] == 1){
          buttons[x].Draw(#00b509);
        }
        else if (pings[x] == 3){
          buttons[x].Draw(#f2f542);
        }
        else{
          buttons[x].Draw(#f54242);
        }
      }
  }
  
   void Ping(int buttonPressed) {
    if (buttonPressed == _buttonPressed){
      String pingAllScript = dataPath("") + "/linux_scripts/pingall.sh";
      String pingReset = dataPath("") + "/linux_scripts/resetping.sh";
      exec(pingReset);
      exec(pingAllScript);
    }
  }
  
   void SetNFS(int buttonPressed) {
    if (buttonPressed == _buttonPressed){
  String setNFS = dataPath("") + "/linux_scripts/setNFS.sh";
  exec(setNFS);
    }
}

 void SetPackages(int buttonPressed) {
  if (buttonPressed == _buttonPressed){
  String setPackages = dataPath("") + "/linux_scripts/setPackages.sh";
  exec(setPackages);
  }
}

 void getCamVid(int buttonPressed) {
  if (buttonPressed == _buttonPressed){
  String getCamVid = dataPath("") + "/linux_scripts/getCamVid.sh";
    exec(getCamVid);
  }
}

 void piPreview(int buttonPressed) {
  if (buttonPressed == _buttonPressed){
  String playCamVid = dataPath("") + "/linux_scripts/playCamVid.sh";
  exec(playCamVid);
  }
}

  void pingArduino(Serial[] port){
    if (_buttonPressed != 99 && port[_buttonPressed] != null){
      port[_buttonPressed].clear();
      port[_buttonPressed].write("<05000000001>"); // tells arduino to blink led
      delay(1000);
      port[_buttonPressed].write("<05000000000>"); // stops blink
    }
  }

  boolean setPorts(int buttonPressed) {
    if (buttonPressed == _buttonPressed){
      return true;
    }
    return false;
  }
  
    boolean setPorts() {
    if (_buttonPressed != 99){
      return true;
    }
    return false;
  }
  



  boolean createPorts(int buttonPressed){
    if (buttonPressed == _buttonPressed){
      return true;
    }
    return false;
  }
  
  void update(int[] arr){
    if (mousePressed){
      for (int x = 0; x < (_cols * _rows); x++){
        if (buttons[x].MouseIsOver()){
          buttons[x].Draw(123);
          _buttonPressed = x;
          _buttonArray[x] = 1;
          if (arr[x] == 1){
            arr[x] = 0;
            delay(100);
          }
          else {
            arr[x] = 1;
            delay(100);
          }
          }
        }
      }
      updateColor(arr);
  }
  
    void update(){
    if (mousePressed){
      for (int x = 0; x < (_cols * _rows); x++){
        if (buttons[x].MouseIsOver()){
          buttons[x].Draw(123);
          _buttonPressed = x;
          _buttonArray[x] = 1;
        }
      }
    }
  }
  
  void updateColor(int[] arr){
    for (int x = 0; x < (_cols * _rows); x++){
      if (arr[x] == 1){
        buttons[x].Draw(#08a830);
      }
      else {
        buttons[x].Draw(#a81808);
      }
    }
  }
  

  
}
