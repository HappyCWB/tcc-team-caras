
function TESTE_HSV (USAR_WEBCAM_INTEGRADA)

    addpath ../Functions

    switch nargin

        case 0
            USAR_WEBCAM_INTEGRADA = 0;

    end

    imgRGB = tirarFotoComWebcam(USAR_WEBCAM_INTEGRADA);
       
    imgHSV = rgb2hsv(imgRGB);

    subplot(1,2,1)
    imshow(imgRGB)
    title('Imagem em RGB')
    
    subplot(1,2,2)
    imshow(imgHSV)
    title('Imagem convertida para HSV (mantendo o mapa em RGB)')

end