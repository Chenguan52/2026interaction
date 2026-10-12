//week06-2-arduino-button-change-mode-LED-flow
int mode = 0; //0:從小變到大, 1:從大變到小
void setup() {
  pinMode(2, INPUT_PULLUP);
  for(int i=3; i<=13; i++){  
    pinMode(i, OUTPUT);
  }
  tone(8, 523, 100); delay(100);
  tone(8, 784, 100); delay(100);
}
int prev = HIGH, now = 3; //prev是按鈕的狀態,now現在要發亮的LED;
void loop() {
  if( prev == HIGH && digitalRead(2) == LOW ){
    if(mode == 0) mode = 1; //從1變0
    else mode = 0; //從0變1
    prev = LOW;
  }else if(prev == LOW && digitalRead(2) == HIGH){ // 放開的瞬間
    prev = HIGH;
  }
  
  if(mode == 0){//0:從小變到大, 1:從大變到小
    now++;
    if(now > 13) now = 3;
    digitalWrite(now, HIGH);
    delay(100);
    digitalWrite(now, LOW);  
    }else {
    now--;
    if(now<3) now = 13;
    digitalWrite(now, HIGH);
    delay(100);
    digitalWrite(now, LOW);
  }
 }
