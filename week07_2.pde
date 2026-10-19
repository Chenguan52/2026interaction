// week07_2_processing_audio_two_SoundFile
// 修改自 week07_1_processing_audio_Soundfile_play

import processing.sound.*;
SoundFile sound;
SoundFile sound2;

void setup(){
  size(500, 500);
  sound = new SoundFile(this, "music.mp3");//檔名
  sound2 = new SoundFile(this, "mi.wav");
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

void mousePressed(){
   sound2.play();
}
