// week11_3_arduino_joystick_serial_
//要把Arduino的資料
import processing.serial.*;//使用USB的Serial的外掛
Serial myPort;
void setup(){
  size(512,512);
  myPort = new Serial( this, "COM3", 9600);
}
int x = 0, y = 0, sw=0;

void draw(){
   background(255);
   if(myPort.available()>= 3){
     x = (int) myPort.read();
     y = (int) myPort.read();
     sw = (int) myPort.read();
     //myPort.read();
     
  }
  ellipse( x+128, y+128, 8, 8);
}
