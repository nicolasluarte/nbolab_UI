import processing.serial.*;
import controlP5.*;


void settings() {
    size(UIW, UIH);
}

/*
 * raspberryIp: load the ip for every connected pi, this file needs to be edited
 * manually
 * raspberryPing: is a text file that is updated with a bash script, tries to ping
 * every pi and writes if it made it or not
 * pings: stores de ping file into memory
 *
 */
void setup() {
    raspberryIp = loadStrings("ip.txt");
    raspberryPing = loadStrings("pingCheck.csv");
    pings = int(split(raspberryPing[0], ','));
    table = new Table();
    table.addColumn("sensor0");
    table.addColumn("sensor1");
    table.addColumn("plateSensor");
    table.addColumn("spout0Events");
    table.addColumn("spout1Events");
    table.addColumn("spout0TotalLicks");
    table.addColumn("spout1TotalLicks");
    table.addColumn("plateValidTime");
    table.addColumn("spout0Ratio");
    table.addColumn("spout1Ratio");
    table.addColumn("FR");
    table.addColumn("spout0Active");
    table.addColumn("spout1Active");
    table.addColumn("plateActive");
    table.addColumn("scheduleSpout0");
    table.addColumn("scheduleSpout1");
    table.addColumn("plateTime");
    table.addColumn("timeOut");
    table.addColumn("experimentFlag");
    table.addColumn("millis");
}

/*
 * very simple way to move between menus with the keyboard
 */
void draw() {
    switch(currentMenu) {
    case 1:
        mainMenu();
        break;
    case 2:
        piMenu();
        break;
    case 3:
        arduinoMenu();
        break;
    }
}

/*
 * handles the menu swithching
 */

void keyReleased() {
    // Check for menu
    if (key == '0') {
        currentMenu = 0;
    }
    if (key == '1') {
        currentMenu = 1;
    }
    if (key == '2') {
        currentMenu = 2;
    }
    if (key == '3') {
        currentMenu = 3;
    }
    if (key == '4') {
        currentMenu = 4;
    }
}

void mainMenu() {
    clear();
    String[] buttonLabels = {"*Sistema de alimentacion operante*\n\n Presione los numeros para acceder a menus",
                             "2. Raspberry Pi Menu",
                             "3. Lickometer/Arduino Menu"
                            };
    menuButtons = new manyButtons(UIW, // button frame width
                                  UIH, // button frame height
                                  0, // offset x-axis
                                  0, // offset y-axis
                                  1, // frame column number
                                  buttonLabels.length, // frame row number
                                  buttonLabels);
}

void piMenu() {
    clear();
    String[] buttonsLabels = {"Ping RaspberryPi",
                              "Set NFS",
                              "Set Packages",
                              "Get Cam Video",
                              "Preview Pi"
                             };
    String[] piLabels = {"Raspberry Pi 0",
                         "Raspberry Pi 1",
                         "Raspberry Pi 2",
                         "Raspberry Pi 3"
                        };
    piButtons = new manyButtons(UIW/2,
                                UIH,
                                0,
                                0,
                                1,
                                5,
                                buttonsLabels);
    piStatus = new manyButtons(UIW/2,
                               UIH,
                               UIW/2,
                               0,
                               1,
                               4,
                               piLabels);
    piStatus.update(); // .udpate() is a method to get the pressed number within a button frame
    piButtons.update();
    piStatus.updatePing();
    piButtons.Ping(0); // the parameter specifies the button number that activates the function
    piButtons.SetNFS(1);
    piButtons.SetPackages(2);
    piButtons.getCamVid(3);
    piButtons.piPreview(4);
}

