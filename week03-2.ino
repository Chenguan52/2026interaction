//week03_2_arduino_delay_???
//用delay()來延後發亮的時間
void setup(){
  //pinMode(2, INPUT_PULLUP);//第2是按鈕,沒按時拉高
  for(int i=2; i<=13; i++) pinMode(i, OUTPUT);
 }

void loop(){
    for(int i=2; i<=7; i++) digitalWrite(i, HIGH);
    for(int i=8; i<=13; i++) digitalWrite(i, LOW);
    delay(1000);//(延後一秒)
    for(int i=2; i<=7; i++) digitalWrite(i, LOW);
    for(int i=8; i<=13; i++) digitalWrite(i, HIGH);
    delay(1000);//(延後一秒)
}
