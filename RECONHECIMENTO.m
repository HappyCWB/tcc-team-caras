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
    
    limparTelaEVariaveis;
    
    %arduinoSerial = inicializarArduino;

    load ./Databases/BancoDeDados tamanhoAtual
    
    if tamanhoAtual > 0
        
        sair = 0;
    
        [camera, handleDaTela] = abrirPreviewDaCamera(USAR_WEBCAM_INTEGRADA);


        botaoSair = uicontrol('Style', 'pushbutton',...
                'String', 'Sair',...
                'Position', [515 380 40 40],...
                'Callback', @(src, evnt)acaoBotaoSair() ...
            );

        fileID = fopen('Resultados.txt','w');
        
        while sair == 0

            if(isvalid(handleDaTela))
               
                imagemInicialDaCamera = snapshot(camera);
                hold on

                [idDaPessoa, temRostoNaImagem, luminanciaS, luminanciaNE, luminanciaNW, BoundingBox] = ...
                    fazerReconhecimentoEDeteccaoDeLuminanciaDaImagem(imagemInicialDaCamera, ...
                        MOSTRAR_RESULTADOS_INTERMEDIARIOS, MOSTRAR_RESULTADOS_FINAIS);

                colocarBoundingBoxNoRosto;
                
%                 if isvalid(arduinoSerial)
%                     if (temRostoNaImagem && luminanciaS > 0 && luminanciaNE > 0 && luminanciaNW > 0)
%                         enviarMensagemParaArduino;
%                     end
%                 end
                              
                fprintf(fileID, '%d\n', idDaPessoa);
            end
        end
    
    else
        
        mensagemDeErroDeFaltaDeFotosNoCadastro;
        
    end
    
    finalizarPrograma;
    
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

    function colocarBoundingBoxNoRosto
        
        if (BoundingBox ~= 0)
            rect = rectangle('Position',BoundingBox,'LineWidth',5,'LineStyle','-','EdgeColor','r');

                set(rect,'Visible','on')

                pause(0.02);

            if (isvalid(rect))

                set(rect,'Visible','off')
            end

        end
        
    end

    function arduinoSerial = inicializarArduino
       
        delete(instrfindall);
        
        baudrate = 57600;
        arduinoSerial = serial('COM3','BaudRate', baudrate); 
        
        if isvalid(arduinoSerial)
            fopen(arduinoSerial); 
            pause(2);
        end

    end

    function enviarMensagemParaArduino
      
        valorQuadrante1 = num2str(luminanciaS);
        valorQuadrante2 = num2str(luminanciaNE);
        valorQuadrante3 = num2str(luminanciaNW);
        
        separador = 'a';
        mensagemParaArduino = [separador valorQuadrante1 separador valorQuadrante2 separador valorQuadrante3];
        fprintf(arduinoSerial, '%s', mensagemParaArduino); % send answer variable content to arduino
        
        valorDoLED1 = fscanf(arduinoSerial,'%f');
        valorDoLED1 = uint8((255 - valorDoLED1) * 100/255);
        valorDoLED2 = fscanf(arduinoSerial,'%f');
        valorDoLED2 = uint8((255 - valorDoLED2) * 100/255);
        valorDoLED3 = fscanf(arduinoSerial,'%f');
        valorDoLED3 = uint8((255 - valorDoLED3) * 100/255);
        stringLEDs = ['LED S: ' num2str(valorDoLED1) '% LED NE: ' num2str(valorDoLED2) '% LED NW: ' num2str(valorDoLED3) '%'];
        
        disp(' ');
        disp(stringLEDs);
        
    end

    function mensagemDeErroDeFaltaDeFotosNoCadastro
        
        disp('Você não cadastrou nenhuma foto ainda!');
        disp(' ');
        disp('Utilize a função CADASTRO antes.');
        disp(' ');
        
    end

    function finalizarPrograma
        
        close all
        
        fclose(fileID);
        
%         if isvalid(arduinoSerial)
%             
%             fclose(arduinoSerial);
%             
%             if isvalid(arduinoSerial)
%                 fclose(arduinoSerial);
%             end
%         end
        
        disp(' ');
        disp('Até breve!');
        
    end
    
end

