% Reshaping the input vector for neuralnetwork training:


inputs =zeros(4*n_fotos, 1280);
celulaux = cell(4*n_fotos, 1);

for i = 1:4*n_fotos
    
    celulaux{i} = imresize(entrada{i}, [40 32],'bilinear');
    inputs(i,:) = reshape(celulaux{i}, 1280, 1);
    
end



