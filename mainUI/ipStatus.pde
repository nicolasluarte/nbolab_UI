void changeStatusColor(){
  raspberryPing = loadStrings("pingCheck.csv");
  pings = int(split(raspberryPing[0], ','));
  for(int x = 0; x < 4; x++){
    if (pings[x] == 1){
      status[x] = #00b509;
    }
    else if (pings[x] == 3){
      status[x] = #f2f542;
    }
    else{
      status[x] = #f54242;
    }
  }
}
