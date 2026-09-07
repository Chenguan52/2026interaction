// week01_4_painter
//(功能更多)小畫家
void setup(){
   size(500, 500); 
   background(255);//白色背景
   strokeWeight(5);//筆畫的重量粗細
}

void draw(){
   if(mousePressed) {
     if(mouseButton==LEFT) stroke(0);
     if(mouseButton==RIGHT) stroke(255);
     
     line(mouseX, mouseY, pmouseX, pmouseY); //固定座標紀錄
   }
}
