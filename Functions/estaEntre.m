function [ respostaBinaria ] = estaEntre( numero, limiteInferior, limiteSuperior )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    if and( numero >= limiteInferior , numero <= limiteSuperior )
        respostaBinaria = 1;
    else
        respostaBinaria = 0;
    end
    
end

