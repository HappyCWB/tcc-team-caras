function [idDaPessoa, temRostoNaImagem, luminanciaS, luminanciaNE, luminanciaNW, BoundingBox, nomeEncontrado] = ...
    fazerReconhecimentoEDeteccaoDeLuminanciaDaImagem (imagemInicialDaCamera, ...
        USAR_VIOLA_JONES)
    
    switch nargin
        case 1
            USAR_VIOLA_JONES = 0;
    end
    
    if USAR_VIOLA_JONES
        [imagemCortada, temRostoNaImagem, BoundingBox] = ...
            detectarRostoPorViolaJones(imagemInicialDaCamera);
    else
        [imagemCortada, temRostoNaImagem, BoundingBox] = ...
            detectarRostoPorSegmentacao(imagemInicialDaCamera);
    end

    imagemCortadaGray = rgb2gray(imagemCortada);

    [taxaDeCerteza, idDaPessoa] = ...
        reconhecerQuemEstaNaImagem(imagemCortadaGray);

    nomeEncontrado = imprimirResultadosDoReconhecimento(taxaDeCerteza, idDaPessoa, temRostoNaImagem);

    if temRostoNaImagem

        [luminanciaS, luminanciaNE, luminanciaNW] = ...
            detectarLuminanciaDasTresDivisoesDoRosto(imagemCortada, 0);

        imprimirLuminancias(luminanciaS, luminanciaNE, luminanciaNW);
    else
        luminanciaS  = 0;
        luminanciaNE = 0;
        luminanciaNW = 0;
        
        disp(' '); disp(' '); disp(' '); 
    end

end

