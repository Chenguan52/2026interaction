// week01_3_painter
// 做一個簡單的小畫家
void setup(){
   size(500, 500);
  
}
void draw(){//畫筆
  if(mouseButton==LEFT) stroke(255, 0, 0);//左鍵紅色
  if(mouseButton==RIGHT) stroke(0, 0, 255);// 右鍵藍色
  if(mouseButton==CENTER) stroke(0, 255, 0);// 中鍵綠色
  if(mousePressed) line(mouseX, mouseY, pmouseX, pmouseY);
  // 按下去時 用剛剛色彩畫線，滑鼠的座標
}
//不懂的字 可以右鍵Find in reference 參考文件
