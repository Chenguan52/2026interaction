//week09-4-processing-2048-again
//自己寫2048配上聲音
void setup(){
 size(550, 550); //制定範圍
}

void draw(){ 
   background(250, 248, 239); //背景
   fill(119, 101, 110); //大格子的色彩
   rect(40, 40, 450, 450, 9);
   for(int i=0; i<4; i++){
     for(int j=0; j<4; j++){
       int x = 50 + j * (100+10); //微調座標
       int y = 50 + i * (100+10);
       fill(238, 228, 218); //小格子的色彩
       rect(x,y, 100, 100, 6);
     }
   }
}
