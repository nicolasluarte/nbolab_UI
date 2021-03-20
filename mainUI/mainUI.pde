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
void setup(){
  // file for ping check
  raspberryIp = loadStrings("ip.txt");
  raspberryPing = loadStrings("pingCheck.csv");
  pings = int(split(raspberryPing[0], ','));
  // setup main screen
  size(600, 600);
  // setup font
  textFont(createFont("Fira Code", 12));
  createButtons();
}
void draw(){
   changeStatusColor();
   for (int i = 0; i < piNumber; i++) {
     fill(#000000);
     text("Pi " + i + " " + raspberryIp[i], 0, offset * i + offset);
     // turns green when ping successful
     fill(status[i]);
     rect(170, offset * i + offset - 10, 10, 10);
  }
}
