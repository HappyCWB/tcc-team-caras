function [imagemCortadaEm80por60RGB, temRostoNaImagem, BoundingBox] = ...
    detectarRostoPorViolaJones(imagemInicialDaCamera)

    if max(imagemInicialDaCamera) == 0
        
        temRostoNaImagem = 0;
        imagemCortadaEm80por60RGB = -1;
        
    else

        FDetect = vision.CascadeObjectDetector;

        AllBoundingBoxes = step(FDetect,imagemInicialDaCamera);

        if AllBoundingBoxes

            BoundingBox = AllBoundingBoxes(1,:);

            BoundingBox(1) = BoundingBox(1)+20;

            if BoundingBox(3) >= 40
                BoundingBox(3) = BoundingBox(3)-40;
            end

            BoundingBox(4) = BoundingBox(4)+40;

            imagemCortada = imcrop(imagemInicialDaCamera, AllBoundingBoxes(1,:));

            imagemCortadaEm80por60RGB = imresize(imagemCortada, [80 60]);

            temRostoNaImagem = 1;

        else

            BoundingBox = 0;

            temRostoNaImagem = 0;

            imagemCortadaEm80por60RGB = imresize(imagemInicialDaCamera, [80 60]);

        end
        
    end

end
