% TCC: Desenvolvimento de um Sistema de Reconhecimento Facial com Controle 
% de Iluminação PID
%
% Alunos: Lucas Vazquez, Luis Lopes e Matheus Wisniewski

% Contato: matheus.maw@gmail.com
%
% Data: 09/05/2016

function [  ] = RECONHECIMENTO(MOSTRAR_RESULTADOS_INTERMEDIARIOS, MOSTRAR_RESULTADOS_FINAIS, USAR_WEBCAM_INTEGRADA)

    addpath ./Functions
    addpath ./Classes
    addpath ./Databases

    ajustarParametrosOpcionais(nargin);
    
    clc
    clearvars -except MOSTRAR_RESULTADOS_INTERMEDIARIOS MOSTRAR_RESULTADOS_FINAIS USAR_WEBCAM_INTEGRADA
    close all
    
    [imagemInicialDaCamera] = tirarFotoComWebcam(USAR_WEBCAM_INTEGRADA);
       
    [imagemCortada, temRostoNaImagem] = detectarRostoPorSegmentacao...
            (imagemInicialDaCamera, ...
            MOSTRAR_RESULTADOS_INTERMEDIARIOS, MOSTRAR_RESULTADOS_FINAIS);
    
    imagemCortadaGray = rgb2gray(imagemCortada);
    
    [taxaDeCerteza, idDaPessoa] = ...
        reconhecerQuemEstaNaImagem(imagemCortadaGray);
    
    imprimirResultadosDoReconhecimento(taxaDeCerteza, idDaPessoa, temRostoNaImagem);
    
    if temRostoNaImagem
    
        [luminanciaS, luminanciaNE, luminanciaNW] = ...
            detectarLuminanciaDasTresDivisoesDoRosto(imagemCortada, MOSTRAR_RESULTADOS_FINAIS);

        imprimirLuminancias(luminanciaS, luminanciaNE, luminanciaNW);
    end
    
    function ajustarParametrosOpcionais(nargin)
        
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
        
    end
    
end

