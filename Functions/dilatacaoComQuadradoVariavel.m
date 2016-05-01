function [ imagemAposDilatacao ] = dilatacaoComQuadradoVariavel( imagemAntesDaDilatacao, ladoDoQuadrado )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    imagemAposDilatacao = imdilate(imagemAntesDaDilatacao,ones(ladoDoQuadrado,ladoDoQuadrado));

end

