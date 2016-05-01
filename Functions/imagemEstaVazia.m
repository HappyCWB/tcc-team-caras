function [ respostaBinaria ] = imagemEstaVazia( imagem )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    if max(imagem) == 0
        respostaBinaria = 1;
    else
        respostaBinaria = 0;
    end

end

