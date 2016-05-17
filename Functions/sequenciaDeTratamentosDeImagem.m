function [ imagemPosTratamentos ] = sequenciaDeTratamentosDeImagem( imagemPreTratamentos, mostrarResultadosIntermediarios )

    imagemPosPreenchimento0 = preencherBuracosDaImagem(imagemPreTratamentos);

    [imagemPosPreenchimento1, imagemPosErosao1, imagemPosDilatacao1] = ...
           removerRuidosComQuadradoVariavel(imagemPosPreenchimento0, 5);

    [imagemPosPreenchimento2, imagemPosErosao2, imagemPosDilatacao2] = ...
           removerRuidosComQuadradoVariavel(imagemPosPreenchimento1, 7);
    
    [imagemPosTratamentos, imagemPosErosao3, imagemPosDilatacao3] = ...
           removerRuidosComQuadradoVariavel(imagemPosPreenchimento2, 9);
    
    if(mostrarResultadosIntermediarios==1)

        figure('Name', 'Resultados Intermediários');

        suptitle('RESULTADOS INTERMEDIÁRIOS')

        subplot(4,3,2)
        imshow(imagemPreTratamentos);
        title('Segmentação de pele')

        subplot(4,3,4)
        imshow(imagemPosErosao1)
        title('Erosão 1')

        subplot(4,3,5)
        imshow(imagemPosDilatacao1)
        title('Dilatação 1')

        subplot(4,3,6)
        imshow(imagemPosPreenchimento1)
        title('Preenchida 1')

        subplot(4,3,7)
        imshow(imagemPosErosao2)
        title('Erosão 2')

        subplot(4,3,8)
        imshow(imagemPosDilatacao2)
        title('Dilatação 2')

        subplot(4,3,9)
        imshow(imagemPosPreenchimento2)
        title('Preenchida 2')
        
        subplot(4,3,10)
        imshow(imagemPosErosao3)
        title('Erosão 3')

        subplot(4,3,11)
        imshow(imagemPosDilatacao3)
        title('Dilatação 3')

        subplot(4,3,12)
        imshow(imagemPosTratamentos)
        title('Preenchida 3')

    end

end

