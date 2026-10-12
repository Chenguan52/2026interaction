//week06_4_processing_rotate_serial
//修改自 week06_3_process_rotate__translate
//

import processing.serial.*;
Serial myPort;
void setup(){
   size(500, 500); 
   myPort = new Serial(this, "COM3", 9600);
}
int now = 0; //現在旋轉角度
int dd = 1; //dd =1 OR -1

void draw(){
   if(myPort.available() > 0){
    if(myPort.read()=='1') dd = -1;
    else dd = 1;
   }
   background(0); //黑色背景
   translate(250, 250);
   now += dd;
   rotate( radians(now)); //持續轉動
   rect(-200, -200, 400, 400);  //座標奇怪的四邊形
}

void mousePressed(){  // mouse 點擊修改轉方向
  if(dd==1) dd = -1; //正的變負
  else dd = 1;
}
