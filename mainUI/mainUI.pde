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
int currentMenu = 1;
boolean click;

void setup(){
  // file for ping check
  raspberryIp = loadStrings("ip.txt");
  raspberryPing = loadStrings("pingCheck.csv");
  pings = int(split(raspberryPing[0], ','));
  // setup main screen
  size(600, 600);
  // setup font
  textFont(createFont("Fira Code", 12));
}
void draw(){
  switch(currentMenu) {
    case 1: mainMenu(); break;
    case 2: menu2(); break;
  } 

}

void keyReleased() {
  // Check for menu
  if(key == '1') { currentMenu = 1; }
  if(key == '2') { currentMenu = 2; }
  if(key == '3') { currentMenu = 3; }
  if(key == '4') { currentMenu = 4; }
}

void mainMenu(){
   changeStatusColor();
   for (int i = 0; i < piNumber; i++) {
     fill(#000000);
     text("Pi " + i + " " + raspberryIp[i], 0, offset * i + offset);
     // turns green when ping successful
     fill(status[i]);
     rect(170, offset * i + offset - 10, 10, 10);
   }
   manyButtons b;
   b = new manyButtons(600, 600, 2, 2, new String[]{"asd", "dsa", "aaaa", "alksdj"});
   if(b.buttons[3].MouseIsOver() && click){
     print("x");
     click = false;
   }
}

void menu2(){
  clear();
   Button a;
   a = new Button("test2", 200, 200, 100, 50);
   a.Draw();
}

  void mouseClicked(){
    click = true;
  }
