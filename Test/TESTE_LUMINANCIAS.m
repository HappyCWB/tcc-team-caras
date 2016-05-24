
function TESTE_LUMINANCIAS(MOSTRAR_RESULTADOS_INTERMEDIARIOS, MOSTRAR_RESULTADOS_FINAIS, USAR_WEBCAM_INTEGRADA)

    tic;
    
    addpath ../Functions
    
    clc
    clearvars -except MOSTRAR_RESULTADOS_INTERMEDIARIOS MOSTRAR_RESULTADOS_FINAIS USAR_WEBCAM_INTEGRADA
    close all

    switch nargin
        case 0
            MOSTRAR_RESULTADOS_INTERMEDIARIOS = 0;
            MOSTRAR_RESULTADOS_FINAIS = 0;
            USAR_WEBCAM_INTEGRADA =0;
        case 1
            MOSTRAR_RESULTADOS_FINAIS = 1;
            USAR_WEBCAM_INTEGRADA = 0;
        case 2
            USAR_WEBCAM_INTEGRADA = 0;
    end

    imagemInicialDaCamera = tirarFotoComWebcam(USAR_WEBCAM_INTEGRADA);
       
    [imgCortadaRGB,temRostoNaImagem] = detectarRostoPorSegmentacao...
        (imagemInicialDaCamera, ...
        MOSTRAR_RESULTADOS_INTERMEDIARIOS, MOSTRAR_RESULTADOS_FINAIS);
    
    if temRostoNaImagem
    
        [luminanciaS, luminanciaNE, luminanciaNW] = ...
            detectarLuminanciaDasTresDivisoesDoRosto(imgCortadaRGB, MOSTRAR_RESULTADOS_FINAIS);

        disp('A luminância 1 (S) é:'); disp(luminanciaS);
        disp('A luminância 2 (NE) é'); disp(luminanciaNE);
        disp('A luminância 3 (NW) é'); disp(luminanciaNW);
    
    else
        
        disp('Nenhum rosto encontrado');
        
    end
    
    timespent = toc
   
end