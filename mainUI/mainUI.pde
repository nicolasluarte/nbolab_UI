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
int UIW = 600;
int UIH = 600;
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
int[] FR = new int[1];

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
  String[] buttonLabels = {"2. Raspberry Pi Menu", "3. Lickometer/Arduino Menu"};
  menuButtons = new manyButtons(UIW, UIH, 0, 0, 1, 2, buttonLabels);
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
  String[] ports = Serial.list();
  arduinoPorts = new ArrayList<String>();
  selectLabels = new ArrayList<String>();
  String[] sendArduinoConfigLabels = {"Crear conexion con puertos", "Enviar configuracion"};
  String[] incrementLabels = {str(FR[0])};
  // just for debug
  // arduinoPorts.add("USB00");
  for (int i = 0; i < ports.length; i++){
    if (match(ports[i], "USB") != null){
      arduinoPorts.add(ports[i]);
      //portsArr[i] = new Serial(this, ports[i], 9600);
      selectLabels.add("X");
    }
  }
  int arduinoPortsSize = arduinoPorts.size();
    increment = new manyButtons(UIW/2, UIH/4, 0, UIH/2, 1, 1, incrementLabels);
    arduinoPortsButtons = new manyButtons(UIW/2, UIH/arduinoPortsSize-(UIH/2), 0, 0, 1, arduinoPortsSize, arduinoPorts);
    arduinoSelectPorts = new manyButtons(UIW/2, UIH/arduinoPortsSize-(UIH/2), UIW/2, 0, 1, arduinoPortsSize, selectLabels);
    sendArduinoConfig = new manyButtons(UIW/2, UIH/4, UIW/2, UIH/2, 1, 2, sendArduinoConfigLabels);
    arduinoPortsButtons.update();
    arduinoSelectPorts.update(portArray);
    sendArduinoConfig.update();
    increment.update();
    increment.incrementNumber(0, FR);
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
    arduinoPortsButtons.pingArduino(portsArr);
}


  void mouseClicked(){
    clicked = true;
  }
