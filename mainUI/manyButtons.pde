class manyButtons {

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

    manyButtons(int canvasW,
                int canvasH,
                int offSetX,
                int offSetY,
                int cols,
                int rows,
                String labels[]) {
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
        for (int i = 0; i < _rows; ++i) {
            for (int j = 0; j < _cols; ++j) {
                buttons[_counter] = new Button(labels[_counter], j * (_canvasW / _cols) + _offSetX, i * (_canvasH / _rows) + _offSetY, _canvasW / _cols, (_canvasH / _rows));
                buttons[_counter].Draw();
                ++_counter;
            }
        }
    }

    manyButtons(int canvasW,
                int canvasH,
                int offSetX,
                int offSetY,
                int cols,
                int rows,
                ArrayList<String> labels) {
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
        for (int i = 0; i < _rows; ++i) {
            for (int j = 0; j < _cols; ++j) {
                buttons[_counter] = new Button(labels.get(_counter), j * (_canvasW / _cols) + _offSetX, i * (_canvasH / _rows) + _offSetY, _canvasW / _cols, (_canvasH / _rows));
                buttons[_counter].Draw();
                ++_counter;
            }
        }
    }

    int changeMenu() {
        return _buttonPressed;
    }

    void updatePing() {
        raspberryPing = loadStrings("pingCheck.csv");
        pings = int(split(raspberryPing[0], ','));
        for(int x = 0; x < (_cols * _rows); x++) {
            if (pings[x] == 1) {
                buttons[x].Draw(#00b509);
            }
            else if (pings[x] == 3) {
                buttons[x].Draw(#f2f542);
            }
            else {
                buttons[x].Draw(#f54242);
            }
        }
    }

    void Ping(int buttonPressed) {
        if (buttonPressed == _buttonPressed) {
            String pingAllScript = dataPath("") + "/linux_scripts/pingall.sh";
            String pingReset = dataPath("") + "/linux_scripts/resetping.sh";
            exec(pingReset);
            exec(pingAllScript);
        }
    }

    void SetNFS(int buttonPressed) {
        if (buttonPressed == _buttonPressed) {
            String setNFS = dataPath("") + "/linux_scripts/setNFS.sh";
            exec(setNFS);
        }
    }

    void SetPackages(int buttonPressed) {
        if (buttonPressed == _buttonPressed) {
            String setPackages = dataPath("") + "/linux_scripts/setPackages.sh";
            exec(setPackages);
        }
    }

    void getCamVid(int buttonPressed) {
        if (buttonPressed == _buttonPressed) {
            String getCamVid = dataPath("") + "/linux_scripts/getCamVid.sh";
            exec(getCamVid);
        }
    }

    void piPreview(int buttonPressed) {
        if (buttonPressed == _buttonPressed) {
            String playCamVid = dataPath("") + "/linux_scripts/playCamVid.sh";
            exec(playCamVid);
        }
    }

    void pingArduino(Serial[] port) {
        if (_buttonPressed != 99 && port[_buttonPressed] != null) {
            buttons[_buttonPressed].Draw(123);
            port[_buttonPressed].clear();
            String msg = "<15000000001>";
            port[_buttonPressed].write(msg); // tells arduino to blink led
            delay(100);
            port[_buttonPressed].write("<05000000000>"); // stops blink
        }
    }

    void pingArduino(Serial[] port, int buttonPressed) {
        if (buttonPressed == _buttonPressed && port[_buttonPressed] != null) {
            port[_buttonPressed].clear();
            port[_buttonPressed].write("<15000000002>"); // tells arduino to blink led
            delay(1000);
            port[_buttonPressed].write("<15000000000>"); // stops blink
        }
    }

    void blinkSensor(Serial[] port, int buttonPressed, int portNumber, int sensor) {
        if (buttonPressed == _buttonPressed && port[portNumber] != null) {
            port[portNumber].clear();
            String msg = "<15000000000" + sensor + ">";
            port[portNumber].write(msg); // tells arduino to blink led
            delay(1000);
            port[portNumber].write("<150000000000>"); // stops blink
        }
    }

    void testMotors(Serial[] port, int buttonPressed, int portNumber) {
        if (buttonPressed == _buttonPressed && port[portNumber] != null) {
            port[portNumber].clear();
            String msg = "<1500000000001>";
            port[portNumber].write(msg); // tells arduino to blink led
            delay(1000);
            port[portNumber].write("<1500000000000>");
        }
    }

    void sendConfig(Serial[] port, int buttonPressed, int portNumber, int[] config) {
        if (buttonPressed == _buttonPressed && port[portNumber] != null) {
            config[9] = 1; // signals a new configuration
            port[portNumber].clear();
            String[] CONFIG = str(config);
            CONFIG[0] = str(1);
            CONFIG[1] = str(char(config[1]));
            String msg = "<" + join(CONFIG, "") + ">";
            port[portNumber].write(msg);
            delay(1000);
            port[portNumber].clear();
        }
    }

    void incrementNumber(int buttonPressed, int[] counter, int idx) {
        if (buttonPressed == _buttonPressed) {
            if(mouseButton == LEFT) {
                counter[idx] = counter[idx] + 1;
            }
            else if (mouseButton == RIGHT) {
                counter[idx]= counter[idx] - 1;
            }
            delay(100);
        }
    }

    void incrementList(int buttonPressed, int[] counter, int idx, int len) {
        if (buttonPressed == _buttonPressed) {
            if(mouseButton == LEFT) {
                counter[idx] = counter[idx] + 1;
                counter[idx] = counter[idx] % len;
            }
            delay(100);
        }
    }

    void incrementNumber(int buttonPressed, int[] counter, int idx, boolean toggle) {
        if (toggle) {
            if (buttonPressed == _buttonPressed) {
                if(counter[idx] == 0) {
                    counter[idx] = 1;
                }
                else if (counter[idx] == 1) {
                    counter[idx] = 0;
                }
                delay(100);
            }
            else {
                if (buttonPressed == _buttonPressed) {
                    if(mouseButton == LEFT) {
                        counter[idx] = counter[idx] + 1;
                    }
                    else if (mouseButton == RIGHT) {
                        counter[idx]= counter[idx] - 1;
                    }
                    delay(100);
                }
            }
        }
    }


    boolean setPorts(int buttonPressed) {
        if (buttonPressed == _buttonPressed) {
            return true;
        }
        return false;
    }

    boolean setPorts() {
        if (_buttonPressed != 99) {
            return true;
        }
        return false;
    }




    boolean createPorts(int buttonPressed) {
        if (buttonPressed == _buttonPressed) {
            return true;
        }
        return false;
    }

    void update(int[] arr) {
        if (mousePressed) {
            for (int x = 0; x < (_cols * _rows); x++) {
                if (buttons[x].MouseIsOver()) {
                    buttons[x].Draw(123);
                    _buttonPressed = x;
                    _buttonArray[x] = 1;
                    if (arr[x] == 1) {
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

    void update() {
        if (mousePressed) {
            for (int x = 0; x < (_cols * _rows); x++) {
                if (buttons[x].MouseIsOver()) {
                    buttons[x].Draw(123);
                    _buttonPressed = x;
                    _buttonArray[x] = 1;
                    delay(100);
                }
            }
        }
    }

    void updateColor(int[] arr) {
        for (int x = 0; x < (_cols * _rows); x++) {
            if (arr[x] == 1) {
                buttons[x].Draw(#08a830);
            }
            else {
                buttons[x].Draw(#a81808);
            }
        }
    }
    



}
