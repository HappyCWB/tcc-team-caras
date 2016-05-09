
function [  ] = RECONHECIMENTO_AUTOMATICO(MOSTRAR_RESULTADOS_INTERMEDIARIOS, MOSTRAR_RESULTADOS_FINAIS, USAR_WEBCAM_INTEGRADA)

    addpath ./Functions
    addpath ./Classes
    addpath ./Databases

    ajustarParametrosOpcionais(nargin);
    
    limparTelaEVariaveis;
    
    sair = 0;
    
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
    
%    contagem = 0;
    
    while sair == 0
        
%        if contagem > 1000
            
            imagemInicialDaCamera = snapshot(camera);
%             hold on

            [idDaPessoa, temRostoNaImagem, luminanciaS, luminanciaNE, luminanciaNW] = ...
                fazerReconhecimentoEDeteccaoDeLuminanciaDaImagem(imagemInicialDaCamera, ...
                    MOSTRAR_RESULTADOS_INTERMEDIARIOS, MOSTRAR_RESULTADOS_FINAIS);
                
%             x = 1 : 0.1 : 1000;
%             y = x.^2;
%             plot(x,y);
        
%            contagem = 0;
%        end
        
%        contagem = contagem + 1;
    end
    
    
    close all
    disp('Até breve!');
    
    
    
    function acaoBotaoSair()
        
        sair = 1;
        delete(handleDaTela);
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

    function limparTelaEVariaveis
        
        clc
        clearvars -except MOSTRAR_RESULTADOS_INTERMEDIARIOS MOSTRAR_RESULTADOS_FINAIS USAR_WEBCAM_INTEGRADA
        close all
    end
    
end

