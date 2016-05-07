
function TESTE_DETECCAO_BORDAS (USAR_WEBCAM_INTEGRADA)

    addpath ../Functions

    switch nargin

        case 0
            USAR_WEBCAM_INTEGRADA = 0;

    end

    
    imgRGB = tirarFotoComWebcam(USAR_WEBCAM_INTEGRADA);
   
    imgGray = rgb2gray(imgRGB);
    
    BW1 = edge(imgGray,'sobel');
    BW2 = edge(imgGray,'canny');
    figure;
    imshowpair(BW1,BW2,'montage')
    title('Sobel Filter                                   Canny Filter');
end