class manyButtons{
  
  int _canvasW;
  int _canvasH;
  int _cols;
  int _rows;
  int _counter;
  String _labels[];
  Button[] buttons;
  
  manyButtons(int canvasW, int canvasH, int cols, int rows, String labels[]){
    _canvasW = canvasW;
    _canvasH = canvasH;
    _cols = cols;
    _rows = rows;
    _labels = labels;
    _counter = 0;
    
    buttons = new Button[_cols * _rows];
    for (int i = 0; i < _rows; ++i){
      for (int j = 0; j < _cols; ++j){
        buttons[_counter] = new Button(labels[_counter], j * (_canvasW / _cols), i * (_canvasH / _rows), _canvasW / _cols, (_canvasH / _rows));
        buttons[_counter].Draw();
        ++_counter;
      }
    }
  }  
}
