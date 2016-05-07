
function TESTE_HSV (USAR_WEBCAM_INTEGRADA)

    addpath ../Functions

    switch nargin

        case 0
            USAR_WEBCAM_INTEGRADA = 0;

    end

    imgRGB = tirarFotoComWebcam(USAR_WEBCAM_INTEGRADA);
       
    imgHSV = rgb2hsv(imgRGB);

    imshow(imgHSV)

end