//week01_6_mousewheel_調整strokeWeight
//整合week01_4 week01_5 讓大小可被改變
float circleSize = 5;
void setup(){
   size(500, 500);
   background(255);
}

void draw(){
    strokeWeight(circleSize);
   if(mousePressed) { //mouse按下去，有兩種可能
     if(mouseButton==LEFT) stroke(0); // 黑線
     if(mouseButton==RIGHT) stroke(255);// 白線
     line(mouseX, mouseY, pmouseX, pmouseY); //固定座標紀錄
   }
   noStroke();//無外框
   rect(0, 0, 100, 100);
   stroke(0);
   strokeWeight(1);
   ellipse(50, 50, circleSize, circleSize);
}
void mouseWheel(MouseEvent e){
   circleSize = circleSize - e.getCount();
   
}
