//week01_5_painter
//gemini:processing怎麼用到mouse wheel

float circleSize = 50; // 初始圓形大小
void setup(){
    size(500, 500);
}

void draw() {
  background(220);
  fill(0, 150, 150);
  noStroke();
  
  // 在畫面中央畫一個圓
  ellipse(width/2, height/2, circleSize, circleSize);
}

// 偵測滑鼠滾輪的專用函式
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  
  // e 的值通常是：
  // 1  (向下捲動 / 向後滾)
  // -1 (向上捲動 / 向前滾)
  
  circleSize += e * 5; // 根據捲動方向改變圓的大小
  
  // 限制圓形大小，避免變成負數或太大
  circleSize = constrain(circleSize, 10, 300);
}
