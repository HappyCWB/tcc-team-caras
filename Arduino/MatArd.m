%**************************************************************************
%****************       Teste de comunicação Arduino       ****************
%**************************************************************************

%% MATLAB Example code:

clear all;
close all;
clc;

baudrate = 57600;

answer = 1; % this is where we'll store the user's answer
arduino = serial('COM3','BaudRate', baudrate); % create serial communication object on port COMX
 
fopen(arduino); % initiate arduino communication
 
while answer
    fprintf(arduino,'%s',char(answer)); % send answer variable content to arduino
    valorQuadrante1 = num2str(254)
    valorQuadrante2 = num2str(254)
    valorQuadrante3 = num2str(254)
    blop = 'a';
    answer = [blop valorQuadrante1 blop valorQuadrante2 blop valorQuadrante3]
   
end
 
fclose(arduino); % end communication with arduino