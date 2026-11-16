//week11_2_arduino_joystick_
//要把 joystick的A0,A1接起來讀資料

void setup() {
  Serial.begin(9600);
}

void loop() {
  int x = analogRead(A0);//讀入x座標
  int y = analogRead(A1);//讀入y座標
  int sw = digitalRead(2);// joystick壓紐
  char line[200];
  sprintf(line, "x:%d y:%d sw:%d\n", x, y, sw);
  Serial.println(line);
  //如果太吵 想要暫停 把MakerUno的跳針,往左推
}
