function [ imagemAposErosao ] = erosaoComQuadradoVariavel( imagemAntesDaErosao, ladoDoQuadrado )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    warning('off', 'all');
    herode = vision.MorphologicalErode('Neighborhood', ones(ladoDoQuadrado,ladoDoQuadrado));
    warning('on', 'all');
     
    imagemAposErosao = step(herode,imagemAntesDaErosao);
    
end

