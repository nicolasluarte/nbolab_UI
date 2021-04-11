// global variables
int UIW = 700;
int UIH = 700;
int currentMenu = 1;
boolean clicked = false;

// Arduino variables
ArrayList<String> arduinoPorts;
ArrayList<String> selectLabels;
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
