function [ luminanciaNE ] = calcularLuminanciaNE( imagemRGB )

    [height, width, ~] = size(imagemRGB);
    inclinacao = height / width;
    
    somaR = uint32(1);
    somaG = uint32(1);
    somaB = uint32(1);
    totalDePixelsDaArea = 0;
    
    for i=1:height
        for j=1:width
            % j < width / 2 -> nao pertence!
            % OU 
            % y < -a*x + height -> nao pertence!
            if (j >= width/2) && (i <= inclinacao*j)
                somaR = somaR + uint32(imagemRGB(i,j,1));
                somaG = somaG + uint32(imagemRGB(i,j,2));
                somaB = somaB + uint32(imagemRGB(i,j,3));
                totalDePixelsDaArea = totalDePixelsDaArea + 1;
            end
        end
    end
    
    mediaR = somaR / totalDePixelsDaArea;
    mediaG = somaG / totalDePixelsDaArea;
    mediaB = somaB / totalDePixelsDaArea;
    
    luminanciaNE = calcularLuminanciaComValoresRGB ...
        (mediaR, mediaG, mediaB);
end

