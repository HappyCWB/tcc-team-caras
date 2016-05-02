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

        figure('Name', 'Resultados Intermediários');

        suptitle('RESULTADOS INTERMEDIÁRIOS')

        subplot(5,3,2)
        imshow(imagemPreTratamentos);
        title('Segmentação de pele')

        subplot(5,3,4)
        imshow(imagemPosErosao1)
        title('Erosão 1')

        subplot(5,3,5)
        imshow(imagemPosDilatacao1)
        title('Dilatação 1')

        subplot(5,3,6)
        imshow(imagemPosPreenchimento1)
        title('Preenchida 1')

        subplot(5,3,7)
        imshow(imagemPosErosao2)
        title('Erosão 2')

        subplot(5,3,8)
        imshow(imagemPosDilatacao2)
        title('Dilatação 2')

        subplot(5,3,9)
        imshow(imagemPosPreenchimento2)
        title('Preenchida 2')
        
        subplot(5,3,10)
        imshow(imagemPosErosao3)
        title('Erosão 3')

        subplot(5,3,11)
        imshow(imagemPosDilatacao3)
        title('Dilatação 3')

        subplot(5,3,12)
        imshow(imagemPosPreenchimento3)
        title('Preenchida 3')
        
        subplot(5,3,13)
        imshow(imagemPosErosao4)
        title('Erosão 4')

        subplot(5,3,14)
        imshow(imagemPosDilatacao4)
        title('Dilatação 4')

        subplot(5,3,15)
        imshow(imagemPosTratamentos)
        title('Preenchida 4')

    end

end

