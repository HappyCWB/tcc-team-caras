function [ imagemPosTratamentos ] = sequenciaDeTratamentosDeImagem( imagemPreTratamentos, mostrarResultadosIntermediarios )

    imagemPosPreenchimento0 = preencherBuracosDaImagem(imagemPreTratamentos);

    [imagemPosPreenchimento1, imagemPosErosao1, imagemPosDilatacao1] = ...
           removerRuidosComQuadradoVariavel(imagemPosPreenchimento0, 7);

    [imagemPosPreenchimento2, imagemPosErosao2, imagemPosDilatacao2] = ...
           removerRuidosComQuadradoVariavel(imagemPosPreenchimento1, 9);
    
    [imagemPosPreenchimento3, imagemPosErosao3, imagemPosDilatacao3] = ...
           removerRuidosComQuadradoVariavel(imagemPosPreenchimento2, 11);

    [imagemPosTratamentos, imagemPosErosao4, imagemPosDilatacao4] = ...
           removerRuidosComQuadradoVariavel(imagemPosPreenchimento3, 13);
    
    if(mostrarResultadosIntermediarios==1)

        figure('Name', 'Resultados Intermedi�rios');

        suptitle('RESULTADOS INTERMEDI�RIOS')

        subplot(5,3,2)
        imshow(imagemPreTratamentos);
        title('Segmenta��o de pele')

        subplot(5,3,4)
        imshow(imagemPosErosao1)
        title('Eros�o 1')

        subplot(5,3,5)
        imshow(imagemPosDilatacao1)
        title('Dilata��o 1')

        subplot(5,3,6)
        imshow(imagemPosPreenchimento1)
        title('Preenchida 1')

        subplot(5,3,7)
        imshow(imagemPosErosao2)
        title('Eros�o 2')

        subplot(5,3,8)
        imshow(imagemPosDilatacao2)
        title('Dilata��o 2')

        subplot(5,3,9)
        imshow(imagemPosPreenchimento2)
        title('Preenchida 2')
        
        subplot(5,3,10)
        imshow(imagemPosErosao3)
        title('Eros�o 3')

        subplot(5,3,11)
        imshow(imagemPosDilatacao3)
        title('Dilata��o 3')

        subplot(5,3,12)
        imshow(imagemPosPreenchimento3)
        title('Preenchida 3')
        
        subplot(5,3,13)
        imshow(imagemPosErosao4)
        title('Eros�o 4')

        subplot(5,3,14)
        imshow(imagemPosDilatacao4)
        title('Dilata��o 4')

        subplot(5,3,15)
        imshow(imagemPosTratamentos)
        title('Preenchida 4')

    end

end

