/*
      Arduino MATLAB serial Communication Test
      Autor: Lucas Schneider Vázquez
      Pré-programa TCC
 */
int ledPin=13;
int matlabData;
 
void setup() 
{
  pinMode(ledPin,OUTPUT);
  Serial.begin(9600);
}
 
void loop() 
{
   
   if(Serial.available()>0) // if there is data to read
   {
    matlabData=Serial.read(); // read data
    if(matlabData==1)
      digitalWrite(ledPin,HIGH); // turn light on
    else if(matlabData==2)
      digitalWrite(ledPin,LOW); // turn light off
  }
}
