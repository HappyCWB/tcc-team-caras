function [cam, handleDaTela] = abrirPreviewDaCamera(USAR_WEBCAM_INTEGRADA)

    handleDaTela = figure('Name', 'TCC Eng. Controle e Automação'); 

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
    
    cam.Resolution = '640x480';
    
    hImage = image( zeros(480, 640, 3) );
   
    %setappdata(hImage, 'UpdatePreviewWindowFcn', @aoAtualizarVideoPreview);
    
    preview(cam, hImage);

end

