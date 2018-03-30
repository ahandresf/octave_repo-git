#How to record voice. 
voice_frame=record(5);#8000 samples per second=40.000 puntos
frameMil=voice_frame(1000);
framecs=voice_frame(160);
###
frame1=voice_frame_r(1:160);
frame2=voice_frame_r(161:161+159);
frame3=voice_frame_r(321:321+159);
frame4=voice_frame_r(481:481+159);
frame5=voice_frame_r(641:641+159);
