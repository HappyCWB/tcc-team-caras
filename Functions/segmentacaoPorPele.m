function [ output ] = segmentacaoPorPele( imagemInicialEmRGB )

    [w, h]=size(imagemInicialEmRGB(:,:,1));
    
    [hue,saturation,~]=rgb2hsv(imagemInicialEmRGB);
    
    %cb =  0.148* imagemInicialEmRGB(:,:,1) - 0.291* imagemInicialEmRGB(:,:,2) + 0.439 * imagemInicialEmRGB(:,:,3) + 128;
    %cr =  0.439 * imagemInicialEmRGB(:,:,1) - 0.368 * imagemInicialEmRGB(:,:,2) -0.071 * imagemInicialEmRGB(:,:,3) + 128;
    
    imagemPele = zeros(w,h);

    for i=1:w
        for j=1:h            
            %if  133<=cr(i,j) && cr(i,j)<=173 && 77<=cb(i,j) && cb(i,j)<=195 && 0.019<=hue(i,j) && hue(i,j)<=0.240  
            %if  133<=c, r(i,j) && cr(i,j)<=173 && 77<=cb(i,j) && cb(i,j)<=127 && 0.01<=hue(i,j) && hue(i,j)<=0.1  
            %if and( and(0.019 <= hue(i,j), hue(i,j) <= 0.240), and(0.23 <= saturation(i,j), saturation(i,j) <= 0.85))
            if and( estaEntre(hue(i,j), 0.019, 0.240) == 1, estaEntre(saturation(i,j), 0.23, 0.85) == 1)
                imagemPele(i,j) = 1;            
            else       
                imagemPele(i,j) = 0;    
            end    
        end
    end
    
    output = imagemPele;
    
end

