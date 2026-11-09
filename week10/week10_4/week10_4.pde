// week10_4_processing_2048
// 修改自week10_3_processing_2048
// 按下方向鍵 keyPressed 讓他生出新的方塊
void setup(){
 size(550, 550); //制定範圍
 genNewBlock();
}

//int [][] a={{0,2,0,0},{0,0,0,0},{0,2,2,2},{4,4,4,4}};
int [][]a = new int[4][4];
void genNewBlock(){
   int zeros = 0;
   for(int i=0; i<4; i++){
     for(int j=0; j<4; j++){
       if(a[i][j]==0) zeros++;
     }
   }
   
   int choose = int(random(zeros));
   for(int i=0; i<4; i++){
     for(int j=0;j<4; j++){
       if(a[i][j]==0){
         if(choose==0) a[i][j] = 2;
         choose--;
       }
     }
   }
}

void keyPressed(){
  if(keyCode==RIGHT){ //右鍵往右
   for(int i=0; i<4; i++){
    int j2 = 3; //最右邊格子
    for(int j=3; j>=0; j--){
      if(a[i][j]>0){ //有格子 要移動
       int temp = a[i][j2]; //有點像交換
       a[i][j2]= a[i][j]; //移動最右邊
       a[i][j] = temp;
       j2--;// 次右邊
        }
       }
     }
   }else if(keyCode==LEFT){ //左鍵往左
    for(int i=0; i<4; i++){
     int j2 = 0; //最左邊格子
     for(int j=0; j<4; j++){
      if(a[i][j]>0){ //有格子 要移動
        int temp = a[i][j2];//有點像交換
        a[i][j2] = a[i][j]; //
        a[i][j] = temp;
        j2++;//
       }
      }
     }
    }else if(keyCode==UP){
      for(int j=0; j<4; j++){
        int i2= 0;
      for(int i=0; i<4; i++){
        if(a[i][j]>0){
        int temp = a[i2][j];//有點像交換
        a[i2][j] = a[i][j]; //
        a[i][j] = temp;
        i2++;
       }
      }
     }
    }else if(keyCode==DOWN){
      for(int j=0; j<4; j++){
        int i2= 3;
      for(int i=0; i<4; i++){
        if(a[i][j]>0){
        int temp = a[i2][j];//有點像交換
        a[i2][j] = a[i][j]; //
        a[i][j] = temp;
        i2--;
    }
   }
  }
 }
   genNewBlock();
  }


void draw(){ 
   background(250, 248, 239); //背景
   fill(119, 101, 110); //大格子的色彩
   rect(40, 40, 450, 450, 9);
   for(int i=0; i<4; i++){
     for(int j=0; j<4; j++){
       int x = 50 + j * (100+10); //微調座標
       int y = 50 + i * (100+10);
       fill( tileColor (a[i][j])); //小格子的色彩
       rect(x,y, 100, 100, 6);
     }
   }
}

int tileColor(int n) {
  switch(n) {
    case 0:return color(205,193,180);
    case 2:return color(238,228,218);
    case 4:return color(237,224,200);
    case 8:return color(242,177,121);
    case 16:return color(245,149,99);
    case 32:return color(246,124,95);
    case 64:return color(246,94,59);
    case 128:return color(237,207,114);
    case 256:return color(237,204,97);
    case 512:return color(237,200,80);
    case 1024:return color(237,197,63);
    default:return color(237,194,46);
  
  }
}
