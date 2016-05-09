% TCC: Desenvolvimento de um Sistema de Reconhecimento Facial com Controle 
% de Iluminação PID
%
% Alunos: Lucas Vazquez, Luis Lopes e Matheus Wisniewski

% Contato: matheus.maw@gmail.com
%
% Data: 09/05/2016

function [  ] = RECONHECIMENTO_UNITARIO(MOSTRAR_RESULTADOS_INTERMEDIARIOS, MOSTRAR_RESULTADOS_FINAIS, USAR_WEBCAM_INTEGRADA)

    addpath ./Functions
    addpath ./Classes
    addpath ./Databases

    ajustarParametrosOpcionais(nargin);
    
    clc
    clearvars -except MOSTRAR_RESULTADOS_INTERMEDIARIOS MOSTRAR_RESULTADOS_FINAIS USAR_WEBCAM_INTEGRADA
    close all
    
    load ./Databases/BancoDeDados tamanhoAtual
    
    if tamanhoAtual > 0
    
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
        
    else
        disp('Você não cadastrou nenhuma foto ainda!');
        disp(' ');
        disp('Utilize a função CADASTRO antes.');
        disp(' ');
        disp('Até breve!');
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

