function [ BoundingBox, plotDaElipse, ok ] = encontrarRetanguloEElipseNoRosto( imagemBWcomPontosNoRosto )

    [w, h]=size(imagemBWcomPontosNoRosto(:,:));
    s = regionprops(imagemBWcomPontosNoRosto, ...
        'Centroid','MajorAxisLength','MinorAxisLength','Orientation','PixelList','Area');

    [tamanho, ~] = size(s);
    
    if tamanho > 0
        %PixList = s.PixelList;

        x = s.Centroid(1);
        y = s.Centroid(2);
        a = s.MajorAxisLength/2;
        b = s.MinorAxisLength/2;
        angle = -s.Orientation;
        steps = 2000;

        %#  @param x     X coordinate
        %#  @param y     Y coordinate
        %#  @param a     Semimajor axis
        %#  @param b     Semiminor axis
        %#  @param angle Angle of the ellipse (in degrees)

        beta = angle * (pi / 180);
        sinbeta = sin(beta);
        cosbeta = cos(beta);

        alpha = linspace(0, 360, steps)' .* (pi / 180);
        sinalpha = sin(alpha);
        cosalpha = cos(alpha);

        X = x + (a * cosalpha * cosbeta - b * sinalpha * sinbeta);
        Y = y + (a * cosalpha * sinbeta + b * sinalpha * cosbeta);

        matriz_elipse = [round(X) round(Y)];

        [a_me, ~] = size(matriz_elipse);

        img_elipse = zeros(w,h);

        for i=1:a_me

           x_me = matriz_elipse(i,1);

           y_me = matriz_elipse(i,2);

           if x_me <= 0
               x_me = 1;
           end

           if y_me <= 0
               y_me = 1;
           end

           img_elipse(y_me,x_me) = 1;

        end

        ellipsisLenght = max(X)-min(X);
        ellipsisHeight = max(Y)-min(Y);

        initialX = min(X);
        initialY = min(Y);

        BoundingBox = [initialX initialY ellipsisLenght ellipsisHeight];

        plotDaElipse = [X Y];
        
        ok = 1;
        
    else
        BoundingBox = 0;
        plotDaElipse = 0;
        ok = 0;
    end

end

