
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

        disp('A lumin�ncia 1 (S) �:'); disp(luminanciaS);
        disp('A lumin�ncia 2 (NE) �'); disp(luminanciaNE);
        disp('A lumin�ncia 3 (NW) �'); disp(luminanciaNW);
    
    else
        
        disp('Nenhum rosto encontrado');
        
    end
    
    timespent = toc
   
end