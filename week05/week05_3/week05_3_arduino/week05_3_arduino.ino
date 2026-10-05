//week05-3-arduino-do-re-mi_serial_blink
//修改自week02-5程式
//ARDUINO在 processing按下
//有對應的分號閃閃發亮


void setup() {
  pinMode(8, OUTPUT); //Buzzer 8 聲音
  pinMode(10, OUTPUT); //對應'0'
  pinMode(11, OUTPUT); //對應'1'
  pinMode(12, OUTPUT); //對應'2'
  pinMode(13, OUTPUT); //對應'3'
  
  
  Serial.begin(9600);//USB Serial 開始傳輸 速度9600bps
  tone(8, 523, 100); delay(200); //Do
  tone(8, 587, 100); delay(200); //Re
  tone(8, 659, 100); delay(200); //Mi
  tone(8, 587, 100); delay(200); //Re
  tone(8, 523, 100); delay(200); //Do
  
}

char c = '0'; //在外宣告變數
void loop() {
  // put your main code here, to run repeatedly:
    if(Serial.available()){
      c = Serial.read();
    }

    
    for(int i=10; i<=13; i++) digitalWrite(i, LOW);
    if(c>='0' && c<='3') digitalWrite(c-'0'+10,HIGH);
    if (c=='0') noTone(8);// 不發出聲音
    if (c=='1') tone(8,523);// Do 1秒
    if (c=='2') tone(8,587);// Re 1秒
    if (c == '3') tone(8, 659); // 3 (Mi)  659 Hz, 1秒
    if (c == '4') tone(8, 698); // 4 (Fa)  698 Hz, 1秒
    if (c == '5') tone(8, 784); // 5 (Sol) 784 Hz, 1秒
    if (c == '6') tone(8, 880); // 6 (La)  880 Hz, 1秒
  }
