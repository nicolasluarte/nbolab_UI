// global variables
int UIW = 1200;
int UIH = 800;
int currentMenu = 1;
boolean clicked = false;

// Arduino variables
ArrayList<String> arduinoPorts;
ArrayList<String> selectLabels;
ArrayList<String> readArduinoLabels;
boolean createdPorts = false;
int[] portArray = new int[64];
Serial[] portsArr = new Serial[64];
int[] config = new int[16];
String[] ratioTypes = {"Fixed Ratio", "Random Ratio", "Progressive Ratio"};

// RaspberryPi variable
String[] raspberryIp;
String[] raspberryPing;
String[] repoStatus;
int[] pings;
int piNumber = 4;
int offset = 50;
color[] status = new color[4];

// Buttons variables
manyButtons menuButtons;
manyButtons piButtons;
manyButtons piStatus;
manyButtons arduinoButtons;
manyButtons arduinoPortsButtons;
manyButtons arduinoSelectPorts;
manyButtons sendArduinoConfig;
manyButtons increment;
manyButtons readArduino;



boolean port0;
boolean port1;
boolean port2;
boolean port3;
boolean tt = true;
boolean nn = false;
String r;
int[] R = new int[20];
Table table;
