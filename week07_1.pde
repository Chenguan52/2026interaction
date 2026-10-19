// week07_1_processing_audio_Soundfile_play
// File-Preference
// 想要在電腦用程式控制聲音的輸入
// 方法1:Processing的Sound 外掛， 方法2:Minim的外掛 
// Sketch - Library - Manage Library 
// 或者用 google:processing sound
// Moodle【上課用軟體】有一份sound.zip
// 把三個資料夾的Sound 放在「文件-Processing-Library」目錄裡

import processing.sound.*;
SoundFile sound;
void setup(){
  size(500, 500);
  sound = new SoundFile(this, "RASEN Acoustic Ver - 9Lana.mp3");//檔名
  sound.play(); //準備好 music.mp3 拉進程式，撥放
}
void draw(){
   background(0);
   translate(250, 250);
   //translate(mouseX, mouseY);
   //println(mouseX, mouseY);
   rotate( radians(frameCount));
   rect(-200, -200, 400, 400); 

}
