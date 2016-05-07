
function [  ] = RECONHECIMENTO_AUTOMATICO(MOSTRAR_RESULTADOS_INTERMEDIARIOS, MOSTRAR_RESULTADOS_FINAIS, USAR_WEBCAM_INTEGRADA)

    addpath ./Functions
    addpath ./Classes
    addpath ./Databases

    ajustarParametrosOpcionais(nargin);
    
    clc
    clearvars -except MOSTRAR_RESULTADOS_INTERMEDIARIOS MOSTRAR_RESULTADOS_FINAIS USAR_WEBCAM_INTEGRADA
    close all
    
    sair = 0;
    pararDeTirarFotos = 0;
    
    [camera, handleDaTela] = abrirPreviewDaCamera(USAR_WEBCAM_INTEGRADA);
    
%     checkboxParada = uicontrol('Style', 'checkbox',...
%         'String', 'Parar de tirar fotos',...
%         'Position', [350 400 200 20],...
%         'Value', 0, ...
%         'Callback', @(src, evnt)acaoCheckbox() ...
%         );

    botaoSair = uicontrol('Style', 'pushbutton',...
            'String', 'Sair',...
            'Position', [515 380 40 40],...
            'Callback', @(src, evnt)acaoBotaoSair() ...
        );
    
    contagem = 0;
    
        
    while sair == 0
        
        imagemInicialDaCamera = snapshot(camera);

        [idDaPessoa, temRostoNaImagem, luminanciaS, luminanciaNE, luminanciaNW] = ...
            fazerReconhecimentoEDeteccaoDeLuminanciaDaImagem(imagemInicialDaCamera, ...
                MOSTRAR_RESULTADOS_INTERMEDIARIOS, MOSTRAR_RESULTADOS_FINAIS);
    end
    
    function acaoBotaoSair()
        
        sair = 1;
        delete(handleDaTela);
        
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

