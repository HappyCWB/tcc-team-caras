function [ imagemContendoApenasRosto, temRostoNaImagem ] = deixarApenasRostoNaImagem( imagemBinariaComVariosObjetos )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    [height, width] = size(imagemBinariaComVariosObjetos);

    [imagemComLabel, numeroDeObjetos] = bwlabel(imagemBinariaComVariosObjetos, 8);
    blobMeasurements = regionprops(imagemComLabel, imagemBinariaComVariosObjetos, ...
        'Area', 'Eccentricity', 'Orientation');
    
    areas = [blobMeasurements.Area];
    eccentricities = [blobMeasurements.Eccentricity];
    orientations = [blobMeasurements.Orientation];
    
    idDoMaiorComFormatoDeRosto = 0;
    
    for i=1:numeroDeObjetos
        if  areas(i) > areas(idDoMaiorComFormatoDeRosto + 1*(~idDoMaiorComFormatoDeRosto)) && ...
                eccentricities(i) < 0.90 && ...
                ~estaEntre(orientations(i),-65,65)
            
            idDoMaiorComFormatoDeRosto = i;
            
        else
            
            for h=1:height
               for w=1:width
                  if imagemComLabel(h,w) == i
                      imagemBinariaComVariosObjetos(h,w) = 0;
                  end
               end
            end
            
        end
    end
    
    if idDoMaiorComFormatoDeRosto == 0
        temRostoNaImagem = 0;
        imagemContendoApenasRosto = 0;
    else
        temRostoNaImagem = 1;
%         imagemContendoApenasRosto = bwareaopen(imagemBinariaComVariosObjetos, ...
%             areas(idDoMaiorComFormatoDeRosto)-1);
        imagemContendoApenasRosto = imagemBinariaComVariosObjetos;
    end
    
end

