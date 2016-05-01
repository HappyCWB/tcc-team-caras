
function TESTE_HSV (USAR_WEBCAM_INTEGRADA)

    addpath ../Functions

    switch nargin

        case 0
            USAR_WEBCAM_INTEGRADA = 0;

    end

    if USAR_WEBCAM_INTEGRADA
        imgRGB = tirarFotoComWebcam(1);
    else
        imgRGB = tirarFotoComWebcam(2);
    end

    imgHSV = rgb2hsv(imgRGB);

    imshow(imgHSV)

end