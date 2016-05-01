
clear entrada_foto;
clear img;
clear img_small;
clear img_crop;
clear pequena;

video = videoinput('winvideo', 1);  % Inicia webcam do laptop.
set(video, 'ReturnedColorSpace', 'RGB');
img = getsnapshot(video);
img_small= imresize(img, [150 187.5], 'bilinear');  % Imagem desejada
imagesc(img_small)
img_crop = img_small(24:102,58:122);
colormap('gray')

entrada2 = cell(4*n_fotos, 1);  % Primeira celula de armazenamento de imagens
entrada2{1,1} = img_crop;

celulaux2 = cell(4*n_fotos, 1);

celulaux2{1} = imresize(entrada2{1}, [40 32],'bilinear');

inputs2 =zeros(4*n_fotos, 1280);

inputs2(1,:) = reshape(celulaux2{1}, 1280, 1);

[maximo, posicao] = max(net(inputs2(1,:)'))

switch posicao
    
    case 1
        
        disp('OLÁ JULIO');
        
    case 2
        
        disp('OLÁ LUCAS VAZQUEZ');
        
    case 3
        
        disp('OLÁ MATHEUS');
        
    otherwise
        
        disp('VOCÊ NÃO É MEU MESTRE');
        
end