import processing.serial.*;
import controlP5.*;

// string array that holds all the raspberry pi ip's
String[] raspberryIp;
// load text file
String[] raspberryPing;
String[] repoStatus;
// transform from csv to int for easy handle
int[] pings;
int piNumber = 4;
int offset = 50;
color[] status = new color[4];
// menu related variables
int UIW = 700;
int UIH = 700;
int currentMenu = 1;
boolean clicked = false;
manyButtons menuButtons;
manyButtons piButtons;
manyButtons piStatus;
manyButtons arduinoButtons;
manyButtons arduinoPortsButtons;
manyButtons arduinoSelectPorts;
manyButtons sendArduinoConfig;
manyButtons increment;
ArrayList<String> arduinoPorts;
ArrayList<String> selectLabels;
boolean createdPorts = false;
int[] portArray = new int[64];
Serial[] portsArr = new Serial[64];
int[] config = new int[16];
String[] ratioTypes = {"Fixed Ratio", "Random Ratio", "Progressive Ratio"};

void settings(){
    size(UIW, UIH);
}

void setup(){
  // file for ping check
  raspberryIp = loadStrings("ip.txt");
  raspberryPing = loadStrings("pingCheck.csv");
  pings = int(split(raspberryPing[0], ','));
  // setup main scree
  // setup font
  textFont(createFont("Fira Code", 12));
}
void draw(){
  switch(currentMenu) {
    case 1: mainMenu(); break;
    case 2: piMenu(); break;
    case 3: arduinoMenu(); break;
  } 

}

void keyReleased() {
  // Check for menu
  if(key == '0') { currentMenu = 0; }
  if(key == '1') { currentMenu = 1; }
  if(key == '2') { currentMenu = 2; }
  if(key == '3') { currentMenu = 3; }
  if(key == '4') { currentMenu = 4; }
}

void mainMenu(){
  clear();
  String[] buttonLabels = {"*Sistema de alimentacion operante*\n\n Presione los numeros para acceder a menus",
                            "2. Raspberry Pi Menu", "3. Lickometer/Arduino Menu"};
  menuButtons = new manyButtons(UIW, UIH, 0, 0, 1, buttonLabels.length, buttonLabels);
}

void piMenu(){
  clear();
  String[] buttonsLabels = {"Ping RaspberryPi", "Set NFS", "Set Packages", "Get Cam Video", "Preview Pi"};
  String[] piLabels = {"Raspberry Pi 0", "Raspberry Pi 1", "Raspberry Pi 2", "Raspberry Pi 3"};
  piButtons = new manyButtons(UIW/2, UIH, 0, 0, 1, 5, buttonsLabels); 
  piStatus = new manyButtons(UIW/2, UIH, UIW/2, 0, 1, 4, piLabels);
  piStatus.update();
  piButtons.update();
  piStatus.updatePing();
  piButtons.Ping(0);
  piButtons.SetNFS(1);
  piButtons.SetPackages(2);
  piButtons.getCamVid(3);
  piButtons.piPreview(4);
}

void arduinoMenu(){
  clear();
  background(255);
  String[] ports = Serial.list();
  arduinoPorts = new ArrayList<String>();
  selectLabels = new ArrayList<String>();
  String[] sendArduinoConfigLabels = {"Crear conexion con puertos", "Enviar configuracion"};

  // just for debug
  // arduinoPorts.add("USB00");
  for (int i = 0; i < ports.length; i++){
    if (match(ports[i], "tty") != null){
      arduinoPorts.add(ports[i]);
      selectLabels.add("Click para seleccionar puerto");
    }
  }

  for (int i = 0; i < arduinoPorts.size(); i++){
    if (portArray[i] == 1){
    selectLabels.set(i,"Puerto seleccionado\n Hace clic en el puerto");
    }
  }
    String[] incrementLabels = {"Experimento", str(boolean(config[0])),
                              "FR", str(config[1]),
                            "Activar Spout 0", str(boolean((config[2]))),
                          "Activar Spout 1", str(boolean((config[3]))),
                        "Activar Plate", str(boolean((config[4]))),
                      "Tipo Ratio Spout 0", ratioTypes[abs(config[5]) % 3],
                    "Tipo Ratio Spout 1", ratioTypes[abs(config[6]) % 3],
                  "Tiempo en Plate", str(config[7] * 1000) + " ms.",
                "Time out", str(config[8] * 1000) + " ms.",
                "Puerto", arduinoPorts.get(config[9]),
              "Probar Bombas", "{O}"};
                
    int arduinoPortsSize = arduinoPorts.size();
    increment = new manyButtons(UIW/2, UIH/2, 0, UIH/2, 2, incrementLabels.length/2, incrementLabels);
    arduinoPortsButtons = new manyButtons(UIW/2, UIH/2, 0, 0, 1, arduinoPortsSize, arduinoPorts);
    arduinoSelectPorts = new manyButtons(UIW/2, UIH/2, UIW/2, 0, 1, arduinoPortsSize, selectLabels);
    sendArduinoConfig = new manyButtons(UIW/2, UIH/4, UIW/2, UIH/2, 1, 2, sendArduinoConfigLabels);
    arduinoSelectPorts.update(portArray);
    sendArduinoConfig.update();
    sendArduinoConfig.sendConfig(portsArr, 1, config[9], config);
    increment.update();
    increment.incrementNumber(1, config, 0, true);
    increment.incrementNumber(3, config, 1);
    increment.incrementNumber(5, config, 2, true);
    increment.incrementNumber(7, config, 3, true);
    increment.incrementNumber(9, config, 4, true);
    increment.incrementList(11, config, 5, ratioTypes.length); // *
    increment.incrementList(13, config, 6, ratioTypes.length);
    increment.incrementNumber(15, config, 7);
    increment.incrementNumber(17, config, 8);
    increment.incrementList(19, config, 9, arduinoPorts.size());
    if (sendArduinoConfig.setPorts(0) || arduinoPortsButtons.setPorts()){
        for (int i = 0; i < arduinoPorts.size(); i++){
          if (portArray[i] == 1){
            portsArr[i] = new Serial(this, arduinoPorts.get(i), 9600);
          }
          else{
            portsArr[i] = null;
          }
        }
      }
    arduinoPortsButtons.update();
    arduinoPortsButtons.pingArduino(portsArr);
    increment.blinkSensor(portsArr, 4, config[9], 1);
    increment.blinkSensor(portsArr, 6, config[9], 2);
    increment.blinkSensor(portsArr, 8, config[9], 3);
    increment.testMotors(portsArr, 20, config[9]);
}


  void mouseClicked(){
    clicked = true;
  }
