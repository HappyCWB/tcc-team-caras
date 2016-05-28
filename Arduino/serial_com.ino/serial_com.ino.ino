/*
      Arduino MATLAB serial Communication & PID
      Autor: Os nego Bom!
      Pré-programa TCC
 */
#include <PID_v1.h> 
double Setpoint1, Input1, Output1, Kp1 = 6, Ki1 = 8, Kd1 = 0, Setpoint = 42;
double Setpoint2, Input2, Output2, Kp2 = 6, Ki2 = 8, Kd2 = 0;
double Setpoint3, Input3, Output3, Kp3 = 6, Ki3 = 8, Kd3 = 0;

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
  
   if(Serial.available()>0) // if there is data to read
   {
      jaLeu = 1;
      
      x=Serial.parseInt();
      y=Serial.parseInt();
      z=Serial.parseInt();
      semRosto=Serial.parseInt();


      if(semRosto==0){

            contagemDeNaoRosto++;

            if (contagemDeNaoRosto > 4) {
              analogWrite(led1,180);
              analogWrite(led2,180);
              analogWrite(led3,180);  

              contagemDeNaoRosto = 0;
            }

            //Serial.println(180);
            //Serial.println(180);
            //Serial.println(180);
            
      } else{

            contagemDeNaoRosto = 0;
            
            Input1 = double(x);
            Input2 = double(y);
            Input3 = double(z);
      
            myPID1.Compute();
            myPID2.Compute();
            myPID3.Compute();
            
            Output1 = 255 - Output1;
            Output2 = 255 - Output2;
            Output3 = 255 - Output3;

            if(Output2 >= 240) Output2 = 240;
            if(Output3 >= 240) Output3 = 240;
            
            analogWrite(led1,Output1);
            analogWrite(led2,Output2);
            analogWrite(led3,Output3);
            
            //Serial.println(Output1);
            //Serial.println(Output2);
            //Serial.println(Output3);
       }
      }
}
