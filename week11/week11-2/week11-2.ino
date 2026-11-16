//week11_2_arduino_joystick_serial_printin
//這個會用到Arduino右上角 Serial Monitor

void setup() {
  Serial.begin(9600);
}

void loop() {
  int x = analogRead(A0);//讀入x座標
  int y = analogRead(A1);//讀入y座標
  int sw = digitalRead(2);// joystick壓紐
  if(digitalRead(2)==LOW) sw = 1;
  else sw = 0; //按下去會顯示0
  char line[200];
  sprintf(line, "x:%d y:%d sw:%d\n", x, y, sw);
  Serial.println(line);
}
