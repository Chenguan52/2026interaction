//week06_3_process_rotate_??
// 想要做一個會旋轉的迷宮, 程式碼要「移到畫面中心,旋轉,畫方塊」

void setup(){
   size(500, 500); 
}
void draw(){
   background(0);
   translate(250, 250);
   //translate(mouseX, mouseY);
   //println(mouseX, mouseY);
   rotate( radians(frameCount));
   rect(-200, -200, 400, 400); 
}
