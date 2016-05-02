function [ luminancia ] = calcularLuminanciaComValoresRGB ...
    ( valorR, valorG, valorB )
% Valor da luminancia [0,100]

    soma = 27*valorR + 67*valorG + 6*valorB;
    luminancia = soma/255;
end

