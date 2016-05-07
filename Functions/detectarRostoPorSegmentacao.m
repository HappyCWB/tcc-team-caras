
function [ imagemCortadaEm80por60RGB, temRostoNaImagem ]...
    = detectarRostoPorSegmentacao...
    (imagemInicialDaCamera, ...
    MOSTRAR_RESULTADOS_INTERMEDIARIOS, MOSTRAR_RESULTADOS_FINAIS)

    switch nargin
        case 1
            MOSTRAR_RESULTADOS_INTERMEDIARIOS = 0;
            MOSTRAR_RESULTADOS_FINAIS = 0;
        case 2
            MOSTRAR_RESULTADOS_FINAIS = 1;
    end

    if max(imagemInicialDaCamera) == 0
        
        temRostoNaImagem = 0;
        imagemCortadaEm80por60RGB = -1;
        
    else
    
        imagemInicialEmRGB=double(imagemInicialDaCamera);

        [w, h]=size(imagemInicialEmRGB(:,:,1));
        imagemAposReconhecimento = zeros(w,h,3);

        imagemPele = segmentacaoPorPele(imagemInicialEmRGB);

        imagemDeteccaoDeBordas = edge(imagemPele, 'canny');
        imagemDeteccaoDeBordasDilatada = ...
            dilatacaoComQuadradoVariavel(imagemDeteccaoDeBordas, 3);
        
        imagemPeleComDeteccaoDeBordas = imagemPele - imagemDeteccaoDeBordasDilatada;
        
        imagemBinariaPosTratamento = ...
            sequenciaDeTratamentosDeImagem (imagemPeleComDeteccaoDeBordas, ...
                                            MOSTRAR_RESULTADOS_INTERMEDIARIOS);

        if contemCandidatosARostoNaImagem(imagemBinariaPosTratamento)
            
            [imagemBinariaContendoApenasRosto, temRostoNaImagem] = ...
                deixarApenasRostoNaImagem(imagemBinariaPosTratamento);
            
            if temRostoNaImagem
            
                for color=1:3
                    imagemAposReconhecimento(:,:,color)=imagemInicialEmRGB(:,:,color).*...
                        imagemBinariaContendoApenasRosto;   
                end

                [BoundingBox, plotDaElipse, ok] = ...
                    encontrarRetanguloEElipseNoRosto(imagemBinariaContendoApenasRosto);

                if ok
                    
                    if MOSTRAR_RESULTADOS_FINAIS == 1
                        plotarResultadosFinais(imagemInicialDaCamera, imagemAposReconhecimento, ...
                            plotDaElipse, BoundingBox);
                    end

                    imagemCortada = imcrop(imagemInicialDaCamera, BoundingBox);

                    imagemCortadaEm80por60RGB = imresize(imagemCortada, [80 60]);
                    
                else
                    
                    temRostoNaImagem = 0;
                    imagemCortadaEm80por60RGB = imresize(imagemInicialDaCamera, [80 60]);
                end
            
            else
                
                temRostoNaImagem = 0;
                imagemCortadaEm80por60RGB = imresize(imagemInicialDaCamera, [80 60]);
                
            end
                
        else
            
            temRostoNaImagem = 0;
            imagemCortadaEm80por60RGB = imresize(imagemInicialDaCamera, [80 60]);
        end
  
        
    end

end

