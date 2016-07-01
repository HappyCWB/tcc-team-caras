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

        fileID_nomes = fopen('Nomes.txt','w');
        fileID_luminanciaS = fopen('LuminanciaS.txt','w');
        fileID_luminanciaNE = fopen('LuminanciaNE.txt','w');
        fileID_luminanciaNW = fopen('LuminanciaNW.txt','w');
        
        rect = rectangle('Position',[0 0 0 0]);
        textoNome = text(0, 0, '');
        textoLumS = text(0, 0, '');
        textoLumNE = text(0, 0, '');
        textoLumNW = text(0, 0, '');
        
        %contagem = 0;
        
        while sair == 0

            if(isvalid(handleDaTela))
               
                imagemInicialDaCamera = snapshot(camera);
                figure(handleDaTela);
                imshow(imagemInicialDaCamera);

                [idDaPessoa, temRostoNaImagem, luminanciaS, luminanciaNE, luminanciaNW, BoundingBox, nomeEncontrado] = ...
                    fazerReconhecimentoEDeteccaoDeLuminanciaDaImagem(imagemInicialDaCamera, ...
                        USAR_VIOLA_JONES);
                
                colocarBoundingBoxENomeNoRosto(idDaPessoa);
                
                if USAR_CONTROLE_PID
                    
                      enviarMensagemParaArduino;
                end
                              
                if temRostoNaImagem
                    if nomeEncontrado == '?'
                        fprintf(fileID_nomes, '%d\n', -1);
                    else
                        fprintf(fileID_nomes, '%d\n', idDaPessoa);
                    end
                    fprintf(fileID_luminanciaS, '%d\n', luminanciaS);
                    fprintf(fileID_luminanciaNE, '%d\n', luminanciaNE);
                    fprintf(fileID_luminanciaNW, '%d\n', luminanciaNW);
                else
                    fprintf(fileID_nomes, '%d\n', 0);
                    fprintf(fileID_luminanciaS, '%d\n', ' ');
                    fprintf(fileID_luminanciaNE, '%d\n', ' ');
                    fprintf(fileID_luminanciaNW, '%d\n', ' ');
                end
                
                figureS = figure(2);
                gerarGraficoAPartirDoArquivo('LuminanciaS', 'b', 38);
                figureS.Position = [550, 45, 310, 110];
                figureS.Name = 'Luminância S';
                %movegui('south');
                
                figureNE = figure(3);
                gerarGraficoAPartirDoArquivo('LuminanciaNE', 'b', 42);
                figureNE.Position = [95, 380, 310, 150];
                figureNE.Name = 'Luminância NE';
                %movegui('northeast');
                
                figureNW = figure(4);
                gerarGraficoAPartirDoArquivo('LuminanciaNW', 'b', 42);
                figureNW.Position = [970, 380, 310, 150];
                figureNW.Name = 'Luminância NW';
                %movegui('northwest');
                
                
%                  contagem = contagem + 1
%                  
%                  if contagem == 50 || contagem == 100
%                      pause(5)
%                  end
%                  
%                  if contagem == 150
%                      sair = 1;
%                      delete(handleDaTela);
%                  end
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
                USAR_CONTROLE_PID = 0;
                USAR_WEBCAM_INTEGRADA = 0;
            case 1
                USAR_CONTROLE_PID = 0;
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

    function colocarBoundingBoxENomeNoRosto(idDaPessoa)
        
        if(isvalid(handleDaTela))
            figure(handleDaTela)
            hold on
        end
        
        cores = ['r' 'g' 'b' 'y' 'm' 'c' 'k' 'w'];
        
        if (isvalid(rect))

                set(rect,'Visible','off')
                set(textoNome,'Visible','off')
                set(textoLumS,'Visible','off')
                set(textoLumNE,'Visible','off')
                set(textoLumNW,'Visible','off')
            end
        
        if (BoundingBox ~= 0)
            
            if nomeEncontrado == '?'
                rect = rectangle('Position',BoundingBox,'LineWidth',5,'LineStyle','-','EdgeColor','w');
                textoNome = text(BoundingBox(1), BoundingBox(2)-20, ['\bf' nomeEncontrado], ...
                'Color', 'w', 'FontSize', 12);
                textoLumNE = text(BoundingBox(1)-45, BoundingBox(2)+20, [num2str(luminanciaNE)], ...
                'Color', 'w', 'FontSize', 12);
                textoLumNW = text(BoundingBox(1)+BoundingBox(3)+20, BoundingBox(2)+20, [num2str(luminanciaNW)], ...
                'Color', 'w', 'FontSize', 12);
                textoLumS = text(BoundingBox(1)+(BoundingBox(3))/2-10, BoundingBox(2)+BoundingBox(4)+20, [num2str(luminanciaS)], ...
                'Color', 'w', 'FontSize', 12);  
            else
                rect = rectangle('Position',BoundingBox,'LineWidth',5,'LineStyle','-','EdgeColor',cores(idDaPessoa));
                textoNome = text(BoundingBox(1), BoundingBox(2)-20, ['\bf' nomeEncontrado], ...
                'Color', cores(idDaPessoa), 'FontSize', 12);
                textoLumNE = text(BoundingBox(1)-45, BoundingBox(2)+20, [num2str(luminanciaNE)], ...
                'Color', cores(idDaPessoa), 'FontSize', 12);
                textoLumNW = text(BoundingBox(1)+BoundingBox(3)+20, BoundingBox(2)+20, [num2str(luminanciaNW)], ...
                'Color', cores(idDaPessoa), 'FontSize', 12);
                textoLumS = text(BoundingBox(1)+(BoundingBox(3))/2-10, BoundingBox(2)+BoundingBox(4)+20, [num2str(luminanciaS)], ...
                'Color', cores(idDaPessoa), 'FontSize', 12); 
            end

                set(rect,'Visible','on')
                set(textoNome,'Visible','on')
                set(textoLumS,'Visible','on')
                set(textoLumNE,'Visible','on')
                set(textoLumNW,'Visible','on')
        end
        
       if(isvalid(handleDaTela))
            figure(handleDaTela)
            hold off
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
        
%         valorDoLED1 = fscanf(arduinoSerial,'%f');
%         valorDoLED1 = uint8((255 - valorDoLED1) * 100/255);
%         valorDoLED2 = fscanf(arduinoSerial,'%f');
%         valorDoLED2 = uint8((255 - valorDoLED2) * 100/255);
%         valorDoLED3 = fscanf(arduinoSerial,'%f');
%         valorDoLED3 = uint8((255 - valorDoLED3) * 100/255);
%         stringLEDs = ['LED S: ' num2str(valorDoLED1) '% LED NE: ' num2str(valorDoLED2) '% LED NW: ' num2str(valorDoLED3) '%'];
%         
%         disp(' ');
%         disp(stringLEDs);
        
        pause(0.1);
        
    end

    function mensagemDeErroDeFaltaDeFotosNoCadastro
        
        disp('Você não cadastrou nenhuma foto ainda!');
        disp(' ');
        disp('Utilize a função CADASTRO antes.');
        disp(' ');
        
    end

    function finalizarPrograma
        
        close all
        
        fclose(fileID_nomes);
        
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

