function [ imagemPosTratamentos ] = sequenciaDeTratamentosDeImagem( imagemPreTratamentos, mostrarResultadosIntermediarios )

    imagemPosPreenchimento0 = preencherBuracosDaImagem(imagemPreTratamentos);

    [imagemPosPreenchimento1, imagemPosErosao1, imagemPosDilatacao1] = ...
           removerRuidosComQuadradoVariavel(imagemPosPreenchimento0, 5);

    [imagemPosPreenchimento2, imagemPosErosao2, imagemPosDilatacao2] = ...
           removerRuidosComQuadradoVariavel(imagemPosPreenchimento1, 7);
    
    [imagemPosTratamentos, imagemPosErosao3, imagemPosDilatacao3] = ...
           removerRuidosComQuadradoVariavel(imagemPosPreenchimento2, 9);
    
    if(mostrarResultadosIntermediarios==1)

        figure('Name', 'Resultados Intermedi�rios');

        suptitle('RESULTADOS INTERMEDI�RIOS')

        subplot(4,3,2)
        imshow(imagemPreTratamentos);
        title('Segmenta��o de pele')

        subplot(4,3,4)
        imshow(imagemPosErosao1)
        title('Eros�o 1')

        subplot(4,3,5)
        imshow(imagemPosDilatacao1)
        title('Dilata��o 1')

        subplot(4,3,6)
        imshow(imagemPosPreenchimento1)
        title('Preenchida 1')

        subplot(4,3,7)
        imshow(imagemPosErosao2)
        title('Eros�o 2')

        subplot(4,3,8)
        imshow(imagemPosDilatacao2)
        title('Dilata��o 2')

        subplot(4,3,9)
        imshow(imagemPosPreenchimento2)
        title('Preenchida 2')
        
        subplot(4,3,10)
        imshow(imagemPosErosao3)
        title('Eros�o 3')

        subplot(4,3,11)
        imshow(imagemPosDilatacao3)
        title('Dilata��o 3')

        subplot(4,3,12)
        imshow(imagemPosTratamentos)
        title('Preenchida 3')

    end

end

