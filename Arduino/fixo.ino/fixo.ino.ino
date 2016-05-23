/*
      Arduino MATLAB serial Communication & PID
      Autor: Os nego Bom!
      Pré-programa TCC
 */
#include <PID_v1.h> 
double Setpoint1, Input1, Output1, Kp1 = 4, Ki1 = 6, Kd1 = 0, Setpoint = 42;
double Setpoint2, Input2, Output2, Kp2 = 4, Ki2 = 6, Kd2 = 0;
double Setpoint3, Input3, Output3, Kp3 = 4, Ki3 = 6, Kd3 = 0;

int led1 = 9, led2 = 10, led3 = 11, semRosto = 1, jaLeu = 0;          // 9 é o SU, 10 é o NE, 11 é o NW
long int bug, x, y ,z;
int x1, y1, z1;

PID myPID1(&Input1, &Output1, &Setpoint1, Kp1,Ki1, Kd1, DIRECT);
PID myPID2(&Input2, &Output2, &Setpoint2, Kp2,Ki2, Kd2, DIRECT);
PID myPID3(&Input3, &Output3, &Setpoint3, Kp3,Ki3, Kd3, DIRECT);

int contagemDeNaoRosto = 0;

void setup() 
{
  //pinMode(ledPin,OUTPUT);
  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
  pinMode(led3, OUTPUT);
  Serial.begin(57600);
//Serial.setTimeout(80);
      x=254;
      y=254;
      z=254;
      jaLeu =0;
      bug=254;
      Setpoint1 = Setpoint-5;
      Setpoint2 = Setpoint;
      Setpoint3 = Setpoint;
  myPID1.SetMode(AUTOMATIC); 
  myPID2.SetMode(AUTOMATIC); 
  myPID3.SetMode(AUTOMATIC); 
  
}
 
void loop() 
{   
  
  analogWrite(led1,255 - 50*255/100);
  analogWrite(led2,255 - 50*255/100);
  analogWrite(led3,255 - 50*255/100);
}
