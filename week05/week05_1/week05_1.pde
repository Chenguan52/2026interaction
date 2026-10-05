//week05-1-arduino-do-re-mi_serial
//修改自week02-5程式
//在 processing按下
//按下123對應
import processing.serial.*;
Serial myPort;
void setup(){
  size(300,200);
  myPort = new Serial(this,"COM4", 9600);
}

void draw(){

}

void keyPressed() {
  if(key=='1')myPort.write('1');
  if(key=='2')myPort.write('2');
  if(key=='3')myPort.write('3');
  if(key=='4')myPort.write('4');
  if(key=='5')myPort.write('5');
  if(key=='6')myPort.write('6');
}
