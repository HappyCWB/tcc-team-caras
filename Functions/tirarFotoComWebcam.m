
function [ imagem ] = tirarFotoComWebcam(USAR_WEBCAM_INTEGRADA)
         
    telaPrincipal = figure('Name', 'TCC Eng. Controle e Automa��o'); 
    
        botaoSnapshot = uicontrol('Style', 'pushbutton',...
            'String', 'Tirar Foto',...
            'Position', [310 5 200 40],...
            'Callback', @(src, evnt)takeSnapshot(), ...
            'KeyPressFcn', @(src, evnt)takeSnapshot);
        
        botaoSair = uicontrol('Style', 'pushbutton',...
                'String', 'Sair',...
                'Position', [515 380 40 40],...
                'Callback', @(src, evnt)acaoBotaoSair(),...
                'KeyPressFcn', @(src, evnt)acaoBotaoSair);
        
    listaDasWebcams = webcamlist;
    [tamanhoDaLista, ~] = size(listaDasWebcams);
    ok = 0;
    
    if USAR_WEBCAM_INTEGRADA
        
        for i=1:tamanhoDaLista
            if strcmp(listaDasWebcams(i),'Integrated Webcam')
                cam=webcam('Integrated Webcam');
                ok = 1;
            end
        end

        if ~ok
            cam = webcam(1);
        end
        
    else
        for i=1:tamanhoDaLista
            if strcmp(listaDasWebcams(i),'USB2.0 Camera')
                cam=webcam('USB2.0 Camera');
                ok = 1;
            end
        end

        if ~ok
            cam = webcam(1);
        end
    end
    
    %src = getselectedsource(cam);
    
    cam.Resolution = '640x480';
    %cam.ReturnedColorspace = 'rgb';
    %src.WhiteBalanceMode = 'manual';
    %src.WhiteBalance = 4000;
    
    
    hImage = image( zeros(480, 640, 3) );
    
    preview(cam, hImage);
    
    uicontrol(botaoSnapshot);
    
    uiwait(telaPrincipal);
    
    
    function takeSnapshot()

        closePreview(cam);
        
        imagem=snapshot(cam);
        
        uiresume();
        
        clear('cam');
        
        delete(telaPrincipal);
        
        close all

    end

    function acaoBotaoSair()
        
        imagem = zeros(1, 1, 3);
        delete(telaPrincipal);
        
    end

    function aoAtualizarVideoPreview(~,event,hImage)
        
        image = event.Data;
        % Display the current image frame.
        set(hImage, 'CData', image);
        t = 1:1:50;
        g = 1:1:50;
        plot(t, g, 'g', 'Parent', ancestor(hImage, 'axes'));
        drawnow
        
    end
    
end