void arduinoMenu() {
    int start = millis();
    clear();
    background(255);
    // port related declarations
    selectLabels = new ArrayList<String>();
    String[] ports = Serial.list();
    arduinoPorts = new ArrayList<String>();
    // this for loop matches for "USB" in serial port list
    // in linux serial ports are USB followed by a number
    // is it finds a USB serial port adds it to arduiPorts array list
    // also creates a label for each valid port
    for (int i = 0; i < ports.length; i++) {
        if (match(ports[i], "USB|ACM") != null) {
            arduinoPorts.add(ports[i]);
            selectLabels.add("Click para seleccionar puerto");
        }

    }

    // labels for buttons
    readArduinoLabels = new ArrayList<String>();
    for (int i = 0; i < arduinoPorts.size(); i++){
      readArduinoLabels.add(arduinoPorts.get(i));
      readArduinoLabels.add("Spout 0" + "E: " + str(R[3]));
      readArduinoLabels.add("Spout 1" + "E: " + str(R[4]));
      readArduinoLabels.add("Plate");
    }
//    String[] readArduinoLabels = {arduinoPorts.get(0), "Spout 0" + " E: " + str(R[3]),
//  "Spout 1" + " E: " + str(R[4]),
//"Plate"};
    String[] sendArduinoConfigLabels = {"Crear conexion con puertos",
                                        "Enviar configuracion"
                                       };
                                       
    String[] incrementLabels = {"Experimento", str(boolean(config[0])),
                                "FR", str(config[1] % 128), // sent as ascii code so max is 128
                                "Activar Spout 0", str(boolean((config[2]))),
                                "Activar Spout 1", str(boolean((config[3]))),
                                "Activar Plate", str(boolean((config[4]))),
                                "Tipo Ratio Spout 0", ratioTypes[abs(config[5]) % 3],
                                "Tipo Ratio Spout 1", ratioTypes[abs(config[6]) % 3],
                                "Tiempo en Plate", str(config[7] * 1000) + " ms.",
                                "Time out", str(config[8] * 1000) + " ms.",
                                "Puerto", arduinoPorts.get(config[13]),
                                "Probar Bombas", "{O}"
                               };
                             

    // when a port is selected by the user the label changes
    // just to make it more user friendly
    for (int i = 0; i < arduinoPorts.size(); i++) {
        if (portArray[i] == 1) {
            selectLabels.set(i, "Puerto seleccionado\n Hace clic en el puerto");
        }
    }


    // buttons instantiations
    int arduinoPortsSize = arduinoPorts.size();
    // buttons for setting experimental variables
    increment = new manyButtons(UIW/2, UIH/2, 0, UIH/2, 2, incrementLabels.length/2, incrementLabels);
    // buttons to ping the ports/arduinos
    arduinoPortsButtons = new manyButtons(UIW/2, UIH/2, 0, 0, 1, arduinoPortsSize, arduinoPorts);
    // buttons to select the ports
    arduinoSelectPorts = new manyButtons(UIW/2, UIH/2, UIW/2, 0, 1, arduinoPortsSize, selectLabels);
    // button to send the configuration to the arduino
    sendArduinoConfig = new manyButtons(UIW/2, UIH/4, UIW/2, UIH/2, 1, 2, sendArduinoConfigLabels);
    // graphical representation of arduino activity
    readArduino = new manyButtons((UIW/2)/arduinoPortsSize, UIH/4, UIW/2, UIH/2+(UIH/4), 4, arduinoPortsSize, readArduinoLabels);

    // buttons updates
    increment.update();
    sendArduinoConfig.update();
    arduinoPortsButtons.update();
    arduinoSelectPorts.update(portArray);
    readArduino.update();

    // button class methods
    sendArduinoConfig.sendConfig(portsArr, 1, config[9], config);
    increment.incrementNumber(1, config, 0, true); // experiment
    increment.incrementList(3, config, 1, 128); // FR
    increment.incrementNumber(5, config, 2, true); // activate spout0
    increment.incrementNumber(7, config, 3, true); // activate spout1
    increment.incrementNumber(9, config, 4, true); // activate plate
    increment.incrementList(11, config, 5, ratioTypes.length); // ratio kind spout 0
    increment.incrementList(13, config, 6, ratioTypes.length); // ratio kind spout 1
    increment.incrementNumber(15, config, 7);
    increment.incrementNumber(17, config, 8);
    increment.incrementList(19, config, 13, arduinoPorts.size());
    // here are the methods that require a port connection, mostly blinking LEDS
    // this loop updated the established connections
    if (sendArduinoConfig.setPorts(0)) {
        for (int i = 0; i < arduinoPorts.size(); i++) {
            if (portArray[i] == 1) {
              if(portsArr[i] != null){
                portsArr[i].stop();
              }
                portsArr[i] = new Serial(this, arduinoPorts.get(i), 115200);
                println(portsArr[i].available());
                delay(10);
            } else {
                portsArr[i] = null;
            }
        }
    }
    arduinoPortsButtons.pingArduino(portsArr);
    increment.blinkSensor(portsArr, 4, config[13], 1);
    increment.blinkSensor(portsArr, 6, config[13], 2);
    increment.blinkSensor(portsArr, 8, config[13], 3);
    increment.testMotors(portsArr, 20, config[13]);
    sendArduinoConfig.sendConfig(portsArr, 1, config[13], config);
    

      //println(millis() - start);
      saveTable(table, "data/test.csv");
      
      if(port1){
        readArduino.buttons[0].Draw(#80eb34);
      }
      

}

void serialEvent(Serial p){
  port0 = p.equals(portsArr[0]);
  port1 = p.equals(portsArr[1]);
  port2 = p.equals(portsArr[2]);
  port3 = p.equals(portsArr[3]);
  if (p.available() > 0){
  r = p.readStringUntil('\n');
  if (r != null){
    //println(r);
    int sensorVals[] = int(split(r, ','));
    if(sensorVals.length > 19){
    R = sensorVals;
    TableRow newRow = table.addRow();
    newRow.setInt("sensor0", sensorVals[0]);
    newRow.setInt("sensor1", sensorVals[1]);
    newRow.setInt("plateSensor", sensorVals[2]);
    newRow.setInt("spout0Events", sensorVals[3]);
    newRow.setInt("spout1Events", sensorVals[4]);
    newRow.setInt("spout0TotalLicks", sensorVals[5]);
    newRow.setInt("spout1TotalLicks", sensorVals[6]);
    newRow.setInt("plateValidTime", sensorVals[7]);
    newRow.setInt("spout0Ratio", sensorVals[8]);
    newRow.setInt("spout1Ratio", sensorVals[9]);
    newRow.setInt("FR", sensorVals[10]);
    newRow.setInt("spout0Active", sensorVals[11]);
    newRow.setInt("spout1Active", sensorVals[12]);
    newRow.setInt("plateActive", sensorVals[13]);
    newRow.setInt("plateTime", sensorVals[14]);
    newRow.setInt("scheduleSpout0", sensorVals[15]);
    newRow.setInt("scheduleSpout1", sensorVals[16]);
    newRow.setInt("timeOut", sensorVals[17]);
    newRow.setInt("experimentFlag", sensorVals[18]);
    newRow.setInt("millis", sensorVals[19]);
    }

  }
  }

}
//void serialEvent(Serial p)
//{
//     String r = p.readStringUntil('\n');
//     if (r != null){
//    String[] rr = splitTokens(r, ",");
//    //r = trim(r);
//    inString = int(rr[0]);
//     }
//}


// to handle click event not used ATM
void mouseClicked() {
    clicked = true;
}

void stop(){
  for (int i = 0; i < portsArr.length; i++){
    portsArr[i].clear();
    portsArr[i].stop();
    portsArr[i] = null;
  }
}
