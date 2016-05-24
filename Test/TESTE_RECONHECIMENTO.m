% TCC: Desenvolvimento de um Sistema de Reconhecimento Facial com Controle 
% de Iluminação PID
%
% Alunos: Lucas Vazquez, Luis Lopes e Matheus Wisniewski

% Contato: matheus.maw@gmail.com
%
% Data: 09/05/2016

function [  ] = TESTE_RECONHECIMENTO(USAR_VIOLA_JONES, MOSTRAR_RESULTADOS_INTERMEDIARIOS, MOSTRAR_RESULTADOS_FINAIS, USAR_WEBCAM_INTEGRADA)

    addpath ../Functions
    addpath ../Classes
    addpath ../Databases

    ajustarParametrosOpcionais(nargin);
    
    clc
    clearvars -except USAR_VIOLA_JONES MOSTRAR_RESULTADOS_INTERMEDIARIOS MOSTRAR_RESULTADOS_FINAIS USAR_WEBCAM_INTEGRADA
    close all
    
    load ../Databases/BancoDeDados tamanhoAtual
    
    if tamanhoAtual > 0
    
        [imagemInicialDaCamera] = tirarFotoComWebcam(USAR_WEBCAM_INTEGRADA);

        if USAR_VIOLA_JONES
            [imagemCortada, temRostoNaImagem, ~] = detectarRostoPorViolaJones...
            (imagemInicialDaCamera);
        else
            [imagemCortada, temRostoNaImagem, ~] = detectarRostoPorSegmentacao...
            (imagemInicialDaCamera, ...
            MOSTRAR_RESULTADOS_INTERMEDIARIOS, MOSTRAR_RESULTADOS_FINAIS);
        end
        
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
                USAR_VIOLA_JONES = 0;
                MOSTRAR_RESULTADOS_INTERMEDIARIOS = 1;
                MOSTRAR_RESULTADOS_FINAIS = 1;
                USAR_WEBCAM_INTEGRADA = 0;
            case 1
                MOSTRAR_RESULTADOS_INTERMEDIARIOS = 1;
                MOSTRAR_RESULTADOS_FINAIS = 1;
                USAR_WEBCAM_INTEGRADA = 0;
            case 2
                MOSTRAR_RESULTADOS_FINAIS = 0;
                USAR_WEBCAM_INTEGRADA = 0;
            case 3
                USAR_WEBCAM_INTEGRADA = 0;
        end
        
    end
    
end

