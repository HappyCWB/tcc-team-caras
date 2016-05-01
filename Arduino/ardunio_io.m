
%**************************************************************************
%****************       Teste de comunicação Arduino       ****************
%**************************************************************************

%% MATLAB Example code:

clear all
clc
 
answer = 1; % this is where we'll store the user's answer
arduino = serial('COM3','BaudRate',9600); % create serial communication object on port COMX
 
fopen(arduino); % initiate arduino communication
 
while answer
    fprintf(arduino,'%s',char(answer)); % send answer variable content to arduino
    answer = input('Enter led value 1 or 2 (1=ON, 2=OFF, 0=EXIT PROGRAM): '); % ask user to enter value for variable answer
end
 
fclose(arduino); % end communication with arduino


%% Exemplos de comandos no Arduino:

 %-- connect to the board 
 a = arduino('COM3')

 %-- specify pin mode 
 a.pinMode(4,'input'); 
 a.pinMode(13,'output');

 %-- digital i/o 
 a.digitalRead(4) % read pin 4 
 a.digitalWrite(13,0) % write 0 to pin 13

 %-- analog i/o 
 a.analogRead(5) % read analog pin 5 
 a.analogWrite(9, 155) % write 155 to analog pin 9

 %-- serial port 
 a.serial % get serial port 
 a.flush; % flushes PC's input buffer 
 a.roundTrip(42) % sends 42 to the arduino and back

 %-- servos 
 a.servoAttach(9); % attach servo on pin #9 
 a.servoWrite(9,100); % rotates servo on pin #9 to 100 degrees 
 val=a.servoRead(9); % reads angle from servo on pin #9 
 a.servoDetach(9); % detach servo from pin #9

 %-- encoders 
 a.encoderAttach(0,3,2) % attach encoder #0 on pins 3 (pin A) and 2 (pin B) 
 a.encoderRead(0) % read position 
 a.encoderReset(0) % reset encoder 0 
 a.encoderStatus; % get status of all three encoders 
 a.encoderDebounce(0,12) % sets debounce delay to 12 (~1.2ms) 
 a.encoderDetach(0); % detach encoder #0

 %-- adafruit motor shield (with AFMotor library) 
 a.motorRun(4, 'forward') % run motor forward 
 a.stepperStep(1, 'forward', 'double', 100); % move stepper motor

 %-- close session 
 delete(a)
 
 %% Setup do Arduino no MATLAB - Comunicação Serial:
 
 
 
 
 