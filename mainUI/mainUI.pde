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
ArrayList<String> arduinoPorts;
boolean createdPorts = false;

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
  String[] buttonLabels = {"Configuracion de puertos", "Configuracion Lickometro", "Recoleccion de datos"};
  arduinoButtons = new manyButtons(UIW/2, UIH, 0, 0, 1, 3, buttonLabels);
  String[] ports = Serial.list();
  arduinoPorts = new ArrayList<String>();
  for (int i = 0; i < ports.length; i++){
    if (match(ports[i], "USB") != null){
      arduinoPorts.add(ports[i]);
    }
  }
  int arduinoPortsSize = arduinoPorts.size();
    arduinoPortsButtons = new manyButtons(UIW/2, UIH/arduinoPortsSize, UIW/2, 0, 1, arduinoPortsSize, arduinoPorts);
    arduinoPortsButtons.update();
    arduinoButtons.update();
}


  void mouseClicked(){
    clicked = true;
  }
