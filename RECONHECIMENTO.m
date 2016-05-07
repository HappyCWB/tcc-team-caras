
function [  ] = RECONHECIMENTO(MOSTRAR_RESULTADOS_INTERMEDIARIOS, MOSTRAR_RESULTADOS_FINAIS, USAR_WEBCAM_INTEGRADA)

    addpath ./Functions
    addpath ./Classes
    addpath ./Databases

    switch nargin
        case 0
            MOSTRAR_RESULTADOS_INTERMEDIARIOS = 0;
            MOSTRAR_RESULTADOS_FINAIS = 0;
            USAR_WEBCAM_INTEGRADA = 0;
        case 1
            MOSTRAR_RESULTADOS_FINAIS = 1;
            USAR_WEBCAM_INTEGRADA = 0;
        case 2
            USAR_WEBCAM_INTEGRADA = 0;
    end
    
    clc
    clearvars -except MOSTRAR_RESULTADOS_INTERMEDIARIOS MOSTRAR_RESULTADOS_FINAIS USAR_WEBCAM_INTEGRADA
    close all
    
    [imagemCortada, temRostoNaImagem] = detectarRostoPorSegmentacao(MOSTRAR_RESULTADOS_INTERMEDIARIOS, MOSTRAR_RESULTADOS_FINAIS, USAR_WEBCAM_INTEGRADA);

    imagemCortadaGray = rgb2gray(imagemCortada);
    
    reconhecerQuemEstaNaImagem(imagemCortadaGray, temRostoNaImagem);
    
end

