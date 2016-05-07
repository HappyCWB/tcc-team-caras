
function TESTE_DETECCAO_BORDAS (USAR_WEBCAM_INTEGRADA)

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

    imgGray = rgb2gray(imgRGB);
    
    BW1 = edge(imgGray,'sobel');
    BW2 = edge(imgGray,'canny');
    figure;
    imshowpair(BW1,BW2,'montage')
    title('Sobel Filter                                   Canny Filter');
end