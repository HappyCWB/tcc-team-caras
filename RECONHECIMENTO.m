% TCC: Desenvolvimento de um Sistema de Reconhecimento Facial com Controle 
% de Iluminação PID
%
% Alunos: Lucas Vazquez, Luis Lopes e Matheus Wisniewski

% Contato: matheus.maw@gmail.com
%
% Data: 09/05/2016

function [  ] = RECONHECIMENTO(USAR_VIOLA_JONES, USAR_CONTROLE_PID, USAR_WEBCAM_INTEGRADA)

    addpath ./Functions
    addpath ./Classes
    addpath ./Databases

    ajustarParametrosOpcionais(nargin);
    
    limparTelaEVariaveis;
    
    if USAR_CONTROLE_PID
        arduinoSerial = inicializarArduino;
    end

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
        
        contagem = 0;
        
        while sair == 0

            if(isvalid(handleDaTela))
               
                imagemInicialDaCamera = snapshot(camera);
                hold on

                [idDaPessoa, temRostoNaImagem, luminanciaS, luminanciaNE, luminanciaNW, BoundingBox, nomeEncontrado] = ...
                    fazerReconhecimentoEDeteccaoDeLuminanciaDaImagem(imagemInicialDaCamera, ...
                        USAR_VIOLA_JONES);
                
                %insertText(imagemInicialDaCamera,BoundingBox(1,1:2),nomeEncontrado,'FontSize',18,'BoxColor','Red','BoxOpacity',0.4,'TextColor','white');
                    
                colocarBoundingBoxNoRosto;
                
                if USAR_CONTROLE_PID
                    
                      enviarMensagemParaArduino;
                end
                              
                if temRostoNaImagem
                    fprintf(fileID, '%d\n', idDaPessoa);
                else
                    fprintf(fileID, '%d\n', 0);
                end
                
%                 contagem = contagem + 1
%                 
%                 if contagem == 100
%                     sair = 1;
%                     delete(handleDaTela);
%                 end
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
                USAR_VIOLA_JONES = 0;
                USAR_CONTROLE_PID = 1;
                USAR_WEBCAM_INTEGRADA = 0;
            case 1
                USAR_CONTROLE_PID = 1;
                USAR_WEBCAM_INTEGRADA = 0;
            case 2
                USAR_WEBCAM_INTEGRADA = 0;
        end
        
    end

    function limparTelaEVariaveis
        
        clc
        clearvars -except USAR_VIOLA_JONES USAR_CONTROLE_PID USAR_WEBCAM_INTEGRADA
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
        temRostoString = num2str(temRostoNaImagem);
        
        separador = 'a';
        mensagemParaArduino = [separador valorQuadrante1 separador valorQuadrante2 ...
            separador valorQuadrante3 separador temRostoString];
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
        
        pause(0.2);
        
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
        
        if USAR_CONTROLE_PID
            
             if isvalid(arduinoSerial)

                 fclose(arduinoSerial);

                 if isvalid(arduinoSerial)
                     fclose(arduinoSerial);
                 end
             end
        end
        
        disp(' ');
        disp('Até breve!');
        
    end
    
end

