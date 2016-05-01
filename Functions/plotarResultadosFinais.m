function [ ] = plotarResultadosFinais(imagemInicialDaCamera, imagemAposReconhecimento, plotDaElipse, BoundingBox)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here

    figure('Name', 'Resultado Final');
    suptitle('RESULTADO FINAL')
    subplot(2,2,1)

    imshow(imagemInicialDaCamera);
    title('Imagem original')

    subplot(2,2,2)

    imshow(uint8(imagemAposReconhecimento));
    title('Reconhecimento Facial')

    subplot(2,2,3)

    imshow(imagemInicialDaCamera)
    hold on
    plot(plotDaElipse(:,1),plotDaElipse(:,2),'g','LineWidth',5)
    title('Elipse no rosto')
    
    hold off
    
    subplot(2,2,4)

    imshow(imagemInicialDaCamera)
    hold on
    rectangle('Position',BoundingBox,'LineWidth',5,'LineStyle','-','EdgeColor','r');
    title('Retângulo no rosto')
    
    hold off

end

