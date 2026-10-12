//week06-1-arduino-pin-2-button-INPUT-PULLUP

void setup() {
  pinMode(2, INPUT_PULLUP); //預設pin2 是 Button
  pinMode(8, OUTPUT); //預設pin8是 Buzzer 喇叭
  tone(8, 523, 100); //開啟時發出聲音 代表成功啟動
  
}

void loop() {
  if ( digitalRead(2) == LOW) {
    tone(8, 523, 100); //0.1秒
    delay(100); //等一下(讓聲音夠長)
  }

}
