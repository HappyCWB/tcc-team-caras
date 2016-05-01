function [ imagemAposTratamento, imagemPosErosao, imagemPosDilatacao ] = removerRuidosComQuadradoVariavel( imagemAntesDoTratamento, ladoDoQuadrado )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

    imagemPosErosao = erosaoComQuadradoVariavel(imagemAntesDoTratamento, ladoDoQuadrado);

    imagemPosDilatacao = dilatacaoComQuadradoVariavel(imagemPosErosao, ladoDoQuadrado);

    imagemAposTratamento = preencherBuracosDaImagem(imagemPosDilatacao);

end

