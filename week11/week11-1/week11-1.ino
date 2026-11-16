//week11_1_arduino_joystick_analogRead_A0_A1
//要把 joystick的A0,A1接起來讀資料

void setup() {
  
}

void loop() {
  int x = analogRead(A0);//讀入x座標
  int y = analogRead(A1);//讀入y座標
  tone(8, x);
  //如果太吵 想要暫停 把MakerUno的跳針,往左推

  
}
