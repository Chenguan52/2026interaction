//week06-4
//改自week06_2


int mode = 0; //0:從小變到大, 1:從大變到小

void setup() {
  Serial.begin(9600);
  pinMode(2, INPUT_PULLUP);
  for(int i=3; i<=13; i++){  
    pinMode(i, OUTPUT);
  }
  tone(8, 523, 100); delay(100);//DO
  tone(8, 784, 100); delay(100);//MI
}
int prev = HIGH, now = 3; //prev是按鈕的狀態,now現在要發亮的LED;
void loop() {
  if( prev == HIGH && digitalRead(2) == LOW ){
    if(mode == 0){
      mode = 1;
      tone(8, 784, 100); delay(100);//MI
      tone(8, 523, 100); delay(100);//DO
    }
    else{
      mode = 0;
      tone(8, 523, 100); delay(100);//DO
      tone(8, 784, 100); delay(100);//MI
    }

    prev = LOW; //把前面的音放在這裡

    if(mode==1) Serial.write('1');   
    if(mode==0) Serial.write('0');
  }else if ( prev == LOW && digitalRead(2) == HIGH ){
    prev = HIGH;
  }
  
  
  if(mode == 0){//0:從小變到大, 1:從大變到小
    now++;
    if (now>13) now - 3;
  }else{
    now--;
    if(now<3) now=13;
  }
    digitalWrite(now, HIGH);
    delay(100);
    digitalWrite(now, LOW);
    
 }













 
