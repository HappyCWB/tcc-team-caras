
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

    entradaDoTeste = reshape(imagemCortada, 14400, 1);
    
    load BDRedeNeural net
    
    [taxaDeCerteza, idDaPessoa] = max(net(entradaDoTeste))

    if taxaDeCerteza < 0.6
        
        if temRostoNaImagem
                
            disp('Vejo um rosto, mas não sei quem é...');
                
        else
            
            disp('AMBIENTE...');

        end
        
    else
    
        switch idDaPessoa

            case 1

                disp('Olá, LUCAS!');

            case 2

                disp('Olá, LUIS!');

            case 3

                disp('Olá, MATHEUS!');

            otherwise

                disp('AMBIENTE...');

        end
        
    end
    
end

