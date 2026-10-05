//week05-1-arduino-do-re-mi_serial
//修改自week02-5程式
//ARDUINO在 processing按下

void setup() {
  // put your setup code here, to run once:

  Serial.begin(9600);
  tone(8, 523, 100);
  delay(200);
  tone(8, 587, 100);
  delay(200);
  tone(8, 659, 100);
  
}

void loop() {
  // put your main code here, to run repeatedly:
    
   if(Serial.available()){
    char c = Serial.read();
    if (c=='1') tone(8,523, 1000);// Do 1秒
    if (c=='2') tone(8,587, 1000);// Re 1秒
    if (c == '3') tone(8, 659, 1000); // 3 (Mi)  659 Hz, 1秒
    if (c == '4') tone(8, 698, 1000); // 4 (Fa)  698 Hz, 1秒
    if (c == '5') tone(8, 784, 1000); // 5 (Sol) 784 Hz, 1秒
    if (c == '6') tone(8, 880, 1000); // 6 (La)  880 Hz, 1秒
  }
}